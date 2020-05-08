import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/global/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Header2Container extends StatelessWidget {
  final String title;
  final String lastUpdatedTime;
  final Color color;
  final bool isDistrict;
  final Zone zone;

  const Header2Container({
    Key key,
    @required this.title,
    @required this.lastUpdatedTime,
    @required this.color,
    this.isDistrict = false,
    this.zone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isDistrict && zone != null
            ? Icon(
                LineAwesomeIcons.flag,
                color: zone.zone.toLowerCase() == "red"
                    ? ColorConstants.COLOR_RED_ZONE
                    : zone.zone.toLowerCase() == "orange"
                        ? ColorConstants.COLOR_ORANGE_ZONE
                        : ColorConstants.COLOR_GREEN_ZONE,
              )
            : Container(),
        isDistrict
            ? SizedBox(
                height: 2.0,
              )
            : Container(),
        title != ""
            ? Text(title,
                style: GoogleFonts.paytoneOne(fontSize: 28, color: color),
                textAlign: TextAlign.center)
            : Container(),
        SizedBox(
          height: 12.0,
        ),
        lastUpdatedTime != ""
            ? Text(
                "Lastly Updated at $lastUpdatedTime",
                style: TextStyle(
                    fontSize: 12,
                    color: !NeumorphicTheme.isUsingDark(context)
                                ? Colors.black45
                                : Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.center,
              )
            : Container(),
        lastUpdatedTime != ""
            ? SizedBox(
                height: 28.0,
              )
            : Container(),
        isDistrict && zone != null
            ? Text(
                "( ${zone.zone.toUpperCase()} Zone )",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: !NeumorphicTheme.isUsingDark(context) ? Colors.black38 : Colors.white70),
                textAlign: TextAlign.center,
              )
            : Container(),
        isDistrict && zone != null
            ? SizedBox(
                height: 28.0,
              )
            : Container(),
        isDistrict && zone == null
            ? SizedBox(
                height: 14.0,
              )
            : Container()
      ],
    );
  }
}
