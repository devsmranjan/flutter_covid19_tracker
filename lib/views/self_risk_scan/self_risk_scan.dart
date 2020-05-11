import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../store/connection/connection.dart';
import '../../util/error_container/error_container.dart';

class SelfRiskScan extends StatefulWidget {
  @override
  _SelfRiskScanState createState() => _SelfRiskScanState();
}

class _SelfRiskScanState extends State<SelfRiskScan> {
  final ConnectionStore _connectionStore = ConnectionStore();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var js_light = r'''
                                var bgColor = '#e4e9ed';
  document
    .getElementById('my-botui-app')
    .style
    .backgroundColor = bgColor;
  document.getElementsByClassName('reset')[0].style
    .backgroundColor = bgColor;

 var botui_container = document.getElementsByClassName('botui-container');
//  var botui_message_content = document.getElementsByClassName('botui-message-content');

  for (var i = 0; i < botui_container.length; i++) {
    botui_container[i].style.backgroundColor = bgColor;
  }

  // for (var i = 0; i < botui_message_content.length; i++) {
    // botui_message_content[i].style.backgroundColor = '#00B38E';
  // }
                                  ''';

  var js_dark = r'''
                                var bgColor = '#191C23';
  document
    .getElementById('my-botui-app')
    .style
    .backgroundColor = bgColor;
  document.getElementsByClassName('reset')[0].style
    .backgroundColor = bgColor;

 var botui_container = document.getElementsByClassName('botui-container');

  for (var i = 0; i < botui_container.length; i++) {
    botui_container[i].style.backgroundColor = bgColor;
  }

                                  ''';

  Future loadJS() async {
    flutterWebviewPlugin.onStateChanged.listen((viewState) async {
      print(viewState.type);
      if (viewState.type == WebViewState.finishLoad) {
        flutterWebviewPlugin.evalJavascript(
            !NeumorphicTheme.isUsingDark(context) ? js_light : js_dark);
      }

      if (!viewState.url.contains("web.swaraksha.gov.in/ncv19/chat")) {
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
        content: Text("Something went wrong"),
        duration: Duration(seconds: 3),
      ));
      Future.delayed(const Duration(milliseconds: 3500), () {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadJS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NeumorphicTheme.baseColor(context),
      resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: NeumorphicButton(
                onClick: () {
                  Navigator.pop(context);
                },
                style: NeumorphicStyle(shape: NeumorphicShape.convex),
                boxShape: NeumorphicBoxShape.circle(),
                padding: const EdgeInsets.all(12.0),
                child: Icon(LineAwesomeIcons.long_arrow_left,
                    color: NeumorphicTheme.currentTheme(context).accentColor),
              ),
            ),
            _connectionStore.isInternetConnected
                ? SizedBox(
                    height: 24,
                  )
                : Container(),
            Expanded(
                child: !_connectionStore.isInternetConnected
                    ? ErrorContainer()
                    : WebviewScaffold(
                        url: "https://web.swaraksha.gov.in/ncv19/chat/?lang=en",
                        withLocalStorage: true,
                        hidden: true,
                        geolocationEnabled: true,
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
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )),
            Container(
              height: 24,
              child: Center(
                child: Text(
                  "Powered by Swaraksha",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
