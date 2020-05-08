import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/util/chart_container/chart_container.dart';
import 'package:covid19_tracker/util/factoids_container/factoids_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/connection/connection.dart';
import '../../util/all_afected_container/all_affected_container.dart';
import '../../util/error_container/error_container.dart';
import '../../util/header_1_container/header_1_container.dart';
import '../../util/location_container/location_container.dart';
import '../../views/affected_countries_page/affected_countries_page.dart';
import '../../store/api_data/api_data.dart';
import 'world_data.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
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
          builder: (_) => _apiDataStore.worldStatisticsData == null &&
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
                        WorldData(),
                        SizedBox(
                          height: 36.0,
                        ),
                        AllAffectedContainer(
                            title: "All affected Countries",
                            color: Colors.green,
                            isEnabled: _apiDataStore.myCountryData != null
                                ? true
                                : false,
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AffectedCountriesPage()))),
                        AnalysisContainer(
                          scrollStore: _scrollStore,
                          loading: _loading,
                          recoveredRate:
                              _apiDataStore.worldStatisticsData != null
                                  ? ((double.tryParse(_apiDataStore
                                                  .worldStatisticsData
                                                  .recovered) /
                                              double.tryParse(_apiDataStore
                                                  .worldStatisticsData
                                                  .confirmed)) *
                                          100)
                                      .toStringAsFixed(2)
                                  : "",
                          deceasedRate:
                              _apiDataStore.worldStatisticsData != null
                                  ? ((double.tryParse(_apiDataStore
                                                  .worldStatisticsData.deaths) /
                                              double.tryParse(_apiDataStore
                                                  .worldStatisticsData
                                                  .confirmed)) *
                                          100)
                                      .toStringAsFixed(2)
                                  : "",
                          datesList: _apiDataStore.worldDailyData != null
                              ? _apiDataStore.worldDailyDataDates
                              : [],
                          confirmedList: _apiDataStore.worldDailyData != null
                              ? _apiDataStore.worldDailyDataTotalConfirmed
                              : [],
                          recoveredList: _apiDataStore.worldDailyData != null
                              ? _apiDataStore.worldDailyDataTotalRecovered
                              : [],
                          deceasedList: _apiDataStore.worldDailyData != null
                              ? _apiDataStore.worldDailyDataTotalDeceased
                              : [],
                        )
                      ])),
        ));
  }
}
