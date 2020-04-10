class API2WorldTotalStatistics {
  String confirmed;
  String recovered;
  String deaths;
  String deltaConfirmed;
  String deltaDeathes;
  String lastUpdatedTime;

  API2WorldTotalStatistics(
      {this.confirmed,
      this.recovered,
      this.deaths,
      this.deltaConfirmed,
      this.deltaDeathes,
      this.lastUpdatedTime});

  API2WorldTotalStatistics.fromJson(Map<String, dynamic> json) {
    confirmed = json['total_cases'];
    recovered = json['total_recovered'];
    deaths = json['total_deaths'];
    deltaConfirmed = json['new_cases'];
    deltaDeathes = json['new_deaths'];
    lastUpdatedTime = json['statistic_taken_at'];
  }
}
