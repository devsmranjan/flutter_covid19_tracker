import 'package:mobx/mobx.dart';

part 'zones_filter.g.dart';

class ZonesFilter = _ZonesFilter with _$ZonesFilter;

abstract class _ZonesFilter with Store {
  @observable
  String filterState = "";

  @observable
  String filterZone = "";

  @action
  void updateFilterState(String state) {
    filterState = state;
  }

  @action
  void updateFilterZone(String zone) {
    filterZone = zone;
  }
}
