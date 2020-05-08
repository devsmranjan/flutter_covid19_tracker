import 'package:mobx/mobx.dart';

part 'show_zones.g.dart';

class ShowZones = _ShowZones with _$ShowZones;

abstract class _ShowZones with Store {
  @observable
  bool isShowZones = false;

  @action
  void updateShowZones(bool update) {
    isShowZones = update;
  }
}
