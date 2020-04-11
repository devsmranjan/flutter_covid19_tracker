import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
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
  final Emoji _emoji = Emoji();

  void _getData() {
    _apiDataStore.getListOfMyStateDistrictsData(
        stateName: _apiDataStore.myStateData.state);
  }

  Future _refreshData() async {
    await _apiDataStore.fetchAPI1StateDistrictsData();
    _getData();
  }

  @override
  void initState() {
    super.initState();
    _emoji.getRandomEmoji();
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
                      SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          "Affected Districts".toUpperCase(),
                          style: GoogleFonts.paytoneOne(
                              fontSize: 14,
                              color: Theme.of(context).accentColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 24),
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
                SizedBox(
                  height: 24,
                ),
                Neumorphic(
                  boxShape: NeumorphicBoxShape.roundRect(
                      borderRadius: BorderRadius.circular(14)),
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    depth: -2,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 24),
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "There ${int.parse(_apiDataStore.myStateData.deltaConfirmed) <= 1 ? "is" : "are"} ${int.parse(_apiDataStore.myStateData.deltaConfirmed) <= 0 ? "no" : _apiDataStore.myStateData.deltaConfirmed} new ${int.parse(_apiDataStore.myStateData.deltaConfirmed) <= 1 ? "case" : "cases"} in your state ${int.parse(_apiDataStore.myStateData.deltaConfirmed) <= 0 ? _emoji.normalEmoji : _emoji.sadEmoji} ! Stay Safe !!!",
                          style: TextStyle(
                              fontSize: 14.0,
                              height: 1.6,
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                ),
                !_connectionStore.isInternetConnected
                    ? Container()
                    : SizedBox(height: 12),
                !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : !_loading.isLoading &&
                            _apiDataStore.listOfMyStateDistrictsData != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: _apiDataStore
                                .listOfMyStateDistrictsData.districtData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DistrictListTile(
                                districtName: _apiDataStore
                                    .listOfMyStateDistrictsData
                                    .districtData[index]
                                    .district,
                                totalConfirmed: _apiDataStore
                                    .listOfMyStateDistrictsData
                                    .districtData[index]
                                    .confirmed,
                                delta: _apiDataStore.listOfMyStateDistrictsData
                                    .districtData[index].delta,
                              );
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
