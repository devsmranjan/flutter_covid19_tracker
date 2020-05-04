import 'package:covid19_tracker/store/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class SearchBar extends StatefulWidget {
  final searchStore;
  final title;

  const SearchBar(
      {Key key,
      @required this.searchStore,
      @required this.title})
      : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.searchStore.clearSearchFilterText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(8)),
        style: NeumorphicStyle(shape: NeumorphicShape.flat, depth: -2),
        padding:
            const EdgeInsets.only(left: 18.0, right: 8.0, top: 4, bottom: 4),
        margin: const EdgeInsets.only(bottom: 18),
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
                      hintStyle: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)
                              .withOpacity(0.5))),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    widget.searchStore.updateSearchFilterText(value);
                  },
                ),
              ),
              SizedBox(
                width: 18,
              ),
              NeumorphicButton(
                onClick: () {
                  // Navigator.pop(context);
                  _searchController.text = "";
                  widget.searchStore.clearSearchFilterText();
                },
                style: NeumorphicStyle(shape: NeumorphicShape.convex),
                boxShape: NeumorphicBoxShape.circle(),
                padding: const EdgeInsets.all(8.0),
                child: Icon(LineAwesomeIcons.close,
                    size: 22,
                    color: NeumorphicTheme.currentTheme(context).accentColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}