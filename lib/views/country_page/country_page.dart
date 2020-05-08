import 'package:covid19_tracker/store/connection/connection.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/all_afected_container/all_affected_container.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/util/error_container/error_container.dart';
import 'package:covid19_tracker/util/factoids_container/factoids_container.dart';
import 'package:covid19_tracker/util/header_1_container/header_1_container.dart';
import 'package:covid19_tracker/util/location_container/location_container.dart';
import 'package:covid19_tracker/views/affected_states_page/affected_states_page.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../store/api_data/api_data.dart';

import 'country_data.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  ScrollController _scrollController;

  final ApiDataStore _apiDataStore = ApiDataStore();
  final ConnectionStore _connectionStore = ConnectionStore();

  final ScrollStore _scrollStore = ScrollStore();

  final Loading _loading = Loading();

  _scrollListener() {
    _scrollStore.updateScrollReached(
        _scrollController, _scrollController.position.maxScrollExtent - 400);

    if (_scrollStore.scrollReachedTimes == 1) {
      _loading.startLoading1000();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: _scrollController,
        child: Observer(
          builder: (_) => _apiDataStore.myCountryData == null &&
                  !_connectionStore.isInternetConnected
              ? ErrorContainer()
              : Container(
                  margin: const EdgeInsets.only(
                      left: 18.0, right: 18.0, bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Header1Container(),
                      FactoidsContainer(),
                      SizedBox(
                        height: 28.0,
                      ),
                      CountryData(),
                      SizedBox(
                        height: 36.0,
                      ),
                      AllAffectedContainer(
                          title: "All affected States",
                          isEnabled:
                              _apiDataStore.allStatesDistrictsData != null
                                  ? true
                                  : false,
                          color: Colors.blue,
                          action: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AffectedStatesPage()))),
                      AnalysisContainer(
                        scrollStore: _scrollStore,
                        loading: _loading,
                        recoveredRate: _apiDataStore.myCountryData != null
                            ? ((double.tryParse(_apiDataStore
                                            .myCountryData.recovered) /
                                        double.tryParse(_apiDataStore
                                            .myCountryData.confirmed)) *
                                    100)
                                .toStringAsFixed(2)
                            : "",
                        deceasedRate: _apiDataStore.myCountryData != null
                            ? ((double.tryParse(_apiDataStore
                                            .myCountryData.deaths) /
                                        double.tryParse(_apiDataStore
                                            .myCountryData.confirmed)) *
                                    100)
                                .toStringAsFixed(2)
                            : "",
                        datesList: _apiDataStore
                            .mapOfIndivisualListOfCaseTimeSeries['dates'],
                        confirmedList:
                            _apiDataStore.mapOfIndivisualListOfCaseTimeSeries[
                                'totalConfirmed'],
                        recoveredList:
                            _apiDataStore.mapOfIndivisualListOfCaseTimeSeries[
                                'totalRecovered'],
                        deceasedList:
                            _apiDataStore.mapOfIndivisualListOfCaseTimeSeries[
                                'totalDeceased'],
                      )
                    ],
                  )),
        ));
  }
}
