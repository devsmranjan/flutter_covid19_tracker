class API2WorldTotalStatistics {
  int confirmed;
  int recovered;
  int deaths;
  int deltaConfirmed;
  int deltaDeathes;
  int lastUpdatedTime;

  API2WorldTotalStatistics(
      {this.confirmed,
      this.recovered,
      this.deaths,
      this.deltaConfirmed,
      this.deltaDeathes,
      this.lastUpdatedTime});

  API2WorldTotalStatistics.fromJson(Map<String, dynamic> json) {
    confirmed = json['cases'];
    recovered = json['recovered'];
    deaths = json['deaths'];
    deltaConfirmed = json['todayCases'];
    deltaDeathes = json['todayDeaths'];
    lastUpdatedTime = json['updated'];
  }
}
