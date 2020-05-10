import 'package:covid19_tracker/api/covid_19_india/all_data_model/resources_model.dart';
import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/views/essentials_page/essential.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EssentialListTile extends StatelessWidget {
  final Essential essential;

  const EssentialListTile({Key key, @required this.essential})
      : super(key: key);

  _launchURL(String url, BuildContext context, {bool isNumber = false}) async {
    if (isNumber) {
      if (await canLaunch("tel:$url")) {
        Navigator.pop(context);
        await launch("tel:$url");
      } else {
        throw 'Could not launch $url';
      }
    } else {
      if (await canLaunch("$url")) {
        await launch("$url");
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpandableNotifier(
            child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 1),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.only(left: 18, right: 4),
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.top,
                      tapBodyToCollapse: true,
                      tapBodyToExpand: true,
                      iconColor: NeumorphicTheme.accentColor(context),
                    ),
                    header: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        essential.category,
                        style: TextStyle(
                            fontSize: 14, color: Theme.of(context).accentColor),
                      ),
                    ),
                    collapsed: Text(
                      "${essential.nameOfTheOrganisation}, ${essential.city}. ${essential.descriptionAndOrServiceprovided}.",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 12,
                        color: !NeumorphicTheme.isUsingDark(context)
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.8),
                      ),
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${essential.nameOfTheOrganisation}, ${essential.city}. ${essential.descriptionAndOrServiceprovided}.",
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 12,
                            color: !NeumorphicTheme.isUsingDark(context)
                                ? Colors.black.withOpacity(0.4)
                                : Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            NeumorphicButton(
                              onClick: () {
                                if (essential.phoneNumber.length >= 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => SimpleDialog(
                                          backgroundColor:
                                              NeumorphicTheme.baseColor(
                                                  context),
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 4),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          children: essential.phoneNumber
                                              .map(
                                                (phoneNumber) => ListTile(
                                                    onTap: () {
                                                      _launchURL(
                                                          phoneNumber, context,
                                                          isNumber: true);
                                                    },
                                                    title: Text(
                                                      phoneNumber,
                                                      style: TextStyle(
                                                          color: NeumorphicTheme
                                                                  .currentTheme(
                                                                      context)
                                                              .defaultTextColor),
                                                    ),
                                                    leading: Icon(
                                                        LineAwesomeIcons
                                                            .phone_square,
                                                        color: NeumorphicTheme
                                                                .currentTheme(
                                                                    context)
                                                            .accentColor)),
                                              )
                                              .toList()));
                                }
                              },
                              style: NeumorphicStyle(depth: 1),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                LineAwesomeIcons.phone,
                                size: 18,
                                color: NeumorphicTheme.accentColor(context),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            NeumorphicButton(
                              onClick: () {
                                _launchURL(essential.contact, context);
                              },
                              style: NeumorphicStyle(depth: 1),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                LineAwesomeIcons.external_link,
                                size: 18,
                                color: NeumorphicTheme.accentColor(context),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 18, right: 12),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )),
        // Neumorphic(
        //     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        //     style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 1),
        //     child: Container(
        //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        //       child:
        //       ListTile(
        //         contentPadding:
        //             EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        //         onTap: () {},
        //         title: Text(
        //           essential.category,
        //           style: TextStyle(
        //               color: NeumorphicTheme.currentTheme(context)
        //                   .defaultTextColor),
        //         ),
        //       ),
        //     )),

        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
