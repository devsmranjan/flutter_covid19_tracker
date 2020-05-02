import 'dart:io';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/download/download.dart';
import 'package:covid19_tracker/store/keys/keys.dart';
import 'package:covid19_tracker/store/update_later/update_later.dart';
import 'package:covid19_tracker/util/progress_dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatefulWidget {
  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final KeysStore _keysStore = KeysStore();
  UpdateLaterStore _updateLaterStore = UpdateLaterStore();
  ApiDataStore _apiDataStore = ApiDataStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4),
            child: Image.asset("assets/images/update.png"),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Update Available",
            style: GoogleFonts.paytoneOne(
                fontSize: 18.0, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Observer(
            builder: (_) => Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Version ${_apiDataStore.appVersionsData != null ? _apiDataStore.appVersionsData.latestAppVersion : 0}",
                style: TextStyle(
                    fontSize: 14.0,
                    color: NeumorphicTheme.defaultTextColor(context),
                    fontWeight: FontWeight.bold,
                    height: 1.6),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NeumorphicButton(
                child: Text(
                  "Later",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
                onClick: () {
                  _updateLaterStore.updateUpdateLater(true);
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 12,
              ),
              Observer(
                builder: (_) => NeumorphicButton(
                  isEnabled: _apiDataStore.appVersionsData != null,
                  child: Text("Update",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context))),
                  onClick: () {
                    _updateLaterStore.updateUpdateLater(false);
                    _updateLaterStore.updateUpdateNow(true);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
