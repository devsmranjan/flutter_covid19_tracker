// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Loading on _Loading, Store {
  final _$isLoadingAtom = Atom(name: '_Loading.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$_LoadingActionController = ActionController(name: '_Loading');

  @override
  void startLoading1000() {
    final _$actionInfo = _$_LoadingActionController.startAction();
    try {
      return super.startLoading1000();
    } finally {
      _$_LoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startLoading2000() {
    final _$actionInfo = _$_LoadingActionController.startAction();
    try {
      return super.startLoading2000();
    } finally {
      _$_LoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startLoading3000() {
    final _$actionInfo = _$_LoadingActionController.startAction();
    try {
      return super.startLoading3000();
    } finally {
      _$_LoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startLoading5000() {
    final _$actionInfo = _$_LoadingActionController.startAction();
    try {
      return super.startLoading5000();
    } finally {
      _$_LoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLoading(bool update) {
    final _$actionInfo = _$_LoadingActionController.startAction();
    try {
      return super.updateLoading(update);
    } finally {
      _$_LoadingActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
