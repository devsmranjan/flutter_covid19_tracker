import 'dart:math';

import 'package:covid19_tracker/api/covid_19_india/all_data_model/resources_model.dart';
import 'package:covid19_tracker/store/api_data/api_data.dart';
import 'package:covid19_tracker/store/location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class FactoidsContainer extends StatefulWidget {
  @override
  _FactoidsContainerState createState() => _FactoidsContainerState();
}

class _FactoidsContainerState extends State<FactoidsContainer> {
  ApiDataStore _apiDataStore = ApiDataStore();
  Resource _resource = Resource();
  LocationStore _locationStore = LocationStore();

  void _getRandomResource() {
    final _random = Random();

    if (_apiDataStore.myStateResourcesList != null) {
      _resource = _apiDataStore.myStateResourcesList[
          _random.nextInt(_apiDataStore.myStateResourcesList.length)];
    }
  }

  @override
  Widget build(BuildContext context) {
    // _getRandomResource();
    return Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(8)),
        style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Observer(builder: (_) {
            if (_locationStore.isLocationPermissionGranted &&
                _locationStore.isLocationEnabled) {
              _getRandomResource();
            }
            return _resource.category != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${_resource.category}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${_resource.nameOfTheOrganisation}, ${_resource.city}. ${_resource.descriptionAndOrServiceprovided}.",
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.22,
                            // letterSpacing: 0.1,
                            color: NeumorphicTheme.defaultTextColor(context)
                                .withOpacity(0.6)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Phone: ${_resource.phoneNumber.join(", ")}",
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.22,
                            color: NeumorphicTheme.defaultTextColor(context)
                                .withOpacity(0.6)),
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "Getting an essential info for you. It may take a while.",
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.22,
                            color: NeumorphicTheme.defaultTextColor(context)
                                .withOpacity(0.6)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
            // SizedBox(
            //     height: 4,
            //     child: LinearProgressIndicator(),
            //   );
          }),
        ));
  }
}
