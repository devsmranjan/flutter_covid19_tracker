import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ItemListTile extends StatelessWidget {
  final title;
  final value;
  final isCopiable;

  const ItemListTile(
      {Key key,
      @required this.title,
      @required this.value,
      this.isCopiable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Table(
      columnWidths: {
        1: FractionColumnWidth(0.45),
        2: FractionColumnWidth(0.1),
        3: FractionColumnWidth(0.1)
      },
      children: [
        TableRow(children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('$title : ')),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(value),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: isCopiable
                ? IconButton(
                    icon: Icon(LineAwesomeIcons.clipboard), onPressed: () {})
                : Container(),
          ),
        ]),
        TableRow(children: [
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text('$title : ')),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(value),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: isCopiable
                ? IconButton(
                    icon: Icon(LineAwesomeIcons.clipboard), onPressed: () {})
                : Container(),
          ),
        ]),
      ],
    ));
  }
}
