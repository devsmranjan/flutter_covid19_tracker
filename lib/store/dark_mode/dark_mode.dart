import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dark_mode.g.dart';

class DarkModeStore extends _DarkModeStoreBase with _$DarkModeStore {
  static DarkModeStore _instance = DarkModeStore._();

  factory DarkModeStore() => _instance;

  DarkModeStore._();
}

abstract class _DarkModeStoreBase with Store {
  SharedPreferences prefs;

  @observable
  bool isDarkMode = false;

  @action
  Future checkDarkMode() async {
    prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
  }

  @action
  Future updateDarkMode(bool update) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', update);
    isDarkMode = update;
  }
}
