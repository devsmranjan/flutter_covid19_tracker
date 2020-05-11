import 'dart:convert';

import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/show_alerts/show_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertContainer extends StatefulWidget {
  @override
  _AlertContainerState createState() => _AlertContainerState();
}

class _AlertContainerState extends State<AlertContainer> {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final ShowAlertsStore _showAlertsStore = ShowAlertsStore();
  final Loading _loadingStore = Loading();
  SharedPreferences prefs;

  _getData() async {
    prefs = await SharedPreferences.getInstance();

    // print(prefs.getString("confirmed"));
//
    _apiDataStore.getListOfMyStateDistrictsData(
        stateName: _apiDataStore.myStateData.state);

    _apiDataStore.listOfMyStateDistrictsData.districtData
        .forEach((districtData) {
      if (districtData.delta.confirmed >= 1) {
        _showAlertsStore.confirmed[districtData.district] =
            districtData.delta.confirmed;
      }
      if (districtData.delta.recovered >= 1) {
        _showAlertsStore.recovered[districtData.district] =
            districtData.delta.recovered;
      }
      if (districtData.delta.deceased >= 1) {
        _showAlertsStore.deceased[districtData.district] =
            districtData.delta.deceased;
      }
    });

    var confirmedSortedKeys = _showAlertsStore.confirmed.keys.toList()..sort();
    Map<String, int> confirmedSortedMap = {};
    confirmedSortedKeys.forEach((key) {
      confirmedSortedMap.putIfAbsent(
          key, () => _showAlertsStore.confirmed[key]);
    });

    _showAlertsStore.confirmed = confirmedSortedMap;

    if (_showAlertsStore.confirmed.isNotEmpty &&
        prefs.getString("confirmed") !=
            json.encode(_showAlertsStore.confirmed)) {
      String _alertText = "";

      _showAlertsStore.confirmed.forEach((key, value) {
        _alertText += _showAlertsStore.confirmed.keys.toList().indexOf(key) ==
                _showAlertsStore.confirmed.length - 2
            ? "" + "$value new ${value == 1 ? "case" : "cases"} from $key" + ""
            : _showAlertsStore.confirmed.keys.toList().indexOf(key) ==
                    _showAlertsStore.confirmed.length - 1
                ? " and " +
                    "$value new ${value == 1 ? "case" : "cases"} from $key" +
                    "."
                : "" +
                    "$value new ${value == 1 ? "case" : "cases"} from $key" +
                    ". ";
      });

      _showAlertsStore.updateConfirmedAlertText(_alertText);
      _showAlertsStore.updateShowConfirmedAlert(true);
    }

    var recoveredSortedKeys = _showAlertsStore.recovered.keys.toList()..sort();
    Map<String, int> recoveredSortedMap = {};
    recoveredSortedKeys.forEach((key) {
      recoveredSortedMap.putIfAbsent(
          key, () => _showAlertsStore.recovered[key]);
    });

    _showAlertsStore.recovered = recoveredSortedMap;

    if (_showAlertsStore.recovered.isNotEmpty &&
        prefs.getString("recovered") !=
            json.encode(_showAlertsStore.recovered)) {
      String _alertText = "";

      _showAlertsStore.recovered.forEach((key, value) {
        _alertText += _showAlertsStore.recovered.keys.toList().indexOf(key) ==
                _showAlertsStore.recovered.length - 2
            ? "" + "$value recovered from $key" + ""
            : _showAlertsStore.confirmed.keys.toList().indexOf(key) ==
                    _showAlertsStore.confirmed.length - 1
                ? " and " + "$value recovered from $key" + "."
                : "" + "$value recovered from $key" + ". ";
      });

      _showAlertsStore.updateRecoveredAlertText(_alertText);
      _showAlertsStore.updateShowRecoveredAlert(true);
    }

    var deceasedSortedKeys = _showAlertsStore.deceased.keys.toList()..sort();
    Map<String, int> deceasedSortedMap = {};
    deceasedSortedKeys.forEach((key) {
      deceasedSortedMap.putIfAbsent(key, () => _showAlertsStore.deceased[key]);
    });

    _showAlertsStore.deceased = deceasedSortedMap;
    if (_showAlertsStore.deceased.isNotEmpty &&
        prefs.getString("deceased") != json.encode(_showAlertsStore.deceased)) {
      String _alertText = "";
      print("I am here");
      _showAlertsStore.deceased.forEach((key, value) {
        _alertText += _showAlertsStore.deceased.keys.toList().indexOf(key) ==
                _showAlertsStore.deceased.length - 2
            ? "" +
                "$value new ${value == 1 ? "death" : "deaths"} from $key" +
                ""
            : _showAlertsStore.deceased.keys.toList().indexOf(key) ==
                    _showAlertsStore.deceased.length - 1
                ? " and " +
                    "$value new ${value == 1 ? "death" : "deaths"} from $key" +
                    "."
                : "" +
                    "$value new ${value == 1 ? "death" : "deaths"} from $key" +
                    ". ";
      });

      _showAlertsStore.updateDeceasedAlertText(_alertText);
      _showAlertsStore.updateShowDeceasedAlert(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadingStore.startLoading1000();
    _getData();
  }

  Widget _alertContainer(
      BuildContext context, String details, Color color, var action) {
    return Column(
      children: <Widget>[
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
            color: color,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    details,
                    style: TextStyle(
                        fontSize: 12, height: 1.5, color: Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                NeumorphicButton(
                  onClick: action,
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex, color: color),
                  boxShape: NeumorphicBoxShape.circle(),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(LineAwesomeIcons.close,
                      size: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => !_loadingStore.isLoading
          ? Column(
              children: [
                _showAlertsStore.showConfirmedAlert
                    ? _alertContainer(
                        context,
                        _showAlertsStore.confirmedAlertText,
                        ColorConstants.COLOR_CONFIRM_ALERT, () async {
                         prefs.setString('confirmed',
                            json.encode(_showAlertsStore.confirmed));
                        _showAlertsStore.updateShowConfirmedAlert(false);
                        _showAlertsStore.updateConfirmedAlertText("");
                      })
                    : Container(),
                _showAlertsStore.showRecoveredAlert
                    ? _alertContainer(
                        context,
                        _showAlertsStore.recoveredAlertText,
                        ColorConstants.COLOR_RECOVERED_ALERT, () async {
                         prefs.setString('recovered',
                            json.encode(_showAlertsStore.recovered));
                        _showAlertsStore.updateShowRecoveredAlert(false);
                        _showAlertsStore.updateRecoveredAlertText("");
                      })
                    : Container(),

                // deceased
                _showAlertsStore.showDeceasedAlert
                    ? _alertContainer(
                        context,
                        _showAlertsStore.deceasedAlertText,
                        ColorConstants.COLOR_DECEASED, () async {
                        _showAlertsStore.updateShowDeceasedAlert(false);
                        _showAlertsStore.updateDeceasedAlertText("");
                         prefs.setString(
                            'deceased', json.encode(_showAlertsStore.deceased));
                      })
                    : Container(),
              ],
            )
          : Container(),
    );
  }
}
