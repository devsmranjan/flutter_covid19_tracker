import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'dart:convert';
import '../../store/api_data/api_data.dart';
import '../../store/loading/loading.dart';

import 'chart_theme.dart' show chartThemeScript;
import 'chart_theme_dark.dart' show chartThemeDark;

class ChartContainer extends StatefulWidget {
  final ScrollStore scrollStore;
  final Loading loading;
  final List datesList;
  final List confirmedList;
  final List recoveredList;
  final List deceasedList;

  const ChartContainer({
    Key key,
    @required this.scrollStore,
    @required this.loading,
    @required this.datesList,
    @required this.confirmedList,
    @required this.recoveredList,
    @required this.deceasedList,
  }) : super(key: key);

  @override
  _ChartContainerState createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  final ApiDataStore _apiDataStore = ApiDataStore();

  // Future _getMapOfIndivisualListOfCaseTimeSeries() async {
  //   await _apiDataStore.getMapOfIndivisualListOfCaseTimeSeries();
  //   print(_apiDataStore.mapOfIndivisualListOfCaseTimeSeries);
  // }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -4),
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
      child: Column(
        children: <Widget>[
          Container(
            color: NeumorphicTheme.baseColor(context),
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Observer(
              builder: (_) => widget.scrollStore.isScrollReached &&
                      !widget.loading.isLoading &&
                      (widget.datesList != null &&
                          widget.datesList.isNotEmpty) &&
                      (widget.confirmedList != null &&
                          widget.confirmedList.isNotEmpty) &&
                      (widget.recoveredList != null &&
                          widget.recoveredList.isNotEmpty) &&
                      (widget.deceasedList != null &&
                          widget.deceasedList.isNotEmpty)
                  ? Echarts(
                      theme: !NeumorphicTheme.isUsingDark(context)
                          ? 'covid19'
                          : 'covid19-dark',
                      extensions: !NeumorphicTheme.isUsingDark(context)
                          ? [chartThemeScript]
                          : [chartThemeDark],
                      option: '''
  {
    legend: {
        data: ['Confirmed', 'Active', 'Recovered', 'Deceased']
    },
    tooltip: {
        trigger: 'axis'
    },
    grid: {
        left: '-0.1%',
        right: '1%',
        bottom: '10%',
        top: '4%',
        containLabel: false
    },
      xAxis: {
        type: 'category',
        boundaryGap: true,
        data: ${jsonEncode(widget.datesList)}
      },
      yAxis: {
        type: 'value'
      },
      series: [
        {
          type: 'line',
          stack: 'tracker1',
          data: ${jsonEncode(widget.confirmedList)},
          smooth: true
        },
        {
              type: 'line',
              stack: 'tracker2',
              data: [],
              smooth: true
        },
        {
              type: 'line',
              stack: 'tracker3',
              data: ${jsonEncode(widget.recoveredList)},
              smooth: true
        },
        {
              type: 'line',
              stack: 'tracker4',
              data: ${jsonEncode(widget.deceasedList)},
              smooth: true
        },
      ]
    }
''',
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sample linear data type.
