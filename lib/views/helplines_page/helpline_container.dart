import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplineContainer extends StatelessWidget {
  final title;
  final List helplines;

  const HelplineContainer(
      {Key key, @required this.title, @required this.helplines})
      : super(key: key);

  void _launchURL(String helpline, BuildContext context) async {
    if (await canLaunch("tel:$helpline")) {
      Navigator.pop(context);
      await launch("tel:$helpline");
    } else {
      throw 'Could not launch $helpline';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Material(
                color: NeumorphicTheme.baseColor(context),
                child: InkWell(
                  onTap: () {
                    if (helplines.length >= 1) {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                              backgroundColor:
                                  NeumorphicTheme.baseColor(context),
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              children: helplines
                                  .map(
                                    (helpline) => ListTile(
                                        onTap: () {
                                          _launchURL(helpline, context);
                                        },
                                        title: Text(
                                          helpline,
                                          style: TextStyle(
                                              color:
                                                  NeumorphicTheme.currentTheme(
                                                          context)
                                                      .defaultTextColor),
                                        ),
                                        leading: Icon(
                                            LineAwesomeIcons.phone_square,
                                            color: NeumorphicTheme.currentTheme(
                                                    context)
                                                .accentColor)),
                                  )
                                  .toList()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 8),
                    child: Text(title,
                        style: GoogleFonts.paytoneOne(
                            fontSize: 22,
                            color: NeumorphicTheme.currentTheme(context)
                                .defaultTextColor)),
                  ),
                ),
              ),
            ),
          ],
        ),
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(14)),
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
