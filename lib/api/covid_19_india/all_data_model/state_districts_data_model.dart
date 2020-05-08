class API1StateDistrictsData {
  List<AllDistrictsData> allStatesDistrictsData;

  API1StateDistrictsData({this.allStatesDistrictsData});

  API1StateDistrictsData.fromJson(List<dynamic> json) {
    allStatesDistrictsData =
        json.map((v) => AllDistrictsData.fromJson(v)).toList();
  }
}

class AllDistrictsData {
  String state;
  String stateCode;
  List<DistrictData> districtData;

  AllDistrictsData({this.state, this.stateCode, this.districtData});

  AllDistrictsData.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    stateCode = json['statecode'];

    if (json['districtData'] != null) {
      districtData = List<DistrictData>();

      json['districtData'].forEach((v) {
        districtData.add(DistrictData.fromJson(v));
      });
    }
  }
}

class DistrictData {
  String district;
  int confirmed;
  int active;
  int recovered;
  int deceased;
  Delta delta;

  DistrictData(
      {this.district,
      this.confirmed,
      this.active,
      this.recovered,
      this.deceased,
      this.delta});

  DistrictData.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    confirmed = json['confirmed'];
    active = json['active'];
    recovered = json['recovered'];
    deceased = json['deceased'];
    delta = Delta.fromJson(json['delta']);
  }
}

class Delta {
  int confirmed;
  int recovered;
  int deceased;

  Delta({this.confirmed, this.recovered, this.deceased});

  Delta.fromJson(Map<String, dynamic> json) {
    confirmed = json["confirmed"];
    recovered = json["recovered"];
    deceased = json["deceased"];
  }
}
