import 'package:covid19_tracker/store/search/search.dart';
import 'package:covid19_tracker/util/search_bar/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../util/error_container/error_container.dart';
import 'helpline_container.dart';

class HelplinesPage extends StatefulWidget {
  @override
  _HelplinesPageState createState() => _HelplinesPageState();
}

class _HelplinesPageState extends State<HelplinesPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  SearchStore _searchStore = SearchStore();

  Future _getData() async {
    await _apiDataStore.fetchtHelplinesStatewiseData();
    List list = [];
    _apiDataStore.helplinesOfStatesList.forEach((data) {
      list.add(data);
    });

    // print(list);
    _searchStore.addObservableList(list);
  }

  @override
  void initState() {
    super.initState();
    _getData();
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
                        onClick: () async {
                          if (_apiDataStore.helplinesOfStatesList.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor:
                                        NeumorphicTheme.currentTheme(context)
                                            .baseColor,
                                    title: Text(
                                      "Central Helplines",
                                      style: TextStyle(
                                          color: NeumorphicTheme.currentTheme(
                                                  context)
                                              .accentColor),
                                    ),
                                    children: _apiDataStore
                                        .helplinesOfStatesList[0].helplinesList
                                        .map(
                                          (helpline) => ListTile(
                                              onTap: () {
                                                _launchURL(helpline, context);
                                              },
                                              title: Text(helpline,
                                                  style: TextStyle(
                                                      color: NeumorphicTheme
                                                              .currentTheme(
                                                                  context)
                                                          .defaultTextColor)),
                                              leading: Icon(
                                                LineAwesomeIcons.phone_square,
                                                color: NeumorphicTheme
                                                        .currentTheme(context)
                                                    .accentColor,
                                              )),
                                        )
                                        .toList()));
                          }
                        },
                        isEnabled:
                            _apiDataStore.helplinesOfStatesList != null &&
                                _apiDataStore.helplinesOfStatesList[0]
                                        .helplinesList.length >=
                                    1,
                        style: NeumorphicStyle(shape: NeumorphicShape.convex),
                        boxShape: NeumorphicBoxShape.circle(),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(LineAwesomeIcons.phone,
                            color: NeumorphicTheme.currentTheme(context)
                                .accentColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36.0,
              ),
              Text(
                "Helplines",
                style: GoogleFonts.paytoneOne(
                    fontSize: 24, color: Theme.of(context).accentColor),
                textAlign: TextAlign.center,
              ),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SizedBox(height: 24),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SearchBar(
                      searchStore: _searchStore, title: "Search States"),
              !_connectionStore.isInternetConnected
                  ? Container()
                  : SizedBox(height: 24),
              Observer(
                builder: (_) => !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : _apiDataStore.helplinesOfStatesList != null &&
                            _searchStore.observableList != null
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _searchStore.observableList
                                    .where((element) => element.state
                                        .toLowerCase()
                                        .contains(_searchStore.searchFilterText
                                            .toLowerCase()))
                                    .length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              List list = _searchStore.observableList
                                  .where((element) => element.state
                                      .toLowerCase()
                                      .contains(_searchStore.searchFilterText
                                          .toLowerCase()))
                                  .toList();

                              return list[index].state != ""
                                  ? HelplineContainer(
                                      title: list[index].state ?? "",
                                      helplines:
                                          list[index].helplinesList ?? [],
                                    )
                                  : Container();
                            },
                          )
                        : Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
