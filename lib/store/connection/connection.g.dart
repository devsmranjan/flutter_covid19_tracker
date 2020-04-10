// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectionStore on _ConnectionStoreBase, Store {
  final _$isInternetConnectedAtom =
      Atom(name: '_ConnectionStoreBase.isInternetConnected');

  @override
  bool get isInternetConnected {
    _$isInternetConnectedAtom.context
        .enforceReadPolicy(_$isInternetConnectedAtom);
    _$isInternetConnectedAtom.reportObserved();
    return super.isInternetConnected;
  }

  @override
  set isInternetConnected(bool value) {
    _$isInternetConnectedAtom.context.conditionallyRunInAction(() {
      super.isInternetConnected = value;
      _$isInternetConnectedAtom.reportChanged();
    }, _$isInternetConnectedAtom,
        name: '${_$isInternetConnectedAtom.name}_set');
  }

  final _$_ConnectionStoreBaseActionController =
      ActionController(name: '_ConnectionStoreBase');

  @override
  void updateInternetConnection(bool update) {
    final _$actionInfo = _$_ConnectionStoreBaseActionController.startAction();
    try {
      return super.updateInternetConnection(update);
    } finally {
      _$_ConnectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isInternetConnected: ${isInternetConnected.toString()}';
    return '{$string}';
  }
}
