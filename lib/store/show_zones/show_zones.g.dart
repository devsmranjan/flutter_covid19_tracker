// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_zones.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShowZones on _ShowZones, Store {
  final _$isShowZonesAtom = Atom(name: '_ShowZones.isShowZones');

  @override
  bool get isShowZones {
    _$isShowZonesAtom.context.enforceReadPolicy(_$isShowZonesAtom);
    _$isShowZonesAtom.reportObserved();
    return super.isShowZones;
  }

  @override
  set isShowZones(bool value) {
    _$isShowZonesAtom.context.conditionallyRunInAction(() {
      super.isShowZones = value;
      _$isShowZonesAtom.reportChanged();
    }, _$isShowZonesAtom, name: '${_$isShowZonesAtom.name}_set');
  }

  final _$_ShowZonesActionController = ActionController(name: '_ShowZones');

  @override
  void updateShowZones(bool update) {
    final _$actionInfo = _$_ShowZonesActionController.startAction();
    try {
      return super.updateShowZones(update);
    } finally {
      _$_ShowZonesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isShowZones: ${isShowZones.toString()}';
    return '{$string}';
  }
}
