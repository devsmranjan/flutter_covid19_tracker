class API1ZonesData {
  List<Zone> allZones;

  API1ZonesData({this.allZones});

  API1ZonesData.fromJson(Map<String, dynamic> json) {
    if (json['zones'] != null) {
      allZones = List<Zone>();

      json['zones'].forEach((v) {
        allZones.add(Zone.fromJson(v));
      });
    }
  }
}

class Zone {
  String state;
  String district;
  String zone;
  String lastUpdatedTime;

  Zone({this.state, this.district, this.zone, this.lastUpdatedTime});

  Zone.fromJson(Map<String, dynamic> json) {
    state = json["state"];
    district = json["district"];
    zone = json["zone"];
    lastUpdatedTime = json["lastupdated"];
  }
}
