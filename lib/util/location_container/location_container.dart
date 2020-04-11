import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../store/location/location.dart';
import '../../store/navbar_index/navbar_index.dart';
import '../../store/api_data/api_data.dart';

class LocationContainer extends StatefulWidget {
  @override
  _LocationContainerState createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  final ApiDataStore _apiDataStore = ApiDataStore();

  final LocationStore _locationStore = LocationStore();
  final NavbarIndexStore _navbarIndexStore = NavbarIndexStore();

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(14)),
        style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -4),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Container(
          child: Observer(
            builder: (_) => _locationStore.state != ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        _navbarIndexStore.selectedIndex != 2
                            ? "${_locationStore.dist}, ${_locationStore.state}"
                                .toUpperCase()
                            : "India".toUpperCase(),
                        style: GoogleFonts.paytoneOne(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        _apiDataStore.factoroid.message,
                        style: TextStyle(
                            fontSize: 14.0,
                            height: 1.3,
                            color: NeumorphicTheme.currentTheme(context)
                                .defaultTextColor
                                .withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Fetching location...",
                      style: TextStyle(
                          color: NeumorphicTheme.currentTheme(context)
                              .defaultTextColor),
                      textAlign: TextAlign.center,
                    )),
          ),
        ));
  }
}
