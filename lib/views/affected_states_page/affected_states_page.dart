import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../store/emoji/emoji.dart';
import '../../store/loading/loading.dart';
import '../../util/error_container/error_container.dart';
import '../../util/state_listtile/state_listtile.dart';


class AffectedStatesPage extends StatefulWidget {
  @override
  _AffectedStatesPageState createState() => _AffectedStatesPageState();
}

class _AffectedStatesPageState extends State<AffectedStatesPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final ApiDataStore _apiDataStore = ApiDataStore();
  final Loading _loading = Loading();
  final Emoji _emoji = Emoji();

  @override
  void initState() {
    super.initState();
    _emoji.getRandomEmoji();
    _loading.startLoading3000();
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
                      onClick: () {
                        _loading.startLoading3000();
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
                  "Affected States",
                  style: GoogleFonts.paytoneOne(
                      fontSize: 24, color: Theme.of(context).accentColor),
                  textAlign: TextAlign.center,
                ),
              !_connectionStore.isInternetConnected
                    ? Container()
                    : SizedBox(height: 24),
              Observer(
                  builder: (_) => !_connectionStore.isInternetConnected
                      ? ErrorContainer()
                      : !_loading.isLoading &&
                              _apiDataStore.allStatesData.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: _apiDataStore.allStatesData.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index != 0 &&
                                    _apiDataStore
                                            .allStatesData[index].stateCode !=
                                        _apiDataStore.myStateData.stateCode &&
                                    int.tryParse(_apiDataStore
                                            .allStatesData[index].confirmed) !=
                                        0) {
                                  return StateListTile(
                                      stateData:
                                          _apiDataStore.allStatesData[index]);
                                }
                                return Container();
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
