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

  final _$checkUpdateLaterAsyncAction = AsyncAction('checkUpdateLater');

  @override
  Future<dynamic> checkUpdateLater() {
    return _$checkUpdateLaterAsyncAction.run(() => super.checkUpdateLater());
  }

  final _$updateUpdatePopupAsyncAction = AsyncAction('updateUpdatePopup');

  @override
  Future<dynamic> updateUpdatePopup(bool update) {
    return _$updateUpdatePopupAsyncAction
        .run(() => super.updateUpdatePopup(update));
  }

  @override
  String toString() {
    final string = 'isUpdateLater: ${isUpdateLater.toString()}';
    return '{$string}';
  }
}
