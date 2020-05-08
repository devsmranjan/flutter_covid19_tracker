import 'package:covid19_tracker/global/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../util/header_2_container/header_2_container.dart';
import '../../store/api_data/api_data.dart';
import '../../util/data_container/data_container.dart';

class WorldData extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Header2Container(
            title: "World",
            lastUpdatedTime: _apiDataStore.worldStatisticsData != null
                ? DateFormat('dd/MM/yyyy hh:mm:ss').format(
                    DateTime.fromMicrosecondsSinceEpoch(int.parse(
                            _apiDataStore.worldStatisticsData.lastUpdatedTime) *
                        1000))
                : "",
            color: Colors.green,
          ),
          Column(
            children: <Widget>[
              DataContainer(
                title: "Confirmed",
                totalCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.confirmed
                    : "",
                newCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.deltaConfirmed
                    : "",
                color: ColorConstants.COLOR_CONFIRMED,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Active",
                totalCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.active
                    : "",
                color: ColorConstants.COLOR_ACTIVE,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Recovered",
                totalCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.recovered
                    : "",
                color: ColorConstants.COLOR_RECOVERED,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Deceased",
                totalCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.deaths
                    : "",
                newCases: _apiDataStore.worldStatisticsData != null
                    ? _apiDataStore.worldStatisticsData.deltaDeathes
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
