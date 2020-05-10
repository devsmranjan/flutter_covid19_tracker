import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreListTile extends StatelessWidget {
  final title;
  final IconData icon;
  final iconColor;
  final VoidCallback action;
  final bool isEnabled;

  const MoreListTile({
    Key key,
    @required this.title,
    @required this.icon,
    this.iconColor,
    @required this.action,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Text("Self Assess"),
          Expanded(
            child: Text("$title",
                style: GoogleFonts.paytoneOne(
                    fontSize: 24,
                    color: NeumorphicTheme.currentTheme(context)
                        .defaultTextColor)),
          ),
          NeumorphicButton(
            isEnabled: isEnabled,
            onClick: action,
            style: NeumorphicStyle(shape: NeumorphicShape.convex),
            boxShape: NeumorphicBoxShape.circle(),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
