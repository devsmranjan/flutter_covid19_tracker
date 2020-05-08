import 'dart:io';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/download/download.dart';
import 'package:covid19_tracker/store/keys/keys.dart';
import 'package:covid19_tracker/store/update_later/update_later.dart';
import 'package:covid19_tracker/util/progress_dialog/progress_dialog.dart';
import 'package:covid19_tracker/util/update_dialog/update_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateGlobal {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final KeysStore _keysStore = KeysStore();
  final UpdateLaterStore _updateLaterStore = UpdateLaterStore();

  final DownloadStore _downloadStore = DownloadStore();

  Permission _storagePermission = Permission.storage;

  final _uploadLocation = "/sdcard/download/COVID-19 Tracker/APKs/app.apk";

  Future _downloadApk(String url) async {
    Dio _dio = Dio();
    bool checkStoragePermission = await _storagePermission.isGranted;

    if (!checkStoragePermission) {
      await _storagePermission.request();
      checkStoragePermission = await _storagePermission.isGranted;
    }

    if (checkStoragePermission) {
      showDialog<SimpleDialog>(
          context: _keysStore.homeScaffoldKey.currentContext,
          barrierDismissible: false,
          builder: (context) => SimpleDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: NeumorphicTheme.baseColor(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  children: <Widget>[
                    ProgressDialog(downloadStore: _downloadStore),
                  ]));

      try {
        _downloadStore.reset();
        _downloadStore.updateDownloading(true);

        await _dio.download(url, _uploadLocation,
            options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
            onReceiveProgress: (rec, total) {
          print("Recived: $rec, Total: $total");
          if (total != -1) {
            _downloadStore.updateDownloadedSize(rec.toDouble());
            _downloadStore.updateTotalSize(total.toDouble());
          }

          if (_downloadStore.downloadPercentage >= 100) {
            Future.delayed(
                Duration(milliseconds: 1000),
                () =>
                    {Navigator.pop(_keysStore.homeScaffoldKey.currentContext)});
          }
        });
        _downloadStore.updateDownloading(false);
        _installApk();
      } catch (e) {
        print(e.toString());
      }
    }

    _downloadStore.updateDownloading(false);
  }

  Future _installApk() async {
    InstallPlugin.installApk(
            _uploadLocation, 'io.github.devsmranjan.covid19_tracker')
        .then((result) {
      print('install apk $result');
    }).catchError((error) {
      print('install apk error: $error');
    });
  }

  Future handleUpdateAvailable() async {
    await showDialog(
        context: _keysStore.homeScaffoldKey.currentContext,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                UpdateDialog(),
                SizedBox(
                  height: 24,
                ),
              ],
              backgroundColor: NeumorphicTheme.baseColor(context),
              contentPadding: EdgeInsets.all(18),
            ));

    if (_updateLaterStore.isUpdateNow) {
      await _downloadApk("${_apiDataStore.appVersionsData.latestAppLink}");
    }
  }
}
