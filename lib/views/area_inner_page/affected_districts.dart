import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';
import '../../store/loading/loading.dart';
import '../../util/district_listtile/district_listtile.dart';

class AffectedDistricts extends StatefulWidget {
  @override
  _AffectedDistrictsState createState() => _AffectedDistrictsState();
}

class _AffectedDistrictsState extends State<AffectedDistricts> {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final Loading _loading = Loading();

  @override
  void initState() {
    super.initState();
    _loading.startLoading3000();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "Affected Districts",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: NeumorphicTheme.currentTheme(context)
                      .defaultTextColor
                      .withOpacity(0.7),
                  letterSpacing: 1),
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          Observer(
            builder: (_) => !_loading.isLoading &&
                    _apiDataStore.listOfOtherStateDistrictsData != null
                ? Column(
                    children:
                        _apiDataStore.listOfOtherStateDistrictsData.districtData
                            .map((district) => DistrictListTile(
                                  districtName: district.district,
                                  totalConfirmed: district.confirmed,
                                  delta: district.delta,
                                ))
                            .toList(),
                  )
                : Container(
                    height: 72,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          )
          // DistrictListTile()
        ],
      ),
    );
  }
}
