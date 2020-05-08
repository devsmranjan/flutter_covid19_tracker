import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/scroll/scroll.dart';
import 'package:covid19_tracker/util/chart_container/chart_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnalysisContainer extends StatelessWidget {
  final ScrollStore scrollStore;
  final Loading loading;
  final String recoveredRate;
  final String deceasedRate;
  final List datesList;
  final List confirmedList;
  final List recoveredList;
  final List deceasedList;

  const AnalysisContainer({
    Key key,
    @required this.scrollStore,
    @required this.loading,
    @required this.recoveredRate,
    @required this.deceasedRate,
    @required this.datesList,
    @required this.confirmedList,
    @required this.recoveredList,
    @required this.deceasedList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("datesList: - " + datesList.toString());
    // print("confirmedList: - " + confirmedList.toString());
    // print("recoveredList: - " + recoveredList.toString());
    // print("deceasedList: - " + deceasedList.toString());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 36.0,
          ),
          ChartContainer(
            scrollStore: scrollStore,
            loading: loading,
            datesList: datesList,
            confirmedList: confirmedList,
            recoveredList: recoveredList,
            deceasedList: deceasedList,
          ),
          SizedBox(
            height: 24.0,
          ),
          recoveredRate != ""
              ? Text(
                  "Recovered Rate - $recoveredRate %",
                  style: TextStyle(
                      fontSize: 18,
                      color: NeumorphicTheme.defaultTextColor(context)),
                )
              : Container(),
          SizedBox(
            height: 8.0,
          ),
          deceasedRate != ""
              ? Text(
                  "Deceased Rate - $deceasedRate %",
                  style: TextStyle(
                      // fontSize: 21,
                      //  fontWeight: FontWeight.bold
                      color: NeumorphicTheme.defaultTextColor(context)),
                )
              : Container(),
        ]);
  }
}
