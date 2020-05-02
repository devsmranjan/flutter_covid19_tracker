// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$KeysStore on _KeysStoreBase, Store {
  final _$homeScaffoldKeyAtom = Atom(name: '_KeysStoreBase.homeScaffoldKey');

  @override
  GlobalKey<ScaffoldState> get homeScaffoldKey {
    _$homeScaffoldKeyAtom.context.enforceReadPolicy(_$homeScaffoldKeyAtom);
    _$homeScaffoldKeyAtom.reportObserved();
    return super.homeScaffoldKey;
  }

  @override
  set homeScaffoldKey(GlobalKey<ScaffoldState> value) {
    _$homeScaffoldKeyAtom.context.conditionallyRunInAction(() {
      super.homeScaffoldKey = value;
      _$homeScaffoldKeyAtom.reportChanged();
    }, _$homeScaffoldKeyAtom, name: '${_$homeScaffoldKeyAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'homeScaffoldKey: ${homeScaffoldKey.toString()}';
    return '{$string}';
  }
}
