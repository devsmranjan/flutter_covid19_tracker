import 'package:mobx/mobx.dart';

part 'show_alerts.g.dart';

class ShowAlertsStore = _ShowAlerts with _$ShowAlertsStore;

abstract class _ShowAlerts with Store {
  @observable
  Map<String, int> confirmed = {};

  @observable
  Map<String, int> recovered = {};

  @observable
  Map<String, int> deceased = {};

  @observable
  bool showConfirmedAlert = false;

  @observable
  bool showRecoveredAlert = false;

  @observable
  bool showDeceasedAlert = false;

  @observable
  String confirmedAlertText = "";

  @observable
  String recoveredAlertText = "";

  @observable
  String deceasedAlertText = "";

  @action
  void updateConfirmed(var update) {
    confirmed = update;
  }

  @action
  void updateShowConfirmedAlert(bool update) {
    showConfirmedAlert = update;
  }

  @action
  void updateShowRecoveredAlert(bool update) {
    showRecoveredAlert = update;
  }

  @action
  void updateShowDeceasedAlert(bool update) {
    showDeceasedAlert = update;
  }

  @action
  void updateConfirmedAlertText(String update) {
    confirmedAlertText = update;
  }

  @action
  void updateRecoveredAlertText(String update) {
    recoveredAlertText = update;
  }

  @action
  void updateDeceasedAlertText(String update) {
    deceasedAlertText = update;
  }
}
