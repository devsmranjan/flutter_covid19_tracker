import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DistrictListTile extends StatelessWidget {
  final districtName;
  final totalConfirmed;
  final delta;

  const DistrictListTile(
      {Key key,
      @required this.districtName,
      @required this.totalConfirmed,
      @required this.delta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                districtName,
                style: TextStyle(
                    color:
                        NeumorphicTheme.currentTheme(context).defaultTextColor),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$totalConfirmed",
                    style: TextStyle(
                        color: NeumorphicTheme.currentTheme(context)
                            .defaultTextColor),
                  ),
                  delta.confirmed != 0
                      ? SizedBox(
                          width: 8,
                        )
                      : Container(),
                  delta.confirmed != 0
                      ? Text(
                          "[ ↑ ${delta.confirmed} ]",
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
