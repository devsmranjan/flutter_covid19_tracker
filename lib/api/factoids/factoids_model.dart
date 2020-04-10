class FactoidsData {
  List<Factoid> factoidsList;

  FactoidsData.fromJson(List<dynamic> json) {
    factoidsList = json.map((i) => Factoid.fromJson(i)).toList();
  }
}

class Factoid {
  int id;
  String message;

  Factoid({this.id, this.message});

  Factoid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
  }
}
