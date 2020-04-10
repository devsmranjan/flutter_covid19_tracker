class API1Data {
  List<StateData> stateData;
  List<CasesTimeSeries> casesTimeSeriesData;

  API1Data.fromJson(Map<String, dynamic> json) {
    // state data
    if (json['statewise'] != null) {
      stateData = List<StateData>();
      json['statewise'].forEach((v) {
        stateData.add(StateData.fromJson(v));
      });
    }

    // cases_time_series data
    if (json['cases_time_series'] != null) {
      casesTimeSeriesData = List<CasesTimeSeries>();
      json['cases_time_series'].forEach((v) {
        casesTimeSeriesData.add(CasesTimeSeries.fromJson(v));
      });
    }
  }
}

class CasesTimeSeries {
  String totalConfirmed;
  String totalRecovered;
  String totalDeceased;
  String date;

  CasesTimeSeries(
      {this.totalConfirmed,
      this.totalRecovered,
      this.totalDeceased,
      this.date});

  CasesTimeSeries.fromJson(Map<String, dynamic> json) {
    totalConfirmed = json['totalconfirmed'];
    totalRecovered = json['totalrecovered'];
    totalDeceased = json['totaldeceased'];
    date = json['date'];
  }
}

class StateData {
  String state;
  String stateCode;
  String active;
  String confirmed;
  String deaths;
  String recovered;
  String deltaConfirmed;
  String deltaRecovered;
  String deltaDeaths;
  String lastUpdatedTime;

  StateData(
      {this.state,
      this.stateCode,
      this.active,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.deltaConfirmed,
      this.deltaRecovered,
      this.deltaDeaths,
      this.lastUpdatedTime});

  StateData.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    stateCode = json['statecode'];
    active = json['active'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    deltaConfirmed = json['deltaconfirmed'];
    deltaRecovered = json['deltarecovered'];
    deltaDeaths = json['deltadeaths'];
    lastUpdatedTime = json['lastupdatedtime'];
  }
}
