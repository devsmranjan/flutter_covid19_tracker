import 'package:mobx/mobx.dart';

part 'essentials_filter.g.dart';

class EssentialsFilter = _EssentialsFilter with _$EssentialsFilter;

abstract class _EssentialsFilter with Store {
  @observable
  String filterState = "";

  @observable
  String filterCity = "";

  @observable
  String filterServices = "";

  @action
  void updateFilterState(String state) {
    filterState = state;
  }

  @action
  void updateFilterCity(String city) {
    filterCity = city;
  }

  @action
  void updateFilterServices(String service) {
    filterServices = service;
  }
}
