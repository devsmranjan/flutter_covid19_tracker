import 'package:covid19_tracker/api/covid_19_india/all_data_model/state_districts_data_model.dart';
import 'package:mobx/mobx.dart';

part 'search.g.dart';

class SearchStore = _SearchStoreBase with _$SearchStore;

abstract class _SearchStoreBase with Store {
  @observable
  String searchFilterText = "";

  @observable
  ObservableList<dynamic> observableList;

  @action
  void addObservableList(List list) {
    observableList = ObservableList();
    list.forEach((data) {
      observableList.add(data);
    });
  }

  @action
  void updateSearchFilterText(String filterText) {
    searchFilterText = filterText;
  }

  @action
  void clearSearchFilterText() {
    searchFilterText = "";
  }
}
