class API2CasesByCountriesData {
  String lastUpdatedTime;
  List<CountryData> countryData;

  API2CasesByCountriesData.fromJson(Map<String, dynamic> json) {
    lastUpdatedTime = json['statistic_taken_at'];

     if (json['countries_stat'] != null) {
      countryData = List<CountryData>();
      json['countries_stat'].forEach((v) {
        countryData.add(CountryData.fromJson(v));
      });
    }
  }
}

class CountryData {
  String countryName;
  String confirmed;
  String active;
  String recovered;
  String deaths;
  String deltaConfirmed;
  String deltaDeaths;

  CountryData({
    this.countryName,
    this.confirmed,
    this.active,
    this.recovered,
    this.deaths,
    this.deltaConfirmed,
    this.deltaDeaths,
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    confirmed = json['cases'];
    active = json['active_cases'];
    confirmed = json['cases'];
    deaths = json['deaths'];
    recovered = json['total_recovered'];
    deltaConfirmed = json['new_cases'];
    deltaDeaths = json['new_deaths'];
  }
 
}