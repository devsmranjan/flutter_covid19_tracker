import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'dart:convert';
import '../../store/connection/connection.dart';
import '../../util/error_container/error_container.dart';


import 'package:url_launcher/url_launcher.dart';

class TweetsPage extends StatefulWidget {
  final twitterProfileName;
  final twitterId;
  final isDarkMode;

  const TweetsPage(
      {Key key,
      @required this.twitterProfileName,
      @required this.twitterId,
      @required this.isDarkMode})
      : super(key: key);

  @override
  _TweetsPageState createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String kNavigationTwitterPage = "";
  String encodedHtml = "";
  String profileUrl = "";

  Future _loadStreams() async {
    flutterWebviewPlugin.onStateChanged.listen((viewState) async {
      if (!viewState.url.contains(encodedHtml)) {
        flutterWebviewPlugin.stopLoading();
        if (await canLaunch(viewState.url)) {
          await launch(viewState.url);
        } else {
          throw 'Could not launch ${viewState.url}';
        }
      }
    });

    flutterWebviewPlugin.onHttpError.listen((event) async {
      flutterWebviewPlugin.close();
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text("Somthing went wrong"),
        duration: Duration(seconds: 3),
      ));
      Future.delayed(const Duration(milliseconds: 3500), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    profileUrl = "https://twitter.com/${widget.twitterId}?ref_src=twsrc%5Etfw";

    kNavigationTwitterPage = '''
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tweets</title>
  </head>

  <body>
    <div">
      <div style="text-align: center;">
        <a class="twitter-timeline" style="padding-left: 18px; padding-right: 18px" data-theme="${!widget.isDarkMode ? 'light' : 'dark'}" data-chrome="transparent nofooter noborders noheader noscrollbar" href="$profileUrl">Tweets by ${widget.twitterProfileName}</a>
      </div>
    </div>
    <script async="async" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    <script>
      document
        .getElementsByTagName('body')[0]
        .style
        .backgroundColor = "${!widget.isDarkMode ? "#e4e9ed" : "#191C23"}";

      document
        .getElementsByTagName('body')[0]
        .style
        .paddingLeft = "12px";
      document
        .getElementsByTagName('body')[0]
        .style
        .paddingRight = "12px";
    </script>
  </body>

</html>

    ''';

    encodedHtml =
        base64Encode(const Utf8Encoder().convert(kNavigationTwitterPage));
    _loadStreams();
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: kToolbarHeight,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                NeumorphicButton(
                  onClick: () {
                    Navigator.pop(context);
                  },
                  style: NeumorphicStyle(shape: NeumorphicShape.convex),
                  boxShape: NeumorphicBoxShape.circle(),
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(LineAwesomeIcons.long_arrow_left,
                      color: NeumorphicTheme.currentTheme(context).accentColor),
                ),
                Observer(
                  builder: (_) => NeumorphicButton(
                    onClick: () {
                      _launchURL(profileUrl);
                    },
                    isEnabled: _connectionStore.isInternetConnected,
                    style: NeumorphicStyle(shape: NeumorphicShape.convex),
                    boxShape: NeumorphicBoxShape.circle(),
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(LineAwesomeIcons.external_link,
                        color:
                            NeumorphicTheme.currentTheme(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Observer(
            builder: (_) => Expanded(
                child: !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : WebviewScaffold(
                        url: "data:text/html;base64,$encodedHtml",
                        withLocalStorage: true,
                        hidden: true,
                        allowFileURLs: true,
                        withLocalUrl: true,
                        javascriptChannels: [
                          JavascriptChannel(
                              name: 'Print',
                              onMessageReceived: (JavascriptMessage message) {
                                print(message.message);
                              }),
                        ].toSet(),
                        withJavascript: true,
                        initialChild: Container(
                          color: NeumorphicTheme.baseColor(context),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
