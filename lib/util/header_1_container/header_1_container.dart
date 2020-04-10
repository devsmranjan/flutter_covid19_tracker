import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Header1Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: kToolbarHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
              child: Text(
            "COVID-19 Tracker",
            style: TextStyle(fontSize: 18).copyWith(
                color: NeumorphicTheme.currentTheme(context).defaultTextColor),
          )),
        ),
        SizedBox(
          height: kToolbarHeight - MediaQuery.of(context).padding.top,
        ),
      ],
    );
  }
}
