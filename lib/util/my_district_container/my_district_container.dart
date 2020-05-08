import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/location/location.dart';
import 'package:covid19_tracker/util/location_container/location_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class MyDistrictContainer extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final LocationStore _locationStore = LocationStore();

  Widget _dataContainer(
      BuildContext context, String title, String value, Color color) {
    return Neumorphic(
      boxShape:
          NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(8)),
      style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -2),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 42.0,
        ),
        child: Center(
          child: _apiDataStore.myDistrictData != null
              ? Column(
                  children: <Widget>[
                    FittedBox(
                      child: Text(value,
                          style: GoogleFonts.firaSansCondensed(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.firaSansCondensed(
                          fontSize: 12,
                          color: NeumorphicTheme.defaultTextColor(context)
                              .withOpacity(0.9)),
                    )
                  ],
                )
              : SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    strokeWidth: 3,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _alertContainer(BuildContext context, String details, Color color) {
    return Column(
      children: <Widget>[
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(8)),
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
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                NeumorphicButton(
                  onClick: () {},
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Observer(
          builder: (_) => Row(
            children: <Widget>[
              Expanded(
                  child: _dataContainer(
                      context,
                      "Confirmed",
                      _apiDataStore.myDistrictData != null
                          ? _apiDataStore.myDistrictData.confirmed
                              .toString()
                              .padLeft(2, '0')
                          : "",
                      ColorConstants.COLOR_CONFIRMED)),
              SizedBox(width: 12),
              Expanded(
                  child: _dataContainer(
                      context,
                      "Recovered",
                      _apiDataStore.myDistrictData != null
                          ? _apiDataStore.myDistrictData.recovered
                              .toString()
                              .padLeft(2, '0')
                          : "",
                      ColorConstants.COLOR_RECOVERED)),
              SizedBox(width: 12),
              Expanded(
                  child: _dataContainer(
                      context,
                      "Deceased",
                      _apiDataStore.myDistrictData != null
                          ? _apiDataStore.myDistrictData.deceased
                              .toString()
                              .padLeft(2, '0')
                          : "",
                      ColorConstants.COLOR_DECEASED)),
            ],
          ),
        ),
        SizedBox(
          height: 28,
        ),
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(8)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 0),
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Icon(LineAwesomeIcons.map_marker,
                      color: !NeumorphicTheme.isUsingDark(context)
                          ? Color(0xFF636e72).withOpacity(0.6)
                          : Colors.white),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    _locationStore.dist != "" && _locationStore.state != ""
                        ? "You are in ${_locationStore.dist}, ${_locationStore.state}"
                        : "fetching your location...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: !NeumorphicTheme.isUsingDark(context)
                          ? Color(0xFF636e72).withOpacity(0.6)
                          : Colors.white,
                      height: 1.5,
                    ),
                  ),
                  _apiDataStore.myDistrictZone != null
                      ? SizedBox(
                          height: 4,
                        )
                      : Container(),
                  _apiDataStore.myDistrictZone != null
                      ? Text(
                          "( ${_apiDataStore.myDistrictZone.zone.toUpperCase()} Zone )",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _apiDataStore.myDistrictZone.zone
                                        .toLowerCase() ==
                                    "red"
                                ? ColorConstants.COLOR_RED_ZONE
                                : _apiDataStore.myDistrictZone.zone
                                            .toLowerCase() ==
                                        "orange"
                                    ? ColorConstants.COLOR_ORANGE_ZONE
                                    : ColorConstants.COLOR_GREEN_ZONE,
                            height: 1.5,
                          ),
                        )
                      : Container(),
                ],
              )),
        ),
        SizedBox(
          height: 28,
        ),
        // _alertContainer(context, "10 new cases from Jajpur",
        //     ColorConstants.COLOR_CONFIRM_ALERT),
        // _alertContainer(context, "2 new recovered from Jajpur",
        //     ColorConstants.COLOR_RECOVERED_ALERT),
        // _alertContainer(context, "1 new death from Jajpur",
        //     ColorConstants.COLOR_DECEASED_ALERT),
      ],
    );
  }
}
