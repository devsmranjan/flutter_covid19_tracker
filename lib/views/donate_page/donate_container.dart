import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class DonateContainer extends StatelessWidget {
  final organisationName;
  final accountName;
  final accountNumber;
  final ifscCode;
  final upi;
  final bank;

  const DonateContainer(
      {Key key,
      @required this.organisationName,
      @required this.accountName,
      @required this.accountNumber,
      @required this.ifscCode,
      @required this.upi,
      @required this.bank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
                borderRadius: BorderRadius.circular(14)),
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(organisationName,
                    style: GoogleFonts.paytoneOne(
                        fontSize: 18,
                        color: NeumorphicTheme.currentTheme(context)
                            .defaultTextColor)),
                SizedBox(
                  height: 24,
                ),
                Table(
                  columnWidths: {
                    1: FractionColumnWidth(0.45),
                    2: FractionColumnWidth(0.1),
                    3: FractionColumnWidth(0.1)
                  },
                  children: [
                    TableRow(children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          'Account Name : ',
                          style: TextStyle(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          accountName,
                          style: GoogleFonts.robotoMono(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container()),
                    ]),
                    TableRow(children: [
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                    ]),
                    TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text('Account No. : ',
                              style: TextStyle(
                                  color: NeumorphicTheme.currentTheme(context)
                                      .defaultTextColor))),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          accountNumber,
                          style: GoogleFonts.robotoMono(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: SizedBox(
                          height: 24,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(LineAwesomeIcons.clipboard,
                                  size: 18,
                                  color: NeumorphicTheme.currentTheme(context)
                                      .accentColor),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: accountNumber));
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text("Copied to Clipboard"),
                                ));
                              }),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                    ]),
                    TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            'IFSC Code : ',
                            style: TextStyle(
                                color: NeumorphicTheme.currentTheme(context)
                                    .defaultTextColor),
                          )),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          ifscCode,
                          style: GoogleFonts.robotoMono(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: SizedBox(
                          height: 24,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(LineAwesomeIcons.clipboard,
                                  size: 18,
                                  color: NeumorphicTheme.currentTheme(context)
                                      .accentColor),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: ifscCode));
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text("Copied to Clipboard"),
                                ));
                              }),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                    ]),
                    TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text('UPI : ',
                              style: TextStyle(
                                  color: NeumorphicTheme.currentTheme(context)
                                      .defaultTextColor))),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          upi,
                          style: GoogleFonts.robotoMono(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: SizedBox(
                          height: 24,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(LineAwesomeIcons.clipboard,
                                  size: 18,
                                  color: NeumorphicTheme.currentTheme(context)
                                      .accentColor),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: upi));
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text("Copied to Clipboard"),
                                ));
                              }),
                        ),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                      SizedBox(height: 18),
                    ]),
                    TableRow(children: [
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text('Bank : ',
                              style: TextStyle(
                                  color: NeumorphicTheme.currentTheme(context)
                                      .defaultTextColor))),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Text(
                          bank,
                          style: GoogleFonts.robotoMono(
                              color: NeumorphicTheme.currentTheme(context)
                                  .defaultTextColor),
                        ),
                      ),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container()),
                    ]),
                  ],
                ),
                SizedBox(height: 24)
              ],
            ),
          ),
        ),
        SizedBox(height: 24)
      ],
    );
  }
}
