import 'dart:async';

import '../store/connection/connection.dart';
import '../store/update_later/update_later.dart';
import '../views/more_page/more_page.dart';
import '../views/update_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:package_info/package_info.dart';

import '../store/api_data/api_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:connectivity/connectivity.dart';

import 'world_page/world_page.dart';
import '../store/location/location.dart';
import 'area_page/area_page.dart';
import 'country_page/country_page.dart';
import '../store/navbar_index/navbar_index.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // store
  final ConnectionStore _connectionStore = ConnectionStore();
  final UpdateLaterStore _updateLaterStore = UpdateLaterStore();
  final NavbarIndexStore _navbarIndexStore = NavbarIndexStore();
  final ApiDataStore _apiDataStore = ApiDataStore();

  // check connection
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final _locationStore = LocationStore();
  List<Widget> _allPageWidgets;

  PackageInfo packageInfo;

  Future _onLoad() async {
    packageInfo = await PackageInfo.fromPlatform();

    _updateLaterStore.checkUpdateLater();

    await _apiDataStore.fetchAppVersionsData();
    _apiDataStore.compareVersion(packageInfo.version);

    await _apiDataStore.fetchFactoidsData();
    _apiDataStore.getRandomFactoroid();

    await _locationStore.getLocation();

    if (!_locationStore.isLocationEnabled) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          child: Image.asset("assets/images/no-location.png"),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Location is off",
                          style: GoogleFonts.paytoneOne(
                              fontSize: 18.0,
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            "Please enable location",
                            style: TextStyle(
                                fontSize: 14.0,
                                color:
                                    NeumorphicTheme.defaultTextColor(context),
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
                              child: Text(
                                "Retry",
                                style: TextStyle(
                                    color: NeumorphicTheme.defaultTextColor(
                                        context)),
                              ),
                              onClick: () {
                                Navigator.pop(context);
                                _onLoad();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
                backgroundColor: NeumorphicTheme.baseColor(context),
                contentPadding: EdgeInsets.all(18),
              ));
    }

    await _apiDataStore.fetchAPI1Data();
    await _apiDataStore.fetchAPI1StateDistrictsData();

    _apiDataStore.getStateData(stateName: _locationStore.state);

    await _apiDataStore.fetchStatesDaily();
    _apiDataStore.getStateDaily(stateCode: _apiDataStore.myStateData.stateCode);

    _apiDataStore.getMyDistrictData(
        stateName: _locationStore.state, districtName: _locationStore.dist);
    _apiDataStore.getMapOfIndivisualListOfCaseTimeSeries();

    _apiDataStore.fetchAPI2WorldTotalStatistics();
    _apiDataStore.fetchWorldDaily();

    await _apiDataStore.fetchTwitterHandlesStatewise();
    _apiDataStore.getTwitterHandleOfMyState(_locationStore.state);

    if (!_updateLaterStore.isUpdateLater && !_apiDataStore.isVersionMatched) {
      showDialog(
          context: context,
          builder: (context) => SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  UpdateDialog(),
                  SizedBox(
                    height: 24,
                  ),
                ],
                backgroundColor: NeumorphicTheme.baseColor(context),
                contentPadding: EdgeInsets.all(18),
              ));
    }
  }

  Future _onRefresh() async {
    await _onLoad();

    _apiDataStore.getMapOfIndivisualListOfCaseTimeSeries();
    _apiDataStore.fetchAPI2WorldTotalStatistics();

    print('Page refreshed.');
  }

  @override
  void initState() {
    super.initState();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result != ConnectivityResult.none) {
        _connectionStore.updateInternetConnection(true);
        _onLoad();
      } else {
        _connectionStore.updateInternetConnection(false);
      }
    });

    _allPageWidgets = <Widget>[
      AreaPage(),
      CountryPage(),
      WorldPage(),
      MorePage()
    ];
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: _connectionStore.isInternetConnected
            ? RefreshIndicator(
                displacement: MediaQuery.of(context).padding.top + 10,
                backgroundColor: NeumorphicTheme.baseColor(context),
                child: _allPageWidgets[_navbarIndexStore.selectedIndex],
                onRefresh: _onRefresh)
            : _allPageWidgets[_navbarIndexStore.selectedIndex],
        bottomNavigationBar: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(48)),
          style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -10),
          margin: const EdgeInsets.all(12.0),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: GNav(
                    gap: 4,
                    color: NeumorphicTheme.currentTheme(context).accentColor,
                    iconSize: 18,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    duration: Duration(milliseconds: 500),
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _navbarIndexStore.selectedIndex == 0
                            ? Colors.purple
                            : _navbarIndexStore.selectedIndex == 1
                                ? Colors.blue
                                : _navbarIndexStore.selectedIndex == 2
                                    ? Colors.green
                                    : Colors.cyan,
                        fontSize: 12.0),
                    tabBackgroundColor: _navbarIndexStore.selectedIndex == 0
                        ? Colors.purple[100]
                        : _navbarIndexStore.selectedIndex == 1
                            ? Colors.blue[100]
                            : _navbarIndexStore.selectedIndex == 2
                                ? Colors.green[100]
                                : Colors.cyan[100],
                    activeColor: _navbarIndexStore.selectedIndex == 0
                        ? Colors.purple
                        : _navbarIndexStore.selectedIndex == 1
                            ? Colors.blue
                            : _navbarIndexStore.selectedIndex == 2
                                ? Colors.green
                                : Colors.cyan,
                    tabs: [
                      GButton(
                        icon: LineAwesomeIcons.street_view,
                        text: 'My Area',
                      ),
                      GButton(
                        icon: LineAwesomeIcons.map_o,
                        text: 'India',
                      ),
                      GButton(
                        icon: LineAwesomeIcons.globe,
                        text: 'World',
                      ),
                      GButton(
                        icon: LineAwesomeIcons.bars,
                        text: 'More',
                      ),
                    ],
                    selectedIndex: _navbarIndexStore.selectedIndex,
                    onTabChange: (index) {
                      _navbarIndexStore.updateIndex(index);
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
