import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class Header3Container extends StatelessWidget {
  final String title;
  final makeBottomPaddingSmall;

  const Header3Container(
      {Key key, @required this.title, this.makeBottomPaddingSmall = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Text(
          title,
          style: GoogleFonts.paytoneOne(
              fontSize:  !makeBottomPaddingSmall ? 22 : 18, color: Theme.of(context).accentColor),
          textAlign: TextAlign.center,
        ),
        !makeBottomPaddingSmall ? SizedBox(height: 18) : SizedBox(height: 4),
      ],
    );
  }
}
