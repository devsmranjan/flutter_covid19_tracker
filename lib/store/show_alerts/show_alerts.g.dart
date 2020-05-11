// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_alerts.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShowAlertsStore on _ShowAlerts, Store {
  final _$confirmedAtom = Atom(name: '_ShowAlerts.confirmed');

  @override
  Map<String, int> get confirmed {
    _$confirmedAtom.context.enforceReadPolicy(_$confirmedAtom);
    _$confirmedAtom.reportObserved();
    return super.confirmed;
  }

  @override
  set confirmed(Map<String, int> value) {
    _$confirmedAtom.context.conditionallyRunInAction(() {
      super.confirmed = value;
      _$confirmedAtom.reportChanged();
    }, _$confirmedAtom, name: '${_$confirmedAtom.name}_set');
  }

  final _$recoveredAtom = Atom(name: '_ShowAlerts.recovered');

  @override
  Map<String, int> get recovered {
    _$recoveredAtom.context.enforceReadPolicy(_$recoveredAtom);
    _$recoveredAtom.reportObserved();
    return super.recovered;
  }

  @override
  set recovered(Map<String, int> value) {
    _$recoveredAtom.context.conditionallyRunInAction(() {
      super.recovered = value;
      _$recoveredAtom.reportChanged();
    }, _$recoveredAtom, name: '${_$recoveredAtom.name}_set');
  }

  final _$deceasedAtom = Atom(name: '_ShowAlerts.deceased');

  @override
  Map<String, int> get deceased {
    _$deceasedAtom.context.enforceReadPolicy(_$deceasedAtom);
    _$deceasedAtom.reportObserved();
    return super.deceased;
  }

  @override
  set deceased(Map<String, int> value) {
    _$deceasedAtom.context.conditionallyRunInAction(() {
      super.deceased = value;
      _$deceasedAtom.reportChanged();
    }, _$deceasedAtom, name: '${_$deceasedAtom.name}_set');
  }

  final _$showConfirmedAlertAtom = Atom(name: '_ShowAlerts.showConfirmedAlert');

  @override
  bool get showConfirmedAlert {
    _$showConfirmedAlertAtom.context
        .enforceReadPolicy(_$showConfirmedAlertAtom);
    _$showConfirmedAlertAtom.reportObserved();
    return super.showConfirmedAlert;
  }

  @override
  set showConfirmedAlert(bool value) {
    _$showConfirmedAlertAtom.context.conditionallyRunInAction(() {
      super.showConfirmedAlert = value;
      _$showConfirmedAlertAtom.reportChanged();
    }, _$showConfirmedAlertAtom, name: '${_$showConfirmedAlertAtom.name}_set');
  }

  final _$showRecoveredAlertAtom = Atom(name: '_ShowAlerts.showRecoveredAlert');

  @override
  bool get showRecoveredAlert {
    _$showRecoveredAlertAtom.context
        .enforceReadPolicy(_$showRecoveredAlertAtom);
    _$showRecoveredAlertAtom.reportObserved();
    return super.showRecoveredAlert;
  }

  @override
  set showRecoveredAlert(bool value) {
    _$showRecoveredAlertAtom.context.conditionallyRunInAction(() {
      super.showRecoveredAlert = value;
      _$showRecoveredAlertAtom.reportChanged();
    }, _$showRecoveredAlertAtom, name: '${_$showRecoveredAlertAtom.name}_set');
  }

  final _$showDeceasedAlertAtom = Atom(name: '_ShowAlerts.showDeceasedAlert');

  @override
  bool get showDeceasedAlert {
    _$showDeceasedAlertAtom.context.enforceReadPolicy(_$showDeceasedAlertAtom);
    _$showDeceasedAlertAtom.reportObserved();
    return super.showDeceasedAlert;
  }

  @override
  set showDeceasedAlert(bool value) {
    _$showDeceasedAlertAtom.context.conditionallyRunInAction(() {
      super.showDeceasedAlert = value;
      _$showDeceasedAlertAtom.reportChanged();
    }, _$showDeceasedAlertAtom, name: '${_$showDeceasedAlertAtom.name}_set');
  }

  final _$confirmedAlertTextAtom = Atom(name: '_ShowAlerts.confirmedAlertText');

  @override
  String get confirmedAlertText {
    _$confirmedAlertTextAtom.context
        .enforceReadPolicy(_$confirmedAlertTextAtom);
    _$confirmedAlertTextAtom.reportObserved();
    return super.confirmedAlertText;
  }

  @override
  set confirmedAlertText(String value) {
    _$confirmedAlertTextAtom.context.conditionallyRunInAction(() {
      super.confirmedAlertText = value;
      _$confirmedAlertTextAtom.reportChanged();
    }, _$confirmedAlertTextAtom, name: '${_$confirmedAlertTextAtom.name}_set');
  }

  final _$recoveredAlertTextAtom = Atom(name: '_ShowAlerts.recoveredAlertText');

  @override
  String get recoveredAlertText {
    _$recoveredAlertTextAtom.context
        .enforceReadPolicy(_$recoveredAlertTextAtom);
    _$recoveredAlertTextAtom.reportObserved();
    return super.recoveredAlertText;
  }

  @override
  set recoveredAlertText(String value) {
    _$recoveredAlertTextAtom.context.conditionallyRunInAction(() {
      super.recoveredAlertText = value;
      _$recoveredAlertTextAtom.reportChanged();
    }, _$recoveredAlertTextAtom, name: '${_$recoveredAlertTextAtom.name}_set');
  }

  final _$deceasedAlertTextAtom = Atom(name: '_ShowAlerts.deceasedAlertText');

  @override
  String get deceasedAlertText {
    _$deceasedAlertTextAtom.context.enforceReadPolicy(_$deceasedAlertTextAtom);
    _$deceasedAlertTextAtom.reportObserved();
    return super.deceasedAlertText;
  }

  @override
  set deceasedAlertText(String value) {
    _$deceasedAlertTextAtom.context.conditionallyRunInAction(() {
      super.deceasedAlertText = value;
      _$deceasedAlertTextAtom.reportChanged();
    }, _$deceasedAlertTextAtom, name: '${_$deceasedAlertTextAtom.name}_set');
  }

  final _$_ShowAlertsActionController = ActionController(name: '_ShowAlerts');

  @override
  void updateConfirmed(dynamic update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateConfirmed(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateShowConfirmedAlert(bool update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateShowConfirmedAlert(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateShowRecoveredAlert(bool update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateShowRecoveredAlert(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateShowDeceasedAlert(bool update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateShowDeceasedAlert(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateConfirmedAlertText(String update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateConfirmedAlertText(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRecoveredAlertText(String update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateRecoveredAlertText(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDeceasedAlertText(String update) {
    final _$actionInfo = _$_ShowAlertsActionController.startAction();
    try {
      return super.updateDeceasedAlertText(update);
    } finally {
      _$_ShowAlertsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'confirmed: ${confirmed.toString()},recovered: ${recovered.toString()},deceased: ${deceased.toString()},showConfirmedAlert: ${showConfirmedAlert.toString()},showRecoveredAlert: ${showRecoveredAlert.toString()},showDeceasedAlert: ${showDeceasedAlert.toString()},confirmedAlertText: ${confirmedAlertText.toString()},recoveredAlertText: ${recoveredAlertText.toString()},deceasedAlertText: ${deceasedAlertText.toString()}';
    return '{$string}';
  }
}
