import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../store/api_data/api_data.dart';
import '../../store/connection/connection.dart';
import '../../store/location/location.dart';
import '../../util/error_container/error_container.dart';
import '../../views/donate_page/donate_container.dart';


class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final LocationStore _locationStore = LocationStore();
  final ApiDataStore _apiDataStore = ApiDataStore();

  Future _getData() async {
    await _apiDataStore.fetchtDonationData();
    _apiDataStore.getMyStatesOrganisationLists(_locationStore.state);
  }

  @override
  void initState() {
    super.initState();
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
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Text("Donate today",
                  style: GoogleFonts.paytoneOne(
                      fontSize: 24, color: Theme.of(context).primaryColor)),
              SizedBox(
                height: 24.0,
              ),
              Observer(
                builder: (_) => !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : _apiDataStore.organisationProfileList != null
                        ? DonateContainer(
                            organisationName: _apiDataStore
                                .organisationProfileList[0].organisation,
                            accountName: _apiDataStore
                                .organisationProfileList[0].accountName,
                            accountNumber: _apiDataStore
                                .organisationProfileList[0].accountNumber,
                            ifscCode: _apiDataStore
                                .organisationProfileList[0].ifscCode,
                            upi: _apiDataStore.organisationProfileList[0].upi,
                            bank: _apiDataStore.organisationProfileList[0].bank)
                        : Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
              ),
              Observer(
                builder: (_) => !_connectionStore.isInternetConnected
                    ? Container()
                    : _apiDataStore.organisationProfileList != null
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                _apiDataStore.myStateOrganisationsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DonateContainer(
                                  organisationName: _apiDataStore
                                      .myStateOrganisationsList[index]
                                      .organisation,
                                  accountName: _apiDataStore
                                      .myStateOrganisationsList[index]
                                      .accountName,
                                  accountNumber: _apiDataStore
                                      .myStateOrganisationsList[index]
                                      .accountNumber,
                                  ifscCode: _apiDataStore
                                      .myStateOrganisationsList[index].ifscCode,
                                  upi: _apiDataStore
                                      .myStateOrganisationsList[index].upi,
                                  bank: _apiDataStore
                                      .myStateOrganisationsList[index].bank);
                            },
                          )
                        : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
