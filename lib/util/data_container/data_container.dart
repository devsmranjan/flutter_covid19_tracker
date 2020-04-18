import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DataContainer extends StatelessWidget {
  final totalCases;
  final String newCases;
  final title;
  final color;

  const DataContainer(
      {Key key,
      @required this.totalCases,
      this.newCases = "",
      @required this.title,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(14)),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18.0),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 100.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.firaSans(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    color:
                        NeumorphicTheme.currentTheme(context).defaultTextColor),
              ),
              SizedBox(
                width: 18,
              ),
              totalCases != ""
                  ? Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${totalCases.length <= 6 ? NumberFormat.decimalPattern().format(int.parse(totalCases)).padLeft(2, "0") : NumberFormat.compact().format(int.parse(totalCases))}"
                              .toLowerCase(),
                          style: GoogleFonts.fjallaOne(
                              fontSize: 34,
                              color: color,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        newCases != "" && int.tryParse(newCases) != 0
                            ? Text(
                                "+ ${newCases.length <= 4 ? NumberFormat.decimalPattern().format(int.parse(newCases)) : NumberFormat.compact().format(int.parse(newCases))}".toLowerCase(),
                                style: GoogleFonts.fjallaOne(
                                    fontSize: 18,
                                    color: color.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                                textAlign: TextAlign.end,
                              )
                            : Container(),
                        newCases != "" && int.tryParse(newCases) != 0
                            ? SizedBox(
                                height: 12,
                              )
                            : Container(),
                      ],
                    ))
                  : SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
