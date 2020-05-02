import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/download/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProgressDialog extends StatefulWidget {
  final DownloadStore downloadStore;
  final bool isProgressIndicatorNeeded;

  const ProgressDialog(
      {Key key,
      @required this.downloadStore,
      this.isProgressIndicatorNeeded = false})
      : super(key: key);

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  final ApiDataStore _apiDataStore = ApiDataStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        builder: (_) => Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                width: 18,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.downloadStore.downloadPercentage >= 90
                        ? "Almost Done"
                        : widget.downloadStore.downloadPercentage >= 60
                            ? "Few More Seconds"
                            : widget.downloadStore.downloadPercentage >= 30
                                ? "Please Wait"
                                : "Downloading v${_apiDataStore.appVersionsData.latestAppVersion}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: NeumorphicTheme.defaultTextColor(context)),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "${widget.downloadStore.downloadPercentage.toStringAsFixed(0)}%",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: NeumorphicTheme.defaultTextColor(context)),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
