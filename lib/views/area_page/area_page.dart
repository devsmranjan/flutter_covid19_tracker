import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/util/chart_container/chart_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/connection/connection.dart';
import '../../util/all_afected_container/all_affected_container.dart';
import '../../util/error_container/error_container.dart';
import '../../util/header_1_container/header_1_container.dart';
import '../../store/api_data/api_data.dart';
import '../affected_districts_page/affected_districts_page.dart';
import 'state_data.dart';
import '../../util/location_container/location_container.dart';

class AreaPage extends StatefulWidget {
  @override
  _AreaPageState createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
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
        builder: (_) => _apiDataStore.myStateData == null &&
                !_connectionStore.isInternetConnected
            ? ErrorContainer()
            : Container(
                margin: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Header1Container(),
                    LocationContainer(),
                    SizedBox(
                      height: 36.0,
                    ),
                    StateData(),
                    SizedBox(
                      height: 36.0,
                    ),
                    AllAffectedContainer(
                        title: "All affected Districts",
                        isEnabled:
                            _apiDataStore.myStateData != null ? true : false,
                        color: Colors.purple,
                        action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffectedDistrictPage()))),
                    AnalysisContainer(
                      scrollStore: _scrollStore,
                      loading: _loading,
                      recoveredRate: _apiDataStore.myStateData != null
                          ? ((double.tryParse(
                                          _apiDataStore.myStateData.recovered) /
                                      double.tryParse(_apiDataStore
                                          .myStateData.confirmed)) *
                                  100)
                              .toStringAsFixed(2)
                          : "",
                      deceasedRate: _apiDataStore.myStateData != null
                          ? ((double.tryParse(
                                          _apiDataStore.myStateData.deaths) /
                                      double.tryParse(_apiDataStore
                                          .myStateData.confirmed)) *
                                  100)
                              .toStringAsFixed(2)
                          : "",
                      datesList: _apiDataStore.stateDailyDataDates,
                      confirmedList: _apiDataStore.myStateDailyDataTotalConfirmed,
                      recoveredList:  _apiDataStore.myStateDailyDataTotalRecovered,
                      deceasedList: _apiDataStore.myStateDailyDataTotalDeceased,
                    )
                 
                 
                  ],
                ),
              ),
      ),
    );
  }
}
