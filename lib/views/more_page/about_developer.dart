import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloper extends StatelessWidget {
  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Neumorphic(
              boxShape: NeumorphicBoxShape.circle(),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                depth: 4,
              ),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Image.asset(
                  'assets/images/developer.jpeg',
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(
            height: 18,
          ),
          Text(
            "Smruti Ranjan Rana",
            style: GoogleFonts.paytoneOne(
                fontSize: 18.0, color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "@devsmranjan",
              style: TextStyle(
                  fontSize: 14.0,
                  color: NeumorphicTheme.defaultTextColor(context),
                  fontWeight: FontWeight.bold,
                  height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Wrap(
            children: <Widget>[
              NeumorphicButton(
                boxShape: NeumorphicBoxShape.circle(),
                child: Icon(LineAwesomeIcons.facebook_f,
                    color: NeumorphicTheme.accentColor(context)),
                onClick: () {
                  _launchURL("https://www.facebook.com/devsmranjan");
                },
              ),
              NeumorphicButton(
                boxShape: NeumorphicBoxShape.circle(),
                child: Icon(LineAwesomeIcons.github,
                    color: NeumorphicTheme.accentColor(context)),
                onClick: () {
                  _launchURL("https://github.com/devsmranjan");
                },
              ),
              NeumorphicButton(
                boxShape: NeumorphicBoxShape.circle(),
                child: Icon(LineAwesomeIcons.linkedin,
                    color: NeumorphicTheme.accentColor(context)),
                onClick: () {
                  _launchURL("https://www.linkedin.com/in/devsmranjan");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
