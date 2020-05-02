import 'package:covid19_tracker/api/novel_covid/cases_by_country_data_model.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/analysis_container/analysis_container.dart';
import 'package:covid19_tracker/util/chart_container/chart_container.dart';
import 'package:covid19_tracker/views/country_inner_page/country_data_container.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';

class CountryInnerPage extends StatefulWidget {
  final CountryData countryData;

  const CountryInnerPage({Key key, @required this.countryData})
      : super(key: key);

  @override
  _CountryInnerPageState createState() => _CountryInnerPageState();
}

class _CountryInnerPageState extends State<CountryInnerPage> {
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
    _apiDataStore.fetchCountryDaily(
        countryName: widget.countryData.countryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 24.0),
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
                            style:
                                NeumorphicStyle(shape: NeumorphicShape.convex),
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
                            style:
                                NeumorphicStyle(shape: NeumorphicShape.convex),
                            boxShape: NeumorphicBoxShape.circle(),
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(LineAwesomeIcons.home,
                                color: NeumorphicTheme.currentTheme(context)
                                    .accentColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(
                            height: 36.0,
                          ),
                          CountryDataContainer(countryData: widget.countryData),
                          AnalysisContainer(
                            scrollStore: _scrollStore,
                            loading: _loading,
                            recoveredRate: widget.countryData != null
                                ? ((widget.countryData.recovered /
                                            widget.countryData.confirmed) *
                                        100)
                                    .toStringAsFixed(2)
                                : "",
                            deceasedRate: _apiDataStore.myStateData != null
                                ? ((widget.countryData.deaths /
                                            widget.countryData.confirmed) *
                                        100)
                                    .toStringAsFixed(2)
                                : "",
                            datesList: _apiDataStore.countryDailyDataDates,
                            confirmedList:
                                _apiDataStore.countryDailyDataTotalConfirmed,
                            recoveredList:
                                _apiDataStore.countryDailyDataTotalRecovered,
                            deceasedList:
                                _apiDataStore.countryDailyDataTotalDeceased,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
