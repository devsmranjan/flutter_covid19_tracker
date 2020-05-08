import 'package:covid19_tracker/api/covid_19_india/all_data_model/state_districts_data_model.dart';
import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/views/district_inner_page/district_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DistrictInnerPage extends StatefulWidget {
  final String state;
  final DistrictData districtData;
  final Zone zone;

  const DistrictInnerPage(
      {Key key,
      @required this.state,
      @required this.districtData,
      @required this.zone})
      : super(key: key);

  @override
  _DistrictInnerPageState createState() => _DistrictInnerPageState();
}

class _DistrictInnerPageState extends State<DistrictInnerPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
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
                      child: Icon(LineAwesomeIcons.close,
                          color: NeumorphicTheme.currentTheme(context)
                              .accentColor),
                    ),
                    NeumorphicButton(
                      onClick: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                  DistrictDataContainer(
                    districtData: widget.districtData,
                    zone: widget.zone,
                  ),
                  Observer(builder: (_) {
                    if (_apiDataStore.districtsDaily != null) {
                      _apiDataStore.getDistrictDaily(
                          stateName: "${widget.state}",
                          districtName: widget.districtData.district);
                    }

                    return AnalysisContainer(
                      scrollStore: _scrollStore,
                      loading: _loading,
                      recoveredRate: widget.districtData != null
                          ? ((widget.districtData.recovered /
                                      widget.districtData.confirmed) *
                                  100)
                              .toStringAsFixed(2)
                          : "",
                      deceasedRate: widget.districtData != null
                          ? ((widget.districtData.deceased /
                                      widget.districtData.confirmed) *
                                  100)
                              .toStringAsFixed(2)
                          : "",
                      datesList: _apiDataStore.districtDailyDates != null
                          ? _apiDataStore.districtDailyDates
                          : [],
                      confirmedList:
                          _apiDataStore.districtDailyConfirmed != null
                              ? _apiDataStore.districtDailyConfirmed
                              : [],
                      recoveredList:
                          _apiDataStore.districtDailyRecovered != null
                              ? _apiDataStore.districtDailyRecovered
                              : [],
                      deceasedList: _apiDataStore.districtDailyDeceased != null
                          ? _apiDataStore.districtDailyDeceased
                          : [],
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
