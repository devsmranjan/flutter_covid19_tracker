// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zones_filter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ZonesFilter on _ZonesFilter, Store {
  final _$filterStateAtom = Atom(name: '_ZonesFilter.filterState');

  @override
  String get filterState {
    _$filterStateAtom.context.enforceReadPolicy(_$filterStateAtom);
    _$filterStateAtom.reportObserved();
    return super.filterState;
  }

  @override
  set filterState(String value) {
    _$filterStateAtom.context.conditionallyRunInAction(() {
      super.filterState = value;
      _$filterStateAtom.reportChanged();
    }, _$filterStateAtom, name: '${_$filterStateAtom.name}_set');
  }

  final _$filterZoneAtom = Atom(name: '_ZonesFilter.filterZone');

  @override
  String get filterZone {
    _$filterZoneAtom.context.enforceReadPolicy(_$filterZoneAtom);
    _$filterZoneAtom.reportObserved();
    return super.filterZone;
  }

  @override
  set filterZone(String value) {
    _$filterZoneAtom.context.conditionallyRunInAction(() {
      super.filterZone = value;
      _$filterZoneAtom.reportChanged();
    }, _$filterZoneAtom, name: '${_$filterZoneAtom.name}_set');
  }

  final _$_ZonesFilterActionController = ActionController(name: '_ZonesFilter');

  @override
  void updateFilterState(String state) {
    final _$actionInfo = _$_ZonesFilterActionController.startAction();
    try {
      return super.updateFilterState(state);
    } finally {
      _$_ZonesFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFilterZone(String zone) {
    final _$actionInfo = _$_ZonesFilterActionController.startAction();
    try {
      return super.updateFilterZone(zone);
    } finally {
      _$_ZonesFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filterState: ${filterState.toString()},filterZone: ${filterZone.toString()}';
    return '{$string}';
  }
}
