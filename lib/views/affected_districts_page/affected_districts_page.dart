import 'package:covid19_tracker/store/location/location.dart';
import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/store/show_zones/show_zones.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mobx/mobx.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../store/emoji/emoji.dart';
import '../../store/loading/loading.dart';
import '../../util/district_listtile/district_listtile.dart';
import '../../util/error_container/error_container.dart';

class AffectedDistrictPage extends StatefulWidget {
  @override
  _AffectedDistrictPageState createState() => _AffectedDistrictPageState();
}

class _AffectedDistrictPageState extends State<AffectedDistrictPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  final Loading _loading = Loading();
  final SearchStore _searchStore = SearchStore();
  final ShowZones _showZones = ShowZones();
  final LocationStore _locationStore = LocationStore();
  // final Emoji _emoji = Emoji();

  void _getData() {
    _apiDataStore.getListOfMyStateDistrictsData(
        stateName: _apiDataStore.myStateData.state);

    List list = [];
    _apiDataStore.listOfMyStateDistrictsData.districtData.forEach((data) {
      list.add(data);
    });

    _searchStore.addObservableList(list);
  }

  Future _refreshData() async {
    await _apiDataStore.fetchAPI1StateDistrictsData();
    _getData();
  }

  @override
  void initState() {
    super.initState();
    // _emoji.getRandomEmoji();
    _loading.startLoading3000();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 24.0),
          child: Observer(
            builder: (_) => Column(
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                      NeumorphicButton(
                        onClick: () async {
                          _loading.startLoading3000();
                          await _refreshData();
                          print("Page refreshed");
                        },
                        style: NeumorphicStyle(shape: NeumorphicShape.convex),
                        boxShape: NeumorphicBoxShape.circle(),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(LineAwesomeIcons.refresh,
                            color: NeumorphicTheme.currentTheme(context)
                                .accentColor),
                      ),
                    ],
                  ),
                ),
                Header3Container(title: "Affected Districts"),
                !_connectionStore.isInternetConnected
                    ? Container()
                    : SearchBar(
                        searchStore: _searchStore, title: "Search Districts"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Show Zones",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !NeumorphicTheme.isUsingDark(context)
                                ? Colors.black26
                                : Colors.white)),
                    SizedBox(width: 12),
                    Observer(
                      builder: (_) => NeumorphicSwitch(
                        height: 22,
                        value: _showZones.isShowZones,
                        onChanged: (value) {
                          _showZones.updateShowZones(!_showZones.isShowZones);
                        },
                        style: NeumorphicSwitchStyle(
                            inactiveTrackColor: Colors.white.withOpacity(0.02),
                            activeTrackColor: Theme.of(context).accentColor),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loading.isLoading && _searchStore.observableList != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _searchStore.observableList
                                .where((element) => element.district
                                    .toLowerCase()
                                    .contains(_searchStore.searchFilterText
                                        .toLowerCase()))
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              List list = _searchStore.observableList
                                  .where((element) => element.district
                                      .toLowerCase()
                                      .contains(_searchStore.searchFilterText
                                          .toLowerCase()))
                                  .toList();

                              List zone = _apiDataStore.myStateZonesList
                                  .where((element) =>
                                      element.district.toLowerCase() ==
                                      list[index].district.toLowerCase())
                                  .toList();

                              return DistrictListTile(
                                  state: _locationStore.state,
                                  districtData: list[index],
                                  zone: zone[0],
                                  showZones: _showZones);
                            },
                          )
                        : Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
