import 'package:covid19_tracker/api/novel_covid/cases_by_country_data_model.dart';
import 'package:covid19_tracker/views/country_inner_page/country_inner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CountryListTile extends StatelessWidget {
  final CountryData countryData;

  const CountryListTile({Key key, @required this.countryData})
      : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 1),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountryInnerPage(
                              countryData: countryData,
                            )));
              },
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
