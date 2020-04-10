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
        Text(
          stateName,
          style:
              GoogleFonts.paytoneOne(fontSize: 28, color: Colors.indigo[400]),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 18.0,
        ),
        lastUpdatedTime != ""
            ? Text(
                "Lastly Updated at $lastUpdatedTime",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color:
                        NeumorphicTheme.currentTheme(context).defaultTextColor),
                textAlign: TextAlign.center,
              )
            : Container(),
        lastUpdatedTime != ""
            ? SizedBox(
                height: 32.0,
              )
            : Container(),
        Column(
          children: <Widget>[
            DataContainer(
              title: "Confirmed",
              totalCases: confirmed.toString().padLeft(2, '0'),
              newCases: deltaConfirmed,
              color: Colors.red,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Active",
              totalCases: active.toString().padLeft(2, '0'),
              color: Colors.blue,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Recovered",
              totalCases: recovered.toString().padLeft(2, '0'),
              newCases: deltaRecovered,
              color: Colors.green,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Deceased",
              totalCases: deaths.toString().padLeft(2, '0'),
              newCases: deltaDeaths,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
