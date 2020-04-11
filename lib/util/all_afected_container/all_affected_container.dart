import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class AllAffectedContainer extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback action;
  final bool isEnabled;

  const AllAffectedContainer({
    Key key,
    @required this.title,
    @required this.color,
    @required this.action,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              title,
              style:
                  GoogleFonts.paytoneOne(color: Theme.of(context).accentColor),
            )),
            NeumorphicButton(
              onClick: action,
              isEnabled: isEnabled,
              style: NeumorphicStyle(shape: NeumorphicShape.convex),
              boxShape: NeumorphicBoxShape.circle(),
              padding: const EdgeInsets.all(12.0),
              child: Icon(LineAwesomeIcons.long_arrow_right, color: color),
            ),
          ],
        ));
  }
}
