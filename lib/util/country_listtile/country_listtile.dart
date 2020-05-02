import 'package:covid19_tracker/api/novel_covid/cases_by_country_data_model.dart';
import 'package:covid19_tracker/views/country_inner_page/country_inner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class CountryListTile extends StatelessWidget {
  final CountryData countryData;

  const CountryListTile({Key key, @required this.countryData})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CountryInnerPage(
                            countryData: countryData,
                          )));
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text(countryData.countryName,
                        style: TextStyle(
                            color: NeumorphicTheme.currentTheme(context)
                                .defaultTextColor))),
                Row(
                  children: <Widget>[
                    Text(
                      "${countryData.confirmed}",
                      style: TextStyle(
                          color: NeumorphicTheme.currentTheme(context)
                              .defaultTextColor),
                    ),
                    countryData.deltaConfirmed != 0
                        ? SizedBox(
                            width: 8,
                          )
                        : Container(),
                    countryData.deltaConfirmed != 0
                        ? Text(
                            "[ ↑ ${countryData.deltaConfirmed} ]",
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
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       child: Column(
  //     children: <Widget>[
  //       Theme(
  //         data: Theme.of(context).copyWith(
  //             dividerColor: Colors.transparent,
  //             unselectedWidgetColor:
  //                 NeumorphicTheme.currentTheme(context).accentColor,
  //             accentColor: Theme.of(context).primaryColor),
  //         child: ListTileTheme(
  //           contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
  //           child: ExpansionTile(
  //             title: Row(
  //               children: <Widget>[
  //                 Expanded(
  //                     child: Text(
  //                   widget.countryName != "" ? widget.countryName : "Unknown",
  //                   style: TextStyle(
  //                       color: NeumorphicTheme.currentTheme(context)
  //                           .defaultTextColor),
  //                 )),
  //                 Text(
  //                   "$_confirmed",
  //                   style: TextStyle(
  //                       color: NeumorphicTheme.currentTheme(context)
  //                           .defaultTextColor),
  //                 ),
  //               ],
  //             ),
  //             children: <Widget>[
  //               Container(
  //                   padding: EdgeInsets.only(left: 8, right: 12, bottom: 24),
  //                   child: Align(
  //                     alignment: Alignment.centerRight,
  //                     child: Column(
  //                       children: <Widget>[
  //                         Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "Confirmed - ",
  //                               style: TextStyle(
  //                                 color: Colors.red[500],
  //                                 fontWeight: FontWeight.bold,
  //                                 letterSpacing: 0.8,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 12,
  //                             ),
  //                             Expanded(
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.end,
  //                                 children: <Widget>[
  //                                   Text(
  //                                     "${_confirmed.length <= 4 ? _confirmed : NumberFormat.compact().format(int.parse(_confirmed))}",
  //                                     textAlign: TextAlign.end,
  //                                     style: TextStyle(
  //                                         color: NeumorphicTheme.currentTheme(
  //                                                 context)
  //                                             .defaultTextColor),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 4,
  //                                   ),
  //                                   Text(
  //                                     "[ ↑ ${_deltaConfirmed.length <= 4 ? _deltaConfirmed : NumberFormat.compact().format(int.parse(_deltaConfirmed))} ]",
  //                                     textAlign: TextAlign.end,
  //                                     style: TextStyle(
  //                                         color: Colors.red,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 12),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 12,
  //                         ),
  //                         Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "Active - ",
  //                               style: TextStyle(
  //                                 color: Colors.blue[500],
  //                                 fontWeight: FontWeight.bold,
  //                                 letterSpacing: 0.8,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 8,
  //                             ),
  //                             Expanded(
  //                                 child: Text(
  //                               "${_active.length <= 4 ? _active : NumberFormat.compact().format(int.parse(_active))}",
  //                               textAlign: TextAlign.end,
  //                               style: TextStyle(
  //                                   color: NeumorphicTheme.currentTheme(context)
  //                                       .defaultTextColor),
  //                             )),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 12,
  //                         ),
  //                         Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "Recovered - ",
  //                               style: TextStyle(
  //                                 color: Colors.green[500],
  //                                 fontWeight: FontWeight.bold,
  //                                 letterSpacing: 0.8,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 8,
  //                             ),
  //                             Expanded(
  //                                 child: Text(
  //                                     "${_recovered.length <= 4 ? _recovered : NumberFormat.compact().format(int.parse(_recovered))}",
  //                                     textAlign: TextAlign.end,
  //                                     style: TextStyle(
  //                                         color: NeumorphicTheme.currentTheme(
  //                                                 context)
  //                                             .defaultTextColor))),
  //                           ],
  //                         ),
  //                         SizedBox(
  //                           height: 12,
  //                         ),
  //                         Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "Deceased - ",
  //                               style: TextStyle(
  //                                 color: Colors.grey[500],
  //                                 fontWeight: FontWeight.bold,
  //                                 letterSpacing: 0.8,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 8,
  //                             ),
  //                             Expanded(
  //                                 child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: <Widget>[
  //                                 Text(
  //                                   "${_deaths.length <= 4 ? _deaths : NumberFormat.compact().format(int.parse(_deaths))}",
  //                                   textAlign: TextAlign.end,
  //                                   style: TextStyle(
  //                                       color: NeumorphicTheme.currentTheme(
  //                                               context)
  //                                           .defaultTextColor),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 4,
  //                                 ),
  //                                 Text(
  //                                   "[ ↑ ${_deltaDeaths.length <= 4 ? _deltaDeaths : NumberFormat.compact().format(int.parse(_deltaDeaths))} ]",
  //                                   textAlign: TextAlign.end,
  //                                   style: TextStyle(
  //                                       color: Colors.grey,
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 12),
  //                                 ),
  //                               ],
  //                             )),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ))
  //             ],
  //           ),
  //         ),
  //       ),
  //       Neumorphic(
  //         boxShape: NeumorphicBoxShape.roundRect(
  //             borderRadius: BorderRadius.circular(14)),
  //         style: NeumorphicStyle(
  //           shape: NeumorphicShape.flat,
  //           depth: -10,
  //         ),
  //         child: Container(
  //           height: 4,
  //         ),
  //       )
  //     ],
  //   ));
  // }

}
