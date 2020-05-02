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

  Future _getData() async {
    await _apiDataStore.fetchAPI2CasesByCountriesData();
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
          child: Column(
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
              SizedBox(
                height: 36,
              ),
              Text(
                "Affected Countries",
                style: GoogleFonts.paytoneOne(
                    fontSize: 24, color: Theme.of(context).accentColor),
                textAlign: TextAlign.center,
              ),
              Observer(
                builder: (_) => !_connectionStore.isInternetConnected
                    ? Container()
                    : SizedBox(height: 24),
              ),
              Observer(
                  builder: (_) => !_connectionStore.isInternetConnected
                      ? ErrorContainer()
                      : !_loading.isLoading &&
                              _apiDataStore.listOfCountriesData.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount:
                                  _apiDataStore.listOfCountriesData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _apiDataStore.listOfCountriesData[index].countryName !=
                                        "India"
                                    ? CountryListTile(
                                        countryData: _apiDataStore.listOfCountriesData[index]
                                      )
                                    : Container();
                              },
                            )
                          : Container(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ))
            ],
          ),
        ),
      ),
    );
  }
}
