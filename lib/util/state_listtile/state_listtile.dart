import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../api/covid_19_india/all_data_model/data_model.dart';
import '../../views/area_inner_page/area_inner_page.dart';

class StateListTile extends StatefulWidget {
  final StateData stateData;

  const StateListTile({Key key, @required this.stateData}) : super(key: key);

  @override
  _StateListTileState createState() => _StateListTileState();
}

class _StateListTileState extends State<StateListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AreaInnerPage(
                        lastUpdatedTime: widget.stateData.lastUpdatedTime,
                        stateName: widget.stateData.state,
                        stateCode: widget.stateData.stateCode,
                        confirmed: widget.stateData.confirmed,
                        active: widget.stateData.active,
                        recovered: widget.stateData.recovered,
                        deaths: widget.stateData.deaths,
                        deltaConfirmed: widget.stateData.deltaConfirmed,
                        deltaRecovered: widget.stateData.deltaRecovered,
                        deltaDeaths: widget.stateData.deltaDeaths)));
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Text(widget.stateData.state,
                      style: TextStyle(
                          color: NeumorphicTheme.currentTheme(context)
                              .defaultTextColor))),
              Row(
                children: <Widget>[
                  Text(
                    "${widget.stateData.confirmed}",
                    style: TextStyle(
                        color: NeumorphicTheme.currentTheme(context)
                            .defaultTextColor),
                  ),
                  int.parse(widget.stateData.deltaConfirmed) != 0
                      ? SizedBox(
                          width: 8,
                        )
                      : Container(),
                  int.parse(widget.stateData.deltaConfirmed) != 0
                      ? Text(
                          "[ ↑ ${widget.stateData.deltaConfirmed} ]",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),

        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(14)),
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: -10,
          ),
          child: Container(
            height: 4,
          ),
        )
      ],
    );
  }
}
