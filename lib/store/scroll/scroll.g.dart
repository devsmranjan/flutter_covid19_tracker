// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scroll.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScrollStore on _ScrollStoreBase, Store {
  final _$isScrollReachedAtom = Atom(name: '_ScrollStoreBase.isScrollReached');

  @override
  bool get isScrollReached {
    _$isScrollReachedAtom.context.enforceReadPolicy(_$isScrollReachedAtom);
    _$isScrollReachedAtom.reportObserved();
    return super.isScrollReached;
  }

  @override
  set isScrollReached(bool value) {
    _$isScrollReachedAtom.context.conditionallyRunInAction(() {
      super.isScrollReached = value;
      _$isScrollReachedAtom.reportChanged();
    }, _$isScrollReachedAtom, name: '${_$isScrollReachedAtom.name}_set');
  }

  final _$scrollReachedTimesAtom =
      Atom(name: '_ScrollStoreBase.scrollReachedTimes');

  @override
  int get scrollReachedTimes {
    _$scrollReachedTimesAtom.context
        .enforceReadPolicy(_$scrollReachedTimesAtom);
    _$scrollReachedTimesAtom.reportObserved();
    return super.scrollReachedTimes;
  }

  @override
  set scrollReachedTimes(int value) {
    _$scrollReachedTimesAtom.context.conditionallyRunInAction(() {
      super.scrollReachedTimes = value;
      _$scrollReachedTimesAtom.reportChanged();
    }, _$scrollReachedTimesAtom, name: '${_$scrollReachedTimesAtom.name}_set');
  }

  final _$_ScrollStoreBaseActionController =
      ActionController(name: '_ScrollStoreBase');

  @override
  void updateScrollReached(
      ScrollController scrollController, dynamic offsetToReach) {
    final _$actionInfo = _$_ScrollStoreBaseActionController.startAction();
    try {
      return super.updateScrollReached(scrollController, offsetToReach);
    } finally {
      _$_ScrollStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isScrollReached: ${isScrollReached.toString()},scrollReachedTimes: ${scrollReachedTimes.toString()}';
    return '{$string}';
  }
}
