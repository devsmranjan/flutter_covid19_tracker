import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
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
  SearchStore _searchStore = SearchStore();

  @override
  void initState() {
    super.initState();
    List list = [];
    _apiDataStore.listOfOtherStateDistrictsData.districtData.forEach((data) {
      list.add(data);
    });

    // print(list);
    _searchStore.addObservableList(list);
    _loading.startLoading3000();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Header3Container(title: "Affected Districts", makeBottomPaddingSmall: true,),
          SizedBox(height: 24),
          SearchBar(searchStore: _searchStore, title: "Search Districts"),
          Observer(
            builder: (_) => !_loading.isLoading &&
                    _apiDataStore.listOfOtherStateDistrictsData != null
                ? ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: _searchStore.observableList
                        .where((element) => element.district
                            .toLowerCase()
                            .contains(
                                _searchStore.searchFilterText.toLowerCase()))
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
