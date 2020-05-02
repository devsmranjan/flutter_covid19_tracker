// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocationStore on _LocationStoreBase, Store {
  final _$countryAtom = Atom(name: '_LocationStoreBase.country');

  @override
  String get country {
    _$countryAtom.context.enforceReadPolicy(_$countryAtom);
    _$countryAtom.reportObserved();
    return super.country;
  }

  @override
  set country(String value) {
    _$countryAtom.context.conditionallyRunInAction(() {
      super.country = value;
      _$countryAtom.reportChanged();
    }, _$countryAtom, name: '${_$countryAtom.name}_set');
  }

  final _$stateAtom = Atom(name: '_LocationStoreBase.state');

  @override
  String get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(String value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$distAtom = Atom(name: '_LocationStoreBase.dist');

  @override
  String get dist {
    _$distAtom.context.enforceReadPolicy(_$distAtom);
    _$distAtom.reportObserved();
    return super.dist;
  }

  @override
  set dist(String value) {
    _$distAtom.context.conditionallyRunInAction(() {
      super.dist = value;
      _$distAtom.reportChanged();
    }, _$distAtom, name: '${_$distAtom.name}_set');
  }

  final _$isLocationEnabledAtom =
      Atom(name: '_LocationStoreBase.isLocationEnabled');

  @override
  bool get isLocationEnabled {
    _$isLocationEnabledAtom.context.enforceReadPolicy(_$isLocationEnabledAtom);
    _$isLocationEnabledAtom.reportObserved();
    return super.isLocationEnabled;
  }

  @override
  set isLocationEnabled(bool value) {
    _$isLocationEnabledAtom.context.conditionallyRunInAction(() {
      super.isLocationEnabled = value;
      _$isLocationEnabledAtom.reportChanged();
    }, _$isLocationEnabledAtom, name: '${_$isLocationEnabledAtom.name}_set');
  }

  final _$isLocationPermissionGrantedAtom =
      Atom(name: '_LocationStoreBase.isLocationPermissionGranted');

  @override
  bool get isLocationPermissionGranted {
    _$isLocationPermissionGrantedAtom.context
        .enforceReadPolicy(_$isLocationPermissionGrantedAtom);
    _$isLocationPermissionGrantedAtom.reportObserved();
    return super.isLocationPermissionGranted;
  }

  @override
  set isLocationPermissionGranted(bool value) {
    _$isLocationPermissionGrantedAtom.context.conditionallyRunInAction(() {
      super.isLocationPermissionGranted = value;
      _$isLocationPermissionGrantedAtom.reportChanged();
    }, _$isLocationPermissionGrantedAtom,
        name: '${_$isLocationPermissionGrantedAtom.name}_set');
  }

  final _$getLocationAsyncAction = AsyncAction('getLocation');

  @override
  Future<dynamic> getLocation() {
    return _$getLocationAsyncAction.run(() => super.getLocation());
  }

  final _$_LocationStoreBaseActionController =
      ActionController(name: '_LocationStoreBase');

  @override
  void updateLocationPermissionGranted(bool update) {
    final _$actionInfo = _$_LocationStoreBaseActionController.startAction();
    try {
      return super.updateLocationPermissionGranted(update);
    } finally {
      _$_LocationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'country: ${country.toString()},state: ${state.toString()},dist: ${dist.toString()},isLocationEnabled: ${isLocationEnabled.toString()},isLocationPermissionGranted: ${isLocationPermissionGranted.toString()}';
    return '{$string}';
  }
}
