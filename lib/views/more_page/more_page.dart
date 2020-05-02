import 'dart:io';

import 'package:covid19_tracker/global/update_global.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import '../../store/api_data/api_data.dart';
import '../../store/dark_mode/dark_mode.dart';
import '../../util/more_listtile/more_listtile.dart';
import '../../views/donate_page/donate_page.dart';
import '../../views/helplines_page/helplines_page.dart';
import '../../views/self_risk_scan/self_risk_scan.dart';
import '../../views/tweets_page/tweets_page.dart';
import '../../views/about_page/about_page.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final DarkModeStore _darkModeStore = DarkModeStore();
  final UpdateGlobal _updateGlobal = UpdateGlobal();

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareApp() {
    Share.text(
        'COVID-19 Tracker',
        'I am loving this app 😍. Download COVID-19 Tracker app to get track over Corona from all over the World.\nAndroid: ${_apiDataStore.appVersionsData.latestAppLink}\nLets fight against Corona together.',
        'text/plain');
  }

  // Future _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                        MoreListTile(
                            title: "Self Risk Scan",
                            icon: LineAwesomeIcons.stethoscope,
                            iconColor: Color(0xFF1e9228),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelfRiskScan()))),
                        SizedBox(
                          height: 18.0,
                        ),
                        MoreListTile(
                            title: "Tweets",
                            icon: LineAwesomeIcons.twitter,
                            iconColor: Color(0xFF379DEC),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TweetsPage(
                                          twitterProfileName:
                                              "Ministry of Health",
                                          twitterId: "MoHFW_INDIA",
                                          isDarkMode:
                                              NeumorphicTheme.isUsingDark(
                                                  context),
                                        )))),
                        Observer(
                          builder: (_) =>
                              _apiDataStore.twitterHandleOfMyState != null
                                  ? SizedBox(
                                      height: 18.0,
                                    )
                                  : Container(),
                        ),
                        Observer(
                          builder: (_) => _apiDataStore
                                      .twitterHandleOfMyState !=
                                  null
                              ? MoreListTile(
                                  title:
                                      "@${_apiDataStore.twitterHandleOfMyState.twitterId}",
                                  icon: LineAwesomeIcons.twitter,
                                  iconColor: Color(0xFF379DEC),
                                  action: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TweetsPage(
                                                twitterProfileName:
                                                    _apiDataStore
                                                        .twitterHandleOfMyState
                                                        .twitterProfileName,
                                                twitterId: _apiDataStore
                                                    .twitterHandleOfMyState
                                                    .twitterId,
                                                isDarkMode:
                                                    NeumorphicTheme.isUsingDark(
                                                        context),
                                              ))))
                              : Container(),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        MoreListTile(
                            title: "Donate",
                            icon: LineAwesomeIcons.rupee,
                            iconColor: Color(0xFF8bc34a),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonatePage()))),
                        SizedBox(
                          height: 18.0,
                        ),
                        MoreListTile(
                            title: "Helplines",
                            icon: LineAwesomeIcons.phone,
                            iconColor: Color(0xFF673ab7),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelplinesPage()))),
                        SizedBox(
                          height: 24.0,
                        ),
                        MoreListTile(
                            title: "Essentials",
                            icon: LineAwesomeIcons.hand_stop_o,
                            iconColor: Color(0xFFff9800),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelplinesPage()))),
                        SizedBox(
                          height: 24.0,
                        ),
                        Neumorphic(
                          boxShape: NeumorphicBoxShape.roundRect(
                              borderRadius: BorderRadius.circular(14)),
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat, depth: -4),
                          child: Container(height: 4),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        MoreListTile(
                            title: "Share this App",
                            icon: LineAwesomeIcons.share_alt,
                            iconColor: Color(0xFFe91e63),
                            action: () => _shareApp()),
                        SizedBox(
                          height: 18.0,
                        ),
                        MoreListTile(
                            title: "About this App",
                            icon: LineAwesomeIcons.info,
                            iconColor: Color(0xFF607d8b),
                            action: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutPage()))),
                        Observer(
                          builder: (_) => !_apiDataStore.isVersionMatched
                              ? SizedBox(
                                  height: 18.0,
                                )
                              : Container(),
                        ),
                        Observer(
                          builder: (_) => !_apiDataStore.isVersionMatched
                              ? MoreListTile(
                                  title: "Update Available",
                                  icon: LineAwesomeIcons.download,
                                  iconColor: Color(0xFF304ffe),
                                  action: () async {
                                    _updateGlobal.handleUpdateAvailable();
                                  })
                              : Container(),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("Beast mode",
                                    style: GoogleFonts.paytoneOne(
                                        fontSize: 24,
                                        color: NeumorphicTheme.currentTheme(
                                                context)
                                            .defaultTextColor)),
                              ),
                              NeumorphicSwitch(
                                height: 28,
                                value: NeumorphicTheme.isUsingDark(context),
                                isEnabled: true,
                                onChanged: (value) async {
                                  NeumorphicTheme.of(context).usedTheme =
                                      NeumorphicTheme.isUsingDark(context)
                                          ? UsedTheme.LIGHT
                                          : UsedTheme.DARK;

                                  _darkModeStore.updateDarkMode(
                                      !NeumorphicTheme.isUsingDark(context));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
