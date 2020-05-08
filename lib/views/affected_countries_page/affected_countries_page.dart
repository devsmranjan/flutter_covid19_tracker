import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../store/emoji/emoji.dart';
import '../../store/loading/loading.dart';
import '../../util/country_listtile/country_listtile.dart';
import '../../util/error_container/error_container.dart';

class AffectedCountriesPage extends StatefulWidget {
  @override
  _AffectedCountriesPageState createState() => _AffectedCountriesPageState();
}

class _AffectedCountriesPageState extends State<AffectedCountriesPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  final Loading _loading = Loading();
  SearchStore _searchStore = SearchStore();

  Future _getData() async {
    await _apiDataStore.fetchAPI2CasesByCountriesData();

    List list = [];
    _apiDataStore.listOfCountriesData.forEach((data) {
      list.add(data);
    });

    // print(list);
    _searchStore.addObservableList(list);
  }

  @override
  void initState() {
    super.initState();
    _loading.startLoading5000();
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
                          _apiDataStore.listOfCountriesData.clear();
                          _loading.startLoading5000();
                          await _getData();
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
                Header3Container(title: "Affected Countries"),
                !_connectionStore.isInternetConnected
                    ? Container()
                    : SearchBar(
                        searchStore: _searchStore, title: "Search Countries"),
                !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loading.isLoading &&
                            (_apiDataStore.listOfCountriesData.isNotEmpty || _apiDataStore.listOfCountriesData != null)
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _searchStore.observableList
                                .where((element) => element.countryName
                                    .toLowerCase()
                                    .contains(_searchStore.searchFilterText
                                        .toLowerCase()))
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              List list = _searchStore.observableList
                                  .where((element) => element.countryName
                                      .toLowerCase()
                                      .contains(_searchStore.searchFilterText
                                          .toLowerCase()))
                                  .toList();
                              return list[index].countryName != "India"
                                  ? CountryListTile(countryData: list[index])
                                  : Container();
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
