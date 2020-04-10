class HelplinesStatewiseData {
  List<HelplinesOfState> helplinesOfStatesList;

  HelplinesStatewiseData.fromJson(List<dynamic> json) {
    helplinesOfStatesList = json.map((i) => HelplinesOfState.fromJson(i)).toList();
  }
}

class HelplinesOfState {
  String state;
  List<String> helplinesList;

  HelplinesOfState.fromJson(Map<String, dynamic> json) {
    state = json['state'];

    if (json['helplines'] != null) {
      helplinesList = List<String>();
      json['helplines'].forEach((v) {
        helplinesList.add(v);
      });
    }
  }
}