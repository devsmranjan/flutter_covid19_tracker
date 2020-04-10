import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/connection/connection.dart';
import '../../util/all_afected_container/all_affected_container.dart';
import '../../util/error_container/error_container.dart';
import '../../util/header_1_container/header_1_container.dart';
import '../../util/location_container/location_container.dart';
import '../../views/affected_countries_page/affected_countries_page.dart';
import '../../store/api_data/api_data.dart';
import 'world_data.dart';

class WorldPage extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final ConnectionStore _connectionStore = ConnectionStore();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Observer(
      builder: (_) => _apiDataStore.worldStatisticsData == null &&
              !_connectionStore.isInternetConnected
          ? ErrorContainer()
          : Container(
              margin:
                  const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Header1Container(),
                    LocationContainer(),
                    SizedBox(
                      height: 36.0,
                    ),
                    WorldData(),
                    SizedBox(
                      height: 36.0,
                    ),
                    AllAffectedContainer(
                        title: "All affected Countries",
                        color: Colors.green,
                        isEnabled:
                            _apiDataStore.myCountryData != null ? true : false,
                        action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffectedCountriesPage())))
                  ])),
    ));
  }
}
