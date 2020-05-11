import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/connection/connection.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/location/location.dart';
import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/store/show_zones/show_zones.dart';
import 'package:covid19_tracker/store/zones_filter/zones_filter.dart';
import 'package:covid19_tracker/util/district_listtile/district_listtile.dart';
import 'package:covid19_tracker/util/error_container/error_container.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ZonesPage extends StatefulWidget {
  @override
  _ZonesPageState createState() => _ZonesPageState();
}

class _ZonesPageState extends State<ZonesPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  SearchStore _searchStore = SearchStore();
  final Loading _loadingStore = Loading();
  final LocationStore _locationStore = LocationStore();
  final ZonesFilter _zonesFilterStore = ZonesFilter();
  final ShowZones _showZones = ShowZones();

  Future _getData() async {
    if (_apiDataStore.myStateZonesList == null) {
      await _apiDataStore.fetchAPI1ZonesData();
    }

    _zonesFilterStore.updateFilterState(_locationStore.state);
    _zonesFilterStore.updateFilterZone("All zones");

    _apiDataStore.getOtherStateZoneData(
        stateName: _zonesFilterStore.filterState);

    List list = [];
    _apiDataStore.otherStateZonesList
        .where((zoneData) =>
            zoneData.state.toLowerCase() ==
            _zonesFilterStore.filterState.toLowerCase())
        .forEach((data) {
      list.add(data);
    });
    _searchStore.addObservableList(list);
  }

  @override
  void initState() {
    super.initState();
    _showZones.updateShowZones(true);
    _getData();
    _loadingStore.startLoading3000();
  }

  Widget _bottomSheet() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: NeumorphicTheme.baseColor(context),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4))),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 4,
              width: 36,
              decoration: BoxDecoration(
                  color: NeumorphicTheme.accentColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24)),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Center(
                  child: Text(
                "Filter Districts",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),
            ),
            SizedBox(
              height: 28,
            ),
            Observer(
              builder: (_) => Neumorphic(
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -1),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: NeumorphicTheme.baseColor(context),
                  hint: Text("Select State"),
                  underline: Container(),
                  value: _zonesFilterStore.filterState,
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                  iconEnabledColor: NeumorphicTheme.accentColor(context),
                  items: _apiDataStore.zonesStateList.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Container(child: Text(state)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _zonesFilterStore.updateFilterState(value);
                    _zonesFilterStore.updateFilterZone("All zones");
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Observer(
              builder: (_) {
                List<String> _zones = ["All zones", "Red", "Orange", "Green"];

                return Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  style:
                      NeumorphicStyle(shape: NeumorphicShape.flat, depth: -1),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: NeumorphicTheme.baseColor(context),
                    hint: Text("Select Zone"),
                    underline: Container(),
                    style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(context)),
                    iconEnabledColor: NeumorphicTheme.accentColor(context),
                    value: _zonesFilterStore.filterZone,
                    items: _zones.map((var zone) {
                      return DropdownMenuItem<String>(
                        value: zone,
                        child: Container(child: Text(zone)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _zonesFilterStore.updateFilterZone(value);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            NeumorphicButton(
              onClick: () {
                _loadingStore.startLoading2000();
                Navigator.pop(context);
                _apiDataStore.getOtherStateZoneData(
                    stateName: _zonesFilterStore.filterState);
                _searchStore.clearObservableList();

                List list = [];
                _apiDataStore.otherStateZonesList
                    .where((zoneData) =>
                        _zonesFilterStore.filterZone.toLowerCase() ==
                                "all zones"
                            ? true
                            : zoneData.zone.toLowerCase() ==
                                _zonesFilterStore.filterZone.toLowerCase())
                    .forEach((data) {
                  list.add(data);
                });
                _searchStore.addObservableList(list);
              },
              child: Text(
                "Filter",
                style: TextStyle(
                    color: NeumorphicTheme.accentColor(context),
                    letterSpacing: 0.4),
              ),
            ),
            SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NeumorphicButton(
                      onClick: () {
                        Navigator.pop(context);
                      },
                      style: NeumorphicStyle(shape: NeumorphicShape.convex),
                      boxShape: NeumorphicBoxShape.circle(),
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(LineAwesomeIcons.long_arrow_left,
                          color: NeumorphicTheme.currentTheme(context)
                              .accentColor),
                    ),
                    Observer(
                      builder: (_) => NeumorphicButton(
                        onClick: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => _bottomSheet());
                        },
                        isEnabled: _apiDataStore.otherStateZonesList != null &&
                            _searchStore.observableList != null,
                        style: NeumorphicStyle(shape: NeumorphicShape.convex),
                        boxShape: NeumorphicBoxShape.circle(),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(LineAwesomeIcons.filter,
                            color: NeumorphicTheme.currentTheme(context)
                                .accentColor),
                      ),
                    ),
                  ],
                ),
              ),
              Observer(
                  builder: (_) => Header3Container(
                      title:
                          "${_zonesFilterStore.filterState != "" ? _zonesFilterStore.filterState : "Zones"}")),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SearchBar(
                      searchStore: _searchStore, title: "Search any keyword"),
              Observer(builder: (_) {
                List<Zone> _searchList = [];
                if (_searchStore.observableList != null) {
                  _searchStore.observableList.forEach((searchData) {
                    if (searchData.district.toLowerCase().contains(
                            _searchStore.searchFilterText.toLowerCase()) ||
                        searchData.zone.toLowerCase().contains(
                            _searchStore.searchFilterText.toLowerCase())) {
                      _searchList.add(searchData);
                    }
                  });
                }
                return !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loadingStore.isLoading &&
                            _locationStore.state != null &&
                            _apiDataStore.otherStateZonesList != null &&
                            _searchStore.observableList != null
                        ? _searchStore.observableList.length >= 1
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _searchList.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return DistrictListTile(
                                      zone: _searchList[index],
                                      showZones: _showZones);
                                },
                              )
                            : Container(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "No districts available !!!",
                                    style: TextStyle(
                                        color: NeumorphicTheme.defaultTextColor(
                                            context)),
                                  ),
                                ),
                              )
                        : Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
              })
            ],
          ),
        ),
      ),
    );
  }
}
