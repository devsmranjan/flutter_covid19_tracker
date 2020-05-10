import 'package:covid19_tracker/api/covid_19_india/all_data_model/resources_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EssentialsContainer extends StatelessWidget {
  final Resource essential;

  const EssentialsContainer(
      {Key key, @required this.essential})
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
                    
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 8),
                    child: Text(essential.city,
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
