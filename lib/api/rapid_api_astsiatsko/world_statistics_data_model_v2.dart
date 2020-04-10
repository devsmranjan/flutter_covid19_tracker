class WorldStatisticsDataModelV2 {
  String confirmed;
  String active;
  String recovered;
  String deaths;
  String deltaConfirmed;
  String deltaDeathes;
  String lastUpdatedTime;

  WorldStatisticsDataModelV2(
      {this.confirmed,
      this.active,
      this.recovered,
      this.deaths,
      this.deltaConfirmed,
      this.deltaDeathes,
      this.lastUpdatedTime});
}
