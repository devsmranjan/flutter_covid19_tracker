import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';
import 'affected_districts.dart';
import 'state_data.dart';


class AreaInnerPage extends StatefulWidget {
  final lastUpdatedTime;
  final stateName;
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
  final ApiDataStore _apiDataStore = ApiDataStore();

  @override
  void initState() {
    super.initState();
    _apiDataStore
        .getListOfOtherStateDistrictsData(stateName: widget.stateName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
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
                          SizedBox(
                            height: 48.0,
                          ),
                          AffectedDistricts(),
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
