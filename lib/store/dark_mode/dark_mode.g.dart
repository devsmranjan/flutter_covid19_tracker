// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dark_mode.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DarkModeStore on _DarkModeStoreBase, Store {
  final _$isDarkModeAtom = Atom(name: '_DarkModeStoreBase.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.context.enforceReadPolicy(_$isDarkModeAtom);
    _$isDarkModeAtom.reportObserved();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.context.conditionallyRunInAction(() {
      super.isDarkMode = value;
      _$isDarkModeAtom.reportChanged();
    }, _$isDarkModeAtom, name: '${_$isDarkModeAtom.name}_set');
  }

  final _$checkDarkModeAsyncAction = AsyncAction('checkDarkMode');

  @override
  Future<dynamic> checkDarkMode() {
    return _$checkDarkModeAsyncAction.run(() => super.checkDarkMode());
  }

  final _$updateDarkModeAsyncAction = AsyncAction('updateDarkMode');

  @override
  Future<dynamic> updateDarkMode(bool update) {
    return _$updateDarkModeAsyncAction.run(() => super.updateDarkMode(update));
  }

  @override
  String toString() {
    final string = 'isDarkMode: ${isDarkMode.toString()}';
    return '{$string}';
  }
}
