class API1StateDistrictsData {
  List<AllDistrictsData> allStatesDistrictsData;

  API1StateDistrictsData({this.allStatesDistrictsData});

  API1StateDistrictsData.fromJson(List<dynamic> json) {
    allStatesDistrictsData = json.map((v) => AllDistrictsData.fromJson(v)).toList();
  }
}

class AllDistrictsData {
  String state;
  List<DistrictData> districtData;

  AllDistrictsData({this.state, this.districtData});

  AllDistrictsData.fromJson(Map<String, dynamic> json) {
    state = json['state'];

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
  String lastUpdatedTime;
  Delta delta;

  DistrictData(
      {this.district, this.confirmed, this.lastUpdatedTime, this.delta});

  DistrictData.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    confirmed = json['confirmed'];
    lastUpdatedTime = json['lastupdatedtime'];
    delta = Delta.fromJson(json['delta']);
  }
}

class Delta {
  int confirmed;

  Delta({this.confirmed});

  Delta.fromJson(Map<String, dynamic> json) {
    confirmed = json["confirmed"];
  }
}
