import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/connection/connection.dart';
import '../../util/all_afected_container/all_affected_container.dart';
import '../../util/error_container/error_container.dart';
import '../../util/header_1_container/header_1_container.dart';
import '../../store/api_data/api_data.dart';
import '../affected_districts_page/affected_districts_page.dart';
import 'state_data.dart';
import '../../util/location_container/location_container.dart';

class AreaPage extends StatelessWidget {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final ConnectionStore _connectionStore = ConnectionStore();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Observer(
        builder: (_) => _apiDataStore.myStateData == null &&
                !_connectionStore.isInternetConnected
            ? ErrorContainer()
            : Container(
                margin: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Header1Container(),
                    LocationContainer(),
                    SizedBox(
                      height: 36.0,
                    ),
                    StateData(),
                    SizedBox(
                      height: 36.0,
                    ),
                    AllAffectedContainer(
                        title: "All affected Districts",
                        isEnabled:
                            _apiDataStore.myStateData != null ? true : false,
                        color: Colors.purple,
                        action: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffectedDistrictPage())))
                  ],
                ),
              ),
      ),
    );
  }
}
