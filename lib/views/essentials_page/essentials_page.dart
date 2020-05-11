import 'dart:convert';

import 'package:covid19_tracker/api/covid_19_india/all_data_model/resources_model.dart';
import 'package:covid19_tracker/store/essentials_filter/essentials_filter.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/location/location.dart';
import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/util/essential_listtile/essential_listtile.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:covid19_tracker/views/essentials_page/essential.dart';
import 'package:covid19_tracker/views/essentials_page/essentials_container.dart';
import 'package:covid19_tracker/views/helplines_page/helpline_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../util/error_container/error_container.dart';
// import 'helpline_container.dart';\
import 'package:sliding_panel/sliding_panel.dart';

class EssentialsPage extends StatefulWidget {
  @override
  _EssentialsPageState createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  SearchStore _searchStore = SearchStore();
  final Loading _loadingStore = Loading();
  final LocationStore _locationStore = LocationStore();
  final EssentialsFilter _essentialsFilterStore = EssentialsFilter();

  Future _getData() async {
    if (_apiDataStore.allResourcesList == null) {
      await _apiDataStore.fetchAPI1ResourcesData();
    }

    _essentialsFilterStore.updateFilterState(_locationStore.state);
    _essentialsFilterStore.updateFilterCity("All cities");
    _essentialsFilterStore.updateFilterServices("All categories");

    List list = [];
    _apiDataStore.allResourcesList
        .where((resourceData) =>
            resourceData.state.toLowerCase() ==
            _essentialsFilterStore.filterState.toLowerCase())
        .forEach((data) {
      list.add(Essential(
          category: data.category,
          city: data.city,
          contact: data.contact,
          descriptionAndOrServiceprovided: data.descriptionAndOrServiceprovided,
          nameOfTheOrganisation: data.nameOfTheOrganisation,
          phoneNumber: data.phoneNumber,
          state: data.state,
          isExpanded: false));
    });
    _searchStore.addObservableList(list);
  }

  @override
  void initState() {
    super.initState();
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
                "Filter Essentials",
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
                  value: _essentialsFilterStore.filterState,
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                  iconEnabledColor: NeumorphicTheme.accentColor(context),
                  items: _apiDataStore.stateAndCityResourcesMap.keys
                      .map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Container(child: Text(state)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _essentialsFilterStore.updateFilterState(value);
                    _essentialsFilterStore.updateFilterCity("All cities");
                    _essentialsFilterStore
                        .updateFilterServices("All categories");
                  },
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Observer(
              builder: (_) {
                List<String> _cities = [];

                _apiDataStore.stateAndCityResourcesMap.forEach((key, value) {
                  if (key.toLowerCase() ==
                      _essentialsFilterStore.filterState.toLowerCase()) {
                    _cities = value['cities'];
                  }
                });

                return Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  style:
                      NeumorphicStyle(shape: NeumorphicShape.flat, depth: -1),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: NeumorphicTheme.baseColor(context),
                    hint: Text("Select City"),
                    underline: Container(),
                    style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(context)),
                    iconEnabledColor: NeumorphicTheme.accentColor(context),
                    value: _essentialsFilterStore.filterCity,
                    items: _cities.map((var city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Container(child: Text(city)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _essentialsFilterStore.updateFilterCity(value);
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 12,
            ),
            Observer(
              builder: (_) {
                // All categories
                List<String> _categories = [];

                _apiDataStore.stateAndCityResourcesMap.forEach((key, value) {
                  if (key.toLowerCase() ==
                      _essentialsFilterStore.filterState.toLowerCase()) {
                    _categories = value['categories'];
                  }
                });

                return Neumorphic(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  style:
                      NeumorphicStyle(shape: NeumorphicShape.flat, depth: -1),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: NeumorphicTheme.baseColor(context),
                    hint: Text("Select Category"),
                    underline: Container(),
                    style: TextStyle(
                        color: NeumorphicTheme.defaultTextColor(context)),
                    iconEnabledColor: NeumorphicTheme.accentColor(context),
                    value: _essentialsFilterStore.filterServices,
                    items: _categories.map((var category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Container(child: Text(category)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _essentialsFilterStore.updateFilterServices(value);
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
                _searchStore.clearObservableList();

                List list = [];
                _apiDataStore.allResourcesList
                    .where((resourceData) =>
                        resourceData.state.toLowerCase() ==
                        _essentialsFilterStore.filterState.toLowerCase())
                    .where((resourceData2) =>
                        _essentialsFilterStore.filterCity.toLowerCase() ==
                                "all cities"
                            ? true
                            : resourceData2.city.toLowerCase() ==
                                _essentialsFilterStore.filterCity.toLowerCase())
                    .where((resourceData3) => _essentialsFilterStore
                                .filterServices
                                .toLowerCase() ==
                            "all categories"
                        ? true
                        : resourceData3.category.toLowerCase() ==
                            _essentialsFilterStore.filterServices.toLowerCase())
                    .forEach((data) {
                  list.add(Essential(
                      category: data.category,
                      city: data.city,
                      contact: data.contact,
                      descriptionAndOrServiceprovided:
                          data.descriptionAndOrServiceprovided,
                      nameOfTheOrganisation: data.nameOfTheOrganisation,
                      phoneNumber: data.phoneNumber,
                      state: data.state,
                      isExpanded: false));
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
                        isEnabled: _apiDataStore.allResourcesList != null &&
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
                          "${_essentialsFilterStore.filterState != "" ? _essentialsFilterStore.filterState : "Essentials & Resources"}")),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SearchBar(
                      searchStore: _searchStore, title: "Search any keyword"),
              Observer(builder: (_) {
                List<Essential> _searchList = [];
                if (_searchStore.observableList != null) {
                  _searchStore.observableList.forEach((searchData) {
                    if (searchData.city.toLowerCase().contains(
                            _searchStore.searchFilterText.toLowerCase()) ||
                        searchData.category.toLowerCase().contains(
                            _searchStore.searchFilterText.toLowerCase()) ||
                        searchData.descriptionAndOrServiceprovided
                            .toLowerCase()
                            .contains(
                                _searchStore.searchFilterText.toLowerCase()) ||
                        searchData.nameOfTheOrganisation.toLowerCase().contains(
                            _searchStore.searchFilterText.toLowerCase())) {
                      _searchList.add(searchData);
                    }
                  });
                }
                return !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loadingStore.isLoading &&
                            _locationStore.state != null &&
                            _apiDataStore.allResourcesList != null &&
                            _searchStore.observableList != null
                        ? _searchStore.observableList.length >= 1
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _searchList.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  return _searchList[index].state != ""
                                      ? EssentialListTile(
                                          essential: _searchList[index],
                                        )
                                      : Container();
                                },
                              )
                            : Container(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "No resources available !!!",
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
