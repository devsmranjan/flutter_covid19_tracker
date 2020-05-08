import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_info/system_info.dart';
import 'store/dark_mode/dark_mode.dart';
import 'views/home.dart';

class Covid19Tracker extends StatefulWidget {
  static const APP_TITLE = "COVID-19 Tracker";

  @override
  _Covid19TrackerState createState() => _Covid19TrackerState();
}

class _Covid19TrackerState extends State<Covid19Tracker> {
  final DarkModeStore _darkModeStore = DarkModeStore();

  @override
  void initState() {
    super.initState();
    _darkModeStore.checkDarkMode();
    print("Kernel architecture     : ${SysInfo.kernelArchitecture}");
    print("Kernel bitness          : ${SysInfo.kernelBitness}");
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => NeumorphicTheme(
          usedTheme:
              !_darkModeStore.isDarkMode ? UsedTheme.LIGHT : UsedTheme.DARK,
          theme: NeumorphicThemeData(
              baseColor: Color(0xFFe4e9ed),
              intensity: 0.8,
              lightSource: LightSource.topLeft,
              depth: 2,
              accentColor: Colors.black87,
              defaultTextColor: Colors.black87),
          darkTheme: NeumorphicThemeData(
              baseColor: Color(0xFF191C23),
              intensity: 0.5,
              lightSource: LightSource.topLeft,
              depth: 2,
              accentColor: const Color(0xFF7D9DF8),
              defaultTextColor: Colors.white),
          child: MaterialApp(
            title: Covid19Tracker.APP_TITLE,
            theme: ThemeData(
              primaryColor: const Color(0xFF5791F8),
              accentColor: const Color(0xFF7D9DF8),
              textTheme: GoogleFonts.firaSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: Home(),
          )),
    );
  }
}
