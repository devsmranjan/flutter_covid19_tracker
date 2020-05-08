import 'package:covid19_tracker/api/covid_19_india/all_data_model/state_districts_data_model.dart';
import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/util/data_container/data_container.dart';
import 'package:covid19_tracker/util/header_2_container/header_2_container.dart';
import 'package:flutter/material.dart';

class DistrictDataContainer extends StatelessWidget {
  final DistrictData districtData;
  final Zone zone;

  const DistrictDataContainer(
      {Key key, @required this.districtData, @required this.zone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header2Container(
          title: districtData.district,
          isDistrict: true,
          lastUpdatedTime: "",
          zone: zone,
          color: Color(0xFF808e9b),
        ),
        Column(
          children: <Widget>[
            DataContainer(
              title: "Confirmed",
              totalCases: districtData.confirmed.toString(),
              newCases: districtData.delta.confirmed.toString(),
              color: ColorConstants.COLOR_CONFIRMED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Active",
              totalCases: districtData.active.toString(),
              color: ColorConstants.COLOR_ACTIVE,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Recovered",
              totalCases: districtData.recovered.toString(),
              newCases: districtData.delta.recovered.toString(),
              color: ColorConstants.COLOR_RECOVERED,
            ),
            SizedBox(
              height: 14.0,
            ),
            DataContainer(
              title: "Deceased",
              totalCases: districtData.deceased.toString(),
              newCases: districtData.delta.deceased.toString(),
              color: ColorConstants.COLOR_DECEASED,
            ),
          ],
        ),
      ],
    );
  }
}
