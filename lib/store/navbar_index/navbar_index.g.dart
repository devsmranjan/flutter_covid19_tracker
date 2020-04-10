// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navbar_index.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavbarIndexStore on _NavbarIndexStoreBase, Store {
  final _$selectedIndexAtom = Atom(name: '_NavbarIndexStoreBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.context.enforceReadPolicy(_$selectedIndexAtom);
    _$selectedIndexAtom.reportObserved();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.context.conditionallyRunInAction(() {
      super.selectedIndex = value;
      _$selectedIndexAtom.reportChanged();
    }, _$selectedIndexAtom, name: '${_$selectedIndexAtom.name}_set');
  }

  final _$_NavbarIndexStoreBaseActionController =
      ActionController(name: '_NavbarIndexStoreBase');

  @override
  void updateIndex(dynamic index) {
    final _$actionInfo = _$_NavbarIndexStoreBaseActionController.startAction();
    try {
      return super.updateIndex(index);
    } finally {
      _$_NavbarIndexStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'selectedIndex: ${selectedIndex.toString()}';
    return '{$string}';
  }
}
