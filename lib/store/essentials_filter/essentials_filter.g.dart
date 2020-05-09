// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'essentials_filter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EssentialsFilter on _EssentialsFilter, Store {
  final _$filterStateAtom = Atom(name: '_EssentialsFilter.filterState');

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

  final _$filterCityAtom = Atom(name: '_EssentialsFilter.filterCity');

  @override
  String get filterCity {
    _$filterCityAtom.context.enforceReadPolicy(_$filterCityAtom);
    _$filterCityAtom.reportObserved();
    return super.filterCity;
  }

  @override
  set filterCity(String value) {
    _$filterCityAtom.context.conditionallyRunInAction(() {
      super.filterCity = value;
      _$filterCityAtom.reportChanged();
    }, _$filterCityAtom, name: '${_$filterCityAtom.name}_set');
  }

  final _$filterServicesAtom = Atom(name: '_EssentialsFilter.filterServices');

  @override
  String get filterServices {
    _$filterServicesAtom.context.enforceReadPolicy(_$filterServicesAtom);
    _$filterServicesAtom.reportObserved();
    return super.filterServices;
  }

  @override
  set filterServices(String value) {
    _$filterServicesAtom.context.conditionallyRunInAction(() {
      super.filterServices = value;
      _$filterServicesAtom.reportChanged();
    }, _$filterServicesAtom, name: '${_$filterServicesAtom.name}_set');
  }

  final _$_EssentialsFilterActionController =
      ActionController(name: '_EssentialsFilter');

  @override
  void updateFilterState(String state) {
    final _$actionInfo = _$_EssentialsFilterActionController.startAction();
    try {
      return super.updateFilterState(state);
    } finally {
      _$_EssentialsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFilterCity(String city) {
    final _$actionInfo = _$_EssentialsFilterActionController.startAction();
    try {
      return super.updateFilterCity(city);
    } finally {
      _$_EssentialsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFilterServices(String service) {
    final _$actionInfo = _$_EssentialsFilterActionController.startAction();
    try {
      return super.updateFilterServices(service);
    } finally {
      _$_EssentialsFilterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filterState: ${filterState.toString()},filterCity: ${filterCity.toString()},filterServices: ${filterServices.toString()}';
    return '{$string}';
  }
}
