import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../store/location/location.dart';
import '../../store/navbar_index/navbar_index.dart';
import '../../store/api_data/api_data.dart';

class LocationContainer extends StatefulWidget {
  @override
  _LocationContainerState createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  final ApiDataStore _apiDataStore = ApiDataStore();

  final LocationStore _locationStore = LocationStore();
  final NavbarIndexStore _navbarIndexStore = NavbarIndexStore();

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(8)),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
        child: Observer(
          builder: (_) => _apiDataStore.myDistrictData != null
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Neumorphic(
                              boxShape: NeumorphicBoxShape.circle(),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                // depth: -2
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Icon(LineAwesomeIcons.exclamation,
                                  color: _apiDataStore
                                              .myDistrictData.delta.confirmed >=
                                          1
                                      ? Colors.red[500]
                                      : _apiDataStore
                                                  .myDistrictData.confirmed >=
                                              1
                                          ? Colors.orange[400]
                                          : Colors.green[500])),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                              child: Text(
                            "${_apiDataStore.myDistrictData.delta.confirmed >= 1 ? _apiDataStore.myDistrictData.delta.confirmed : "No"} new ${_apiDataStore.myDistrictData.delta.confirmed > 1 || _apiDataStore.myDistrictData.delta.confirmed == 0 ? "cases" : "case"} in ${_apiDataStore.myDistrictData.district}. ${_apiDataStore.myDistrictData.confirmed >= 1 ? "Total " : ""}${_apiDataStore.myDistrictData.confirmed >= 1 ? _apiDataStore.myDistrictData.confirmed : "No"} ${_apiDataStore.myDistrictData.confirmed > 1 || _apiDataStore.myDistrictData.confirmed == 0 ? "cases" : "case"} ${_apiDataStore.myDistrictData.confirmed > 1 || _apiDataStore.myDistrictData.confirmed == 0 ? "have" : "has"} confirmed till now.",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.0,
                                // height: 1.3,
                                color: NeumorphicTheme.currentTheme(context)
                                    .defaultTextColor
                                    .withOpacity(0.5)),
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              : !_apiDataStore.isMyDistrictDataAvailable
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Sorry! Couldn't fetch data for ${_locationStore.dist}.",
                        style: TextStyle(
                            fontSize: 14.0,
                            // height: 1.3,
                            color: NeumorphicTheme.currentTheme(context)
                                .defaultTextColor
                                .withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Fetching data from your location...",
                          style: TextStyle(
                              fontSize: 14.0,
                              // height: 1.3,
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor
                                  .withOpacity(0.5)),
                        ),
                      ),
                    ),
        ));
  }
}
