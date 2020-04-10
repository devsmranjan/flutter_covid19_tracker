import 'package:covid19_tracker/store/connection/connection.dart';
import 'package:covid19_tracker/util/all_afected_container/all_affected_container.dart';
import 'package:covid19_tracker/util/error_container/error_container.dart';
import 'package:covid19_tracker/util/header_1_container/header_1_container.dart';
import 'package:covid19_tracker/views/affected_states_page/affected_states_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../store/api_data/api_data.dart';

import '../../util/chart_container/chart_container.dart';
import 'country_data.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final ConnectionStore _connectionStore = ConnectionStore();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Observer(
      builder: (_) => _apiDataStore.myCountryData == null &&
              !_connectionStore.isInternetConnected
          ? ErrorContainer()
          : Container(
              margin:
                  const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Header1Container(),
                  ChartContainer(),
                  SizedBox(
                    height: 36.0,
                  ),
                  CountryData(),
                  SizedBox(
                    height: 36.0,
                  ),
                  AllAffectedContainer(
                      title: "All affected States",
                      isEnabled: _apiDataStore.myStateData != null &&
                              _apiDataStore.allStatesDistrictsData != null
                          ? true
                          : false,
                      color: Colors.blue,
                      action: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AffectedStatesPage())))
                ],
              )),
    ));
  }
}
