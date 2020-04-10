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

  final _$getLocationAsyncAction = AsyncAction('getLocation');

  @override
  Future<dynamic> getLocation() {
    return _$getLocationAsyncAction.run(() => super.getLocation());
  }

  @override
  String toString() {
    final string =
        'country: ${country.toString()},state: ${state.toString()},dist: ${dist.toString()}';
    return '{$string}';
  }
}
