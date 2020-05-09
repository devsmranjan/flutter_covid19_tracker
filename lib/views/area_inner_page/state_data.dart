import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/util/header_2_container/header_2_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/data_container/data_container.dart';

class StateData extends StatelessWidget {
  final lastUpdatedTime;
  final stateName;
  final confirmed;
  final active;
  final recovered;
  final deaths;
  final deltaConfirmed;
  final deltaRecovered;
  final deltaDeaths;

  const StateData(
      {Key key,
      @required this.lastUpdatedTime,
      @required this.stateName,
      @required this.confirmed,
      @required this.active,
      @required this.recovered,
      @required this.deaths,
      @required this.deltaConfirmed,
      @required this.deltaRecovered,
      @required this.deltaDeaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header2Container(
            title: stateName,
            lastUpdatedTime: lastUpdatedTime != "" ? lastUpdatedTime : "",
            color: Colors.purple[400],
          ),
        Column(
          children: <Widget>[
            DataContainer(
              title: "Confirmed",
              totalCases: confirmed.toString().padLeft(2, '0'),
              newCases: deltaConfirmed,
              color: ColorConstants.COLOR_CONFIRMED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Active",
              totalCases: active.toString().padLeft(2, '0'),
              color: ColorConstants.COLOR_ACTIVE,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Recovered",
              totalCases: recovered.toString().padLeft(2, '0'),
              newCases: deltaRecovered,
              color: ColorConstants.COLOR_RECOVERED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Deceased",
              totalCases: deaths.toString().padLeft(2, '0'),
              newCases: deltaDeaths,
              color: ColorConstants.COLOR_DECEASED,
            ),
          ],
        ),
      ],
    );
  }
}
