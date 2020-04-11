import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = "";

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NeumorphicButton(
                      onClick: () {
                        Navigator.pop(context);
                      },
                      style: NeumorphicStyle(shape: NeumorphicShape.convex),
                      boxShape: NeumorphicBoxShape.circle(),
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(LineAwesomeIcons.long_arrow_left,
                          color: NeumorphicTheme.currentTheme(context)
                              .accentColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text("COVID-19 Tracker",
                  style: GoogleFonts.paytoneOne(
                      fontSize: 24, color: Theme.of(context).accentColor)),
              SizedBox(
                height: 12.0,
              ),
              Text(
                _version != "" ? "Version $_version" : "",
                style: GoogleFonts.paytoneOne(
                    fontSize: 18,
                    color: NeumorphicTheme.defaultTextColor(context)),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                child: Text(
                  "The goal of this project is to make you update about Coronavirus data throughout the World at one place.",
                  style: TextStyle(
                      height: 1.4,
                      color: NeumorphicTheme.defaultTextColor(context)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                child: Text(
                  "This app is based on Covid19India API to get all the data of India and Rapid API to get World's data.",
                  style: TextStyle(
                      height: 1.4,
                      color: NeumorphicTheme.defaultTextColor(context)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 36.0,
              ),
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
                height: 14,
              ),
              Text(
                "Smruti Ranjan Rana",
                style: GoogleFonts.paytoneOne(
                    fontSize: 18.0, color: Theme.of(context).accentColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "App Developer",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NeumorphicButton(
                    child: Icon(LineAwesomeIcons.facebook_f,
                        color: NeumorphicTheme.accentColor(context)),
                    onClick: () {
                      _launchURL("https://www.facebook.com/devsmranjan");
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  NeumorphicButton(
                    child: Icon(LineAwesomeIcons.github,
                        color: NeumorphicTheme.accentColor(context)),
                    onClick: () {
                      _launchURL("https://github.com/devsmranjan");
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  NeumorphicButton(
                    child: Icon(LineAwesomeIcons.linkedin,
                        color: NeumorphicTheme.accentColor(context)),
                    onClick: () {
                      _launchURL("https://www.linkedin.com/in/devsmranjan");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 52,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "Made with ❤️ and ☕️",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: NeumorphicTheme.defaultTextColor(context),
                      fontWeight: FontWeight.bold,
                      height: 1.6),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
