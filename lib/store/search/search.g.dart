// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStoreBase, Store {
  final _$searchFilterTextAtom =
      Atom(name: '_SearchStoreBase.searchFilterText');

  @override
  String get searchFilterText {
    _$searchFilterTextAtom.context.enforceReadPolicy(_$searchFilterTextAtom);
    _$searchFilterTextAtom.reportObserved();
    return super.searchFilterText;
  }

  @override
  set searchFilterText(String value) {
    _$searchFilterTextAtom.context.conditionallyRunInAction(() {
      super.searchFilterText = value;
      _$searchFilterTextAtom.reportChanged();
    }, _$searchFilterTextAtom, name: '${_$searchFilterTextAtom.name}_set');
  }

  final _$observableListAtom = Atom(name: '_SearchStoreBase.observableList');

  @override
  ObservableList<dynamic> get observableList {
    _$observableListAtom.context.enforceReadPolicy(_$observableListAtom);
    _$observableListAtom.reportObserved();
    return super.observableList;
  }

  @override
  set observableList(ObservableList<dynamic> value) {
    _$observableListAtom.context.conditionallyRunInAction(() {
      super.observableList = value;
      _$observableListAtom.reportChanged();
    }, _$observableListAtom, name: '${_$observableListAtom.name}_set');
  }

  final _$_SearchStoreBaseActionController =
      ActionController(name: '_SearchStoreBase');

  @override
  void addObservableList(List<dynamic> list) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction();
    try {
      return super.addObservableList(list);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearObservableList() {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction();
    try {
      return super.clearObservableList();
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearchFilterText(String filterText) {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction();
    try {
      return super.updateSearchFilterText(filterText);
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchFilterText() {
    final _$actionInfo = _$_SearchStoreBaseActionController.startAction();
    try {
      return super.clearSearchFilterText();
    } finally {
      _$_SearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'searchFilterText: ${searchFilterText.toString()},observableList: ${observableList.toString()}';
    return '{$string}';
  }
}
