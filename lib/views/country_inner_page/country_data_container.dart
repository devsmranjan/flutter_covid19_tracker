import 'package:covid19_tracker/api/novel_covid/cases_by_country_data_model.dart';
import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/util/header_2_container/header_2_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../util/data_container/data_container.dart';

class CountryDataContainer extends StatelessWidget {
  final CountryData countryData;

  const CountryDataContainer({Key key, @required this.countryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header2Container(
          title: countryData.countryName,
          lastUpdatedTime: DateFormat('dd/MM/yyyy hh:mm:ss').format(
              DateTime.fromMicrosecondsSinceEpoch(
                  countryData.lastUpdatedTime * 1000)),
          color: Colors.blue,
        ),
        Column(
          children: <Widget>[
            DataContainer(
              title: "Confirmed",
              totalCases: countryData.confirmed.toString().padLeft(2, '0'),
              newCases: countryData.deltaConfirmed.toString(),
              color: ColorConstants.COLOR_CONFIRMED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Active",
              totalCases: countryData.active.toString().padLeft(2, '0'),
              color: ColorConstants.COLOR_ACTIVE,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Recovered",
              totalCases: countryData.recovered.toString().padLeft(2, '0'),
              color: ColorConstants.COLOR_RECOVERED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Deceased",
              totalCases: countryData.deaths.toString().padLeft(2, '0'),
              newCases: countryData.deltaDeaths.toString(),
              color: ColorConstants.COLOR_DECEASED,
            ),
          ],
        ),
      ],
    );
  }
}
