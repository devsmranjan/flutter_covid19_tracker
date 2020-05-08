import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/store/show_zones/show_zones.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../store/api_data/api_data.dart';
import '../../store/loading/loading.dart';
import '../../util/district_listtile/district_listtile.dart';

class AffectedDistricts extends StatefulWidget {
  final String state;

  const AffectedDistricts({Key key, @required this.state}) : super(key: key);
  @override
  _AffectedDistrictsState createState() => _AffectedDistrictsState();
}

class _AffectedDistrictsState extends State<AffectedDistricts> {
  final ApiDataStore _apiDataStore = ApiDataStore();
  final Loading _loading = Loading();
  SearchStore _searchStore = SearchStore();
  final ShowZones _showZones = ShowZones();

  @override
  void initState() {
    super.initState();
    List list = [];
    _apiDataStore.listOfOtherStateDistrictsData.districtData.forEach((data) {
      list.add(data);
    });
    _searchStore.addObservableList(list);
    _loading.startLoading3000();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Header3Container(
            title: "Affected Districts",
            makeBottomPaddingSmall: true,
          ),
          SizedBox(height: 24),
          SearchBar(searchStore: _searchStore, title: "Search for affected districts"),
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
          Observer(
            builder: (_) => !_loading.isLoading &&
                    _apiDataStore.listOfOtherStateDistrictsData != null &&
                    _apiDataStore.otherStateZonesList != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _searchStore.observableList
                        .where((element) => element.district
                            .toLowerCase()
                            .contains(
                                _searchStore.searchFilterText.toLowerCase()))
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      List list = _searchStore.observableList
                          .where((element) => element.district
                              .toLowerCase()
                              .contains(
                                  _searchStore.searchFilterText.toLowerCase()))
                          .toList();

                      List zone = _apiDataStore.otherStateZonesList
                          .where((element) =>
                              element.district.toLowerCase() ==
                              list[index].district.toLowerCase())
                          .toList();

                      return DistrictListTile(
                          state: widget.state,
                          districtData: list[index],
                          zone: zone.length >= 1 ? zone[0] : null,
                          showZones: _showZones);
                    },
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
