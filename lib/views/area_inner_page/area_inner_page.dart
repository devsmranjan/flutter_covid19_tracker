import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/util/chart_container/chart_container.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';
import 'affected_districts.dart';
import 'state_data.dart';

class AreaInnerPage extends StatefulWidget {
  final lastUpdatedTime;
  final stateName;
  final stateCode;
  final confirmed;
  final active;
  final recovered;
  final deaths;
  final deltaConfirmed;
  final deltaRecovered;
  final deltaDeaths;

  const AreaInnerPage(
      {Key key,
      @required this.lastUpdatedTime,
      @required this.stateName,
      @required this.stateCode,
      @required this.confirmed,
      @required this.active,
      @required this.recovered,
      @required this.deaths,
      @required this.deltaConfirmed,
      @required this.deltaRecovered,
      @required this.deltaDeaths})
      : super(key: key);

  @override
  _AreaInnerPageState createState() => _AreaInnerPageState();
}

class _AreaInnerPageState extends State<AreaInnerPage> {
  ScrollController _scrollController;
  final ApiDataStore _apiDataStore = ApiDataStore();
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
    _apiDataStore.getOtherStateDaily(stateCode: widget.stateCode);
    _apiDataStore.getListOfOtherStateDistrictsData(stateName: widget.stateName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin:
                const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      NeumorphicButton(
                        onClick: () {
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(shape: NeumorphicShape.convex),
                        boxShape: NeumorphicBoxShape.circle(),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(LineAwesomeIcons.long_arrow_left,
                            color: NeumorphicTheme.currentTheme(context)
                                .accentColor),
                      ),
                      NeumorphicButton(
                        onClick: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: NeumorphicStyle(shape: NeumorphicShape.convex),
                        boxShape: NeumorphicBoxShape.circle(),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(LineAwesomeIcons.home,
                            color: NeumorphicTheme.currentTheme(context)
                                .accentColor),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 36.0,
                    ),
                    StateData(
                      lastUpdatedTime: widget.lastUpdatedTime,
                      stateName: widget.stateName,
                      confirmed: widget.confirmed,
                      recovered: widget.recovered,
                      active: widget.active,
                      deaths: widget.deaths,
                      deltaConfirmed: widget.deltaConfirmed,
                      deltaDeaths: widget.deltaDeaths,
                      deltaRecovered: widget.deltaRecovered,
                    ),
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
                      confirmedList: _apiDataStore.stateDailyDataTotalConfirmed,
                      recoveredList: _apiDataStore.stateDailyDataTotalRecovered,
                      deceasedList: _apiDataStore.stateDailyDataTotalDeceased,
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    AffectedDistricts(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
