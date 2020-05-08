import 'package:covid19_tracker/global/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';
import '../../util/header_2_container/header_2_container.dart';
import '../../util/data_container/data_container.dart';


class CountryData extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Header2Container(
              title: "India",
              lastUpdatedTime: _apiDataStore.myCountryData != null
                  ? _apiDataStore.myCountryData.lastUpdatedTime
                  : "", color: Colors.blue,),
          Column(
            children: <Widget>[
              DataContainer(
                title: "Confirmed",
                totalCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.confirmed
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.deltaConfirmed
                    : "",
                color: ColorConstants.COLOR_CONFIRMED,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Active",
                totalCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.active
                        .toString()
                        .padLeft(2, '0')
                    : "",
                color: ColorConstants.COLOR_ACTIVE,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Recovered",
                totalCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.recovered
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.deltaRecovered
                    : "",
                color: ColorConstants.COLOR_RECOVERED
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Deceased",
                totalCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.deaths
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myCountryData != null
                    ? _apiDataStore.myCountryData.deltaDeaths
                    : "",
                color: ColorConstants.COLOR_DECEASED,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
