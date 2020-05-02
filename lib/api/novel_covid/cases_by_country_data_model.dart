class API2CasesByCountriesData {
  List<CountryData> countryData;

  API2CasesByCountriesData({this.countryData});

  API2CasesByCountriesData.fromJson(List<dynamic> json) {
    countryData = json.map((v) => CountryData.fromJson(v)).toList();
  }
}

class CountryData {
  String countryName;
  int confirmed;
  int active;
  int recovered;
  int deaths;
  int deltaConfirmed;
  int deltaDeaths;
  int lastUpdatedTime;

  CountryData(
      {this.countryName,
      this.confirmed,
      this.active,
      this.recovered,
      this.deaths,
      this.deltaConfirmed,
      this.deltaDeaths,
      this.lastUpdatedTime});

  CountryData.fromJson(Map<String, dynamic> json) {
    countryName = json['country'];
    confirmed = json['cases'];
    active = json['active'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    deltaConfirmed = json['todayCases'];
    deltaDeaths = json['todayDeaths'];
    lastUpdatedTime = json['updated'];
  }
}
