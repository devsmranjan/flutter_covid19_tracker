import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class Header2Container extends StatelessWidget {
  final String title;
  final String lastUpdatedTime;
  final Color color;

  const Header2Container(
      {Key key,
      @required this.title,
      @required this.lastUpdatedTime,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                    // fontWeight: FontWeight.w600,
                    // color: Colors.black54
                    letterSpacing: 0.4, 
                    color:
                        NeumorphicTheme.currentTheme(context).defaultTextColor.withOpacity(0.5)),
                textAlign: TextAlign.center,
              )
            : Container(),
        lastUpdatedTime != ""
            ? SizedBox(
                height: 28.0,
              )
            : Container()
      ],
    );
  }
}
