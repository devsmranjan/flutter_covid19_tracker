import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class CountryListTile extends StatefulWidget {
  final countryName;
  final confirmed;
  final active;
  final recovered;
  final deaths;
  final deltaConfirmed;
  final deltaDeaths;

  const CountryListTile({
    Key key,
    @required this.countryName,
    @required this.confirmed,
    @required this.active,
    @required this.recovered,
    @required this.deaths,
    @required this.deltaConfirmed,
    @required this.deltaDeaths,
  }) : super(key: key);

  @override
  _CountryListTileState createState() => _CountryListTileState();
}

class _CountryListTileState extends State<CountryListTile> {
  String _confirmed;
  String _active;
  String _recovered;
  String _deaths;
  String _deltaConfirmed;
  String _deltaDeaths;

  @override
  void initState() {
    super.initState();
    _confirmed = widget.confirmed.replaceAllMapped(RegExp(r","), (match) => "");
    _active = widget.active.replaceAllMapped(RegExp(r","), (match) => "");
    _recovered = widget.recovered.replaceAllMapped(RegExp(r","), (match) => "");
    _deaths = widget.deaths.replaceAllMapped(RegExp(r","), (match) => "");
    _deltaConfirmed =
        widget.deltaConfirmed.replaceAllMapped(RegExp(r","), (match) => "");
    _deltaDeaths =
        widget.deltaDeaths.replaceAllMapped(RegExp(r","), (match) => "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              unselectedWidgetColor:
                  NeumorphicTheme.currentTheme(context).accentColor,
              accentColor: Theme.of(context).primaryColor),
          child: ListTileTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: ExpansionTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    widget.countryName != "" ? widget.countryName : "Unknown",
                    style: TextStyle(
                        color: NeumorphicTheme.currentTheme(context)
                            .defaultTextColor),
                  )),
                  Text(
                    "$_confirmed",
                    style: TextStyle(
                        color: NeumorphicTheme.currentTheme(context)
                            .defaultTextColor),
                  ),
                ],
              ),
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 8, right: 12, bottom: 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Confirmed - ",
                                style: TextStyle(
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "${_confirmed.length <= 4 ? _confirmed : NumberFormat.compact().format(int.parse(_confirmed))}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: NeumorphicTheme.currentTheme(
                                                  context)
                                              .defaultTextColor),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "[ ↑ ${_deltaConfirmed.length <= 4 ? _deltaConfirmed : NumberFormat.compact().format(int.parse(_deltaConfirmed))} ]",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Active - ",
                                style: TextStyle(
                                  color: Colors.blue[500],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Text(
                                "${_active.length <= 4 ? _active : NumberFormat.compact().format(int.parse(_active))}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: NeumorphicTheme.currentTheme(context)
                                        .defaultTextColor),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Recovered - ",
                                style: TextStyle(
                                  color: Colors.green[500],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Text(
                                      "${_recovered.length <= 4 ? _recovered : NumberFormat.compact().format(int.parse(_recovered))}",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: NeumorphicTheme.currentTheme(
                                                  context)
                                              .defaultTextColor))),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Deceased - ",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "${_deaths.length <= 4 ? _deaths : NumberFormat.compact().format(int.parse(_deaths))}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: NeumorphicTheme.currentTheme(
                                                context)
                                            .defaultTextColor),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "[ ↑ ${_deltaDeaths.length <= 4 ? _deltaDeaths : NumberFormat.compact().format(int.parse(_deltaDeaths))} ]",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
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
    ));
  }
}
