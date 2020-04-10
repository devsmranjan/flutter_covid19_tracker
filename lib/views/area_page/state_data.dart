import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import '../../store/location/location.dart';
import '../../util/header_2_container/header_2_container.dart';
import '../../store/api_data/api_data.dart';
import '../../util/data_container/data_container.dart';


class StateData extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final LocationStore _locationStore = LocationStore();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Header2Container(
            title: _locationStore.state,
            lastUpdatedTime: _apiDataStore.myStateData != null
                ? _apiDataStore.myStateData.lastUpdatedTime
                : "",
            color: Colors.purple[400],
          ),
          Column(
            children: <Widget>[
              DataContainer(
                title: "Confirmed",
                totalCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.confirmed
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.deltaConfirmed
                    : "",
                color: Colors.red,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Active",
                totalCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.active
                        .toString()
                        .padLeft(2, '0')
                    : "",
                color: Colors.blue,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Recovered",
                totalCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.recovered
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.deltaRecovered
                    : "",
                color: Colors.green,
              ),
              SizedBox(
                height: 14.0,
              ),
              DataContainer(
                title: "Deceased",
                totalCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.deaths
                        .toString()
                        .padLeft(2, '0')
                    : "",
                newCases: _apiDataStore.myStateData != null
                    ? _apiDataStore.myStateData.deltaDeaths
                    : "",
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
