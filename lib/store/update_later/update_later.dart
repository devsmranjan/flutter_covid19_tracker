import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_later.g.dart';

class UpdateLaterStore extends _UpdateLaterStoreBase with _$UpdateLaterStore {
  static UpdateLaterStore _instance = UpdateLaterStore._();

  factory UpdateLaterStore() => _instance;

  UpdateLaterStore._();
}

abstract class _UpdateLaterStoreBase with Store {
  SharedPreferences _prefs;

  @observable
  bool isUpdateLater = false;

  @action
  Future checkUpdateLater() async {
    _prefs = await SharedPreferences.getInstance();
    isUpdateLater = _prefs.getBool('isUpdateLater') ?? false;
  }

  @action
  Future updateUpdatePopup(bool update) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isUpdateLater', update);
    isUpdateLater = update;
  }
}
