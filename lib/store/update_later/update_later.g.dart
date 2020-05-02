// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_later.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UpdateLaterStore on _UpdateLaterStoreBase, Store {
  final _$isUpdateLaterAtom = Atom(name: '_UpdateLaterStoreBase.isUpdateLater');

  @override
  bool get isUpdateLater {
    _$isUpdateLaterAtom.context.enforceReadPolicy(_$isUpdateLaterAtom);
    _$isUpdateLaterAtom.reportObserved();
    return super.isUpdateLater;
  }

  @override
  set isUpdateLater(bool value) {
    _$isUpdateLaterAtom.context.conditionallyRunInAction(() {
      super.isUpdateLater = value;
      _$isUpdateLaterAtom.reportChanged();
    }, _$isUpdateLaterAtom, name: '${_$isUpdateLaterAtom.name}_set');
  }

  final _$isUpdateNowAtom = Atom(name: '_UpdateLaterStoreBase.isUpdateNow');

  @override
  bool get isUpdateNow {
    _$isUpdateNowAtom.context.enforceReadPolicy(_$isUpdateNowAtom);
    _$isUpdateNowAtom.reportObserved();
    return super.isUpdateNow;
  }

  @override
  set isUpdateNow(bool value) {
    _$isUpdateNowAtom.context.conditionallyRunInAction(() {
      super.isUpdateNow = value;
      _$isUpdateNowAtom.reportChanged();
    }, _$isUpdateNowAtom, name: '${_$isUpdateNowAtom.name}_set');
  }

  final _$checkUpdateLaterAsyncAction = AsyncAction('checkUpdateLater');

  @override
  Future<dynamic> checkUpdateLater() {
    return _$checkUpdateLaterAsyncAction.run(() => super.checkUpdateLater());
  }

  final _$updateUpdateLaterAsyncAction = AsyncAction('updateUpdateLater');

  @override
  Future<dynamic> updateUpdateLater(bool update) {
    return _$updateUpdateLaterAsyncAction
        .run(() => super.updateUpdateLater(update));
  }

  final _$_UpdateLaterStoreBaseActionController =
      ActionController(name: '_UpdateLaterStoreBase');

  @override
  void updateUpdateNow(bool update) {
    final _$actionInfo = _$_UpdateLaterStoreBaseActionController.startAction();
    try {
      return super.updateUpdateNow(update);
    } finally {
      _$_UpdateLaterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isUpdateLater: ${isUpdateLater.toString()},isUpdateNow: ${isUpdateNow.toString()}';
    return '{$string}';
  }
}
