import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'keys.g.dart';

class KeysStore extends _KeysStoreBase with _$KeysStore {
  static KeysStore _instance = KeysStore._();

  factory KeysStore() => _instance;

  KeysStore._();
}

abstract class _KeysStoreBase with Store {
  @observable
  GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
}
