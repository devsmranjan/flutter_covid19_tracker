import 'package:covid19_tracker/api/covid_19_india/all_data_model/state_districts_data_model.dart';
import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/global/color_constants.dart';
import 'package:covid19_tracker/store/show_zones/show_zones.dart';
import 'package:covid19_tracker/views/district_inner_page/district_inner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DistrictListTile extends StatelessWidget {
  final String state;
  final DistrictData districtData;
  final Zone zone;
  final ShowZones showZones;

  const DistrictListTile(
      {Key key,
      @required this.state,
      @required this.districtData,
      @required this.zone,
      @required this.showZones})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
                borderRadius: BorderRadius.circular(8)),
            style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: 1),
            child: Container(
              decoration: BoxDecoration(
                  color: zone != null
                      ? !showZones.isShowZones
                          ? NeumorphicTheme.baseColor(context)
                          : zone.zone.toLowerCase() == "red"
                              ? ColorConstants.COLOR_RED_ZONE.withOpacity(0.2)
                              : zone.zone.toLowerCase() == "orange"
                                  ? ColorConstants.COLOR_ORANGE_ZONE
                                      .withOpacity(0.2)
                                  : ColorConstants.COLOR_GREEN_ZONE
                                      .withOpacity(0.2)
                      : NeumorphicTheme.baseColor(context),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DistrictInnerPage(
                              state: state,
                              districtData: districtData,
                              zone: zone),
                          fullscreenDialog: true));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      districtData.district,
                      style: TextStyle(
                          color: NeumorphicTheme.currentTheme(context)
                              .defaultTextColor),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${districtData.confirmed}",
                          style: TextStyle(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                        districtData.delta.confirmed != 0
                            ? SizedBox(
                                width: 8,
                              )
                            : Container(),
                        districtData.delta.confirmed != 0
                            ? Text(
                                "[ ↑ ${districtData.delta.confirmed} ]",
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
      ),
    );
  }
}
