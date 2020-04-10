import 'package:mobx/mobx.dart';

part 'connection.g.dart';

class ConnectionStore extends _ConnectionStoreBase with _$ConnectionStore {
  static ConnectionStore _instance = ConnectionStore._();

  factory ConnectionStore() => _instance;

  ConnectionStore._();
}

abstract class _ConnectionStoreBase with Store {
  @observable
  bool isInternetConnected = true;

  @action
  void updateInternetConnection(bool update) {
    isInternetConnected = update;
  }
}
