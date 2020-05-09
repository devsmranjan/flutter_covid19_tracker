import 'package:covid19_tracker/store/essentials_filter/essentials_filter.dart';
import 'package:covid19_tracker/store/loading/loading.dart';
import 'package:covid19_tracker/store/location/location.dart';
import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/util/header_3_container/header_3_container.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
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
// import 'helpline_container.dart';

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

    List list = [];
    _apiDataStore.allResourcesList
        .where((resourceData) =>
            resourceData.state.toLowerCase() ==
            _essentialsFilterStore.filterState.toLowerCase())
        .forEach((data) {
      list.add(data);
    });
    _searchStore.addObservableList(list);
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _loadingStore.startLoading3000();
  }

  void _launchURL(String helpline, BuildContext context) async {
    if (await canLaunch("tel:$helpline")) {
      Navigator.pop(context);
      await launch("tel:$helpline");
    } else {
      throw 'Could not launch $helpline';
    }
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
                        onClick: () {},
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
              Header3Container(title: "Essentials & Resources"),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SearchBar(
                      searchStore: _searchStore,
                      title: "Search any keyword"),
              Observer(builder: (_) {
                List _searchList = [];
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

                return !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loadingStore.isLoading &&
                            _locationStore.state != null &&
                            _apiDataStore.allResourcesList != null &&
                            _searchStore.observableList != null
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _searchList.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              List list = _searchList;

                              return list[index].state != ""
                                  ? EssentialsContainer(
                                      title: list[index].city ?? "",
                                    )
                                  : Container();
                            },
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
