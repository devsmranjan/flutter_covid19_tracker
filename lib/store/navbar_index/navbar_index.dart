import 'package:mobx/mobx.dart';

part 'navbar_index.g.dart';


class NavbarIndexStore extends _NavbarIndexStoreBase with _$NavbarIndexStore {
  static NavbarIndexStore _instance = NavbarIndexStore._();

  factory NavbarIndexStore() => _instance;

  NavbarIndexStore._();
}

abstract class _NavbarIndexStoreBase with Store {
  @observable
  int selectedIndex = 0;

  @action
  void updateIndex(index) {
    selectedIndex = index;
  }
}
