import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 228,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'assets/images/no-internet.png',
              width: 124,
            ),
            SizedBox(
              height: 24,
            ),
            Text("You are lost!!!",
                style: GoogleFonts.paytoneOne(
                    fontSize: 28,
                    color: NeumorphicTheme.defaultTextColor(context)),
                textAlign: TextAlign.center)
          ],
        ));
  }
}
