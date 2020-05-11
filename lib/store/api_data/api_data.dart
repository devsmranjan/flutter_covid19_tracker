import 'dart:convert';
import 'dart:math';
import 'package:covid19_tracker/api/covid_19_india/all_data_model/resources_model.dart';
import 'package:covid19_tracker/api/covid_19_india/all_data_model/zone_model.dart';
import 'package:covid19_tracker/api/novel_covid/cases_by_country_data_model.dart';
import 'package:covid19_tracker/api/novel_covid/world_statistics_data_model_v2.dart';
import 'package:covid19_tracker/api/novel_covid/world_total_statistics.dart';

import '../../api/app_versions/app_versions_model.dart';
import '../../api/donation/donation_model.dart';
import '../../api/factoids/factoids_model.dart';
import '../../api/help_lines/help_lines.dart';
// import '../../api/rapid_api_astsiatsko/world_statistics_data_model_v2.dart';
import '../../api/twitter_handles_statewise/twitter_handles_statewise.dart';
// import '../../api/rapid_api_astsiatsko/world_total_statistics_data_model.dart';
// import '../../api/rapid_api_astsiatsko/cases_by_country_data_model.dart';
import '../../api/covid_19_india/all_data_model/state_districts_data_model.dart';
import '../../api/covid_19_india/all_data_model/data_model.dart';
import 'package:mobx/mobx.dart';
import 'package:dio/dio.dart';

part 'api_data.g.dart';

class ApiDataStore extends _ApiDataStoreBase with _$ApiDataStore {
  static ApiDataStore _instance = ApiDataStore._();

  factory ApiDataStore() => _instance;

  ApiDataStore._();
}

abstract class _ApiDataStoreBase with Store {
  // Setup _dio
  var _dio = Dio();

// latest App versions
  @observable
  AppVersionsData appVersionsData;

  @observable
  bool isVersionMatched = true;

  Future<AppVersionsData> _fetchAppVersionsData() async {
    final _dataURL =
        "https://devsmranjan.github.io/covid-19-tracker-api/app_versions.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return AppVersionsData.fromJson(response.data);
    } else {
      throw Exception('Failed to load AppVersionsData');
    }
  }

  @action
  Future fetchAppVersionsData() async {
    try {
      appVersionsData = await _fetchAppVersionsData();
      print(appVersionsData.latestAppVersion);
    } catch (e) {
      print("Error in fetchAppVersionsData : " + e.toString());
    }
  }

  @action
  void compareVersion(String version) {
    isVersionMatched = true;
    if (appVersionsData.latestAppVersion != version) {
      isVersionMatched = false;
    }
  }

  // factoids
  @observable
  List<Factoid> factoidsList = [];

  @observable
  Factoid factoroid;

  Future<FactoidsData> _fetchFactoidsData() async {
    final _dataURL =
        "https://devsmranjan.github.io/covid-19-tracker-api/factoids.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return FactoidsData.fromJson(response.data);
    } else {
      throw Exception('Failed to load factoids data');
    }
  }

  @action
  Future fetchFactoidsData() async {
    try {
      var factoidsData = await _fetchFactoidsData();
      factoidsList = factoidsData.factoidsList;
    } catch (e) {
      print("Error in fetchFactoidsData : " + e.toString());
    }
  }

  @action
  void getRandomFactoroid() {
    final _random = Random();
    factoroid = factoidsList[_random.nextInt(factoidsList.length)];
  }

  // Get resources
  @observable
  List<Resource> allResourcesList;

  @observable
  List<Resource> myStateResourcesList;

  @observable
  Map<String, dynamic> stateAndCityResourcesMap = {};

  Future<API1ResourcesData> _fetchAPI1ResourcesData() async {
    final _dataURL = "https://api.covid19india.org/resources/resources.json";
    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return API1ResourcesData.fromJson(response.data);
    } else {
      throw Exception('Failed to load state _fetchAPI1ResourcesData data.');
    }
  }

  @action
  Future fetchAPI1ResourcesData() async {
    try {
      var api1ResourcesData = await _fetchAPI1ResourcesData();
      allResourcesList = api1ResourcesData.allResources;

      allResourcesList.forEach((resource) {
        stateAndCityResourcesMap.putIfAbsent(
            resource.state,
            () => {
                  "cities": ["All cities"],
                  "categories": ["All categories"]
                });
        if (!stateAndCityResourcesMap[resource.state]["cities"]
            .contains(resource.city)) {
          stateAndCityResourcesMap[resource.state]["cities"].add(resource.city);
        }
        if (!stateAndCityResourcesMap[resource.state]["categories"]
            .contains(resource.category)) {
          stateAndCityResourcesMap[resource.state]["categories"]
              .add(resource.category);
        }
      });
      // print(stateAndCityResourcesMap);
    } catch (e) {
      print("Error in fetchAPI1ResourcesData : " + e.toString());
    }
  }

  @action
  void getMyStateResourcesData({String stateName}) {
    myStateResourcesList = [];
    allResourcesList.forEach((resourceData) {
      if (resourceData.state.toLowerCase() == stateName.toLowerCase()) {
        myStateResourcesList.add(resourceData);
      }
    });
  }

  // state data
  @observable
  List<StateData> allStatesData;

  @observable
  List<CasesTimeSeries> allCaseTimeSeriesData;

  @observable
  Map<String, List<String>> mapOfIndivisualListOfCaseTimeSeries = {
    'dates': [],
    'totalConfirmed': [],
    'totalRecovered': [],
    'totalDeceased': []
  };

  @observable
  StateData myCountryData;

  @observable
  StateData myStateData;

  @observable
  StateData otherStateData;

  @observable
  List<AllDistrictsData> allStatesDistrictsData = [];

  @observable
  AllDistrictsData listOfMyStateDistrictsData;

  @observable
  AllDistrictsData listOfOtherStateDistrictsData;

  @observable
  DistrictData myDistrictData;

  @observable
  bool isMyDistrictDataAvailable = true;

  Future<API1Data> _fetchAPI1Data() async {
    final _dataURL = "https://api.covid19india.org/data.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return API1Data.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @action
  Future fetchAPI1Data() async {
    try {
      var api1Data = await _fetchAPI1Data();
      allStatesData = api1Data.stateData;
      myCountryData = api1Data.stateData[0];
      allStatesData.sort(((a, b) =>
          int.tryParse(b.confirmed).compareTo(int.tryParse(a.confirmed))));

      allCaseTimeSeriesData = api1Data.casesTimeSeriesData;
    } catch (e) {
      print("Error in fetchAPI1Data : " + e.toString());
    }
  }

  @action
  void getStateData({String stateName = "", String stateCode = ""}) {
    allStatesData.forEach((stateData) {
      if (stateName != "") {
        if (stateData.state.toLowerCase() == stateName.toLowerCase()) {
          myStateData = stateData;
        }
      } else if (stateCode != "") {
        if (stateData.stateCode.toLowerCase() == stateCode.toLowerCase()) {
          otherStateData = stateData;
        }
      }
    });
  }

  @action
  void getMapOfIndivisualListOfCaseTimeSeries() {
    mapOfIndivisualListOfCaseTimeSeries['dates'].clear();
    mapOfIndivisualListOfCaseTimeSeries['totalConfirmed'].clear();
    mapOfIndivisualListOfCaseTimeSeries['totalRecovered'].clear();
    mapOfIndivisualListOfCaseTimeSeries['totalDeceased'].clear();

    allCaseTimeSeriesData.forEach((ctsd) {
      mapOfIndivisualListOfCaseTimeSeries['dates'].add(ctsd.date);
      mapOfIndivisualListOfCaseTimeSeries['totalConfirmed']
          .add(ctsd.totalConfirmed);
      mapOfIndivisualListOfCaseTimeSeries['totalRecovered']
          .add(ctsd.totalRecovered);
      mapOfIndivisualListOfCaseTimeSeries['totalDeceased']
          .add(ctsd.totalDeceased);
    });
  }

  // fetch api 1 state districts data
  Future<API1StateDistrictsData> _fetchAPI1StateDistrictsData() async {
    final _dataURL = "https://api.covid19india.org/v2/state_district_wise.json";
    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return API1StateDistrictsData.fromJson(response.data);
    } else {
      throw Exception('Failed to load state districts data.');
    }
  }

  @action
  Future fetchAPI1StateDistrictsData() async {
    try {
      var api1StatesDistrictsData = await _fetchAPI1StateDistrictsData();
      allStatesDistrictsData = api1StatesDistrictsData.allStatesDistrictsData;
    } catch (e) {
      print("Error in fetchAPI1StateDistrictsData : " + e.toString());
    }
  }

  @action
  void getListOfMyStateDistrictsData({String stateName}) {
    allStatesDistrictsData.forEach((stateDistrictsData) {
      if (stateDistrictsData.state.toLowerCase() == stateName.toLowerCase()) {
        listOfMyStateDistrictsData = stateDistrictsData;

        listOfMyStateDistrictsData.districtData
            .sort((a, b) => b.confirmed.compareTo(a.confirmed));
      }
    });
  }

  @action
  void getListOfOtherStateDistrictsData({String stateName}) {
    allStatesDistrictsData.forEach((stateDistrictsData) {
      if (stateDistrictsData.state.toLowerCase() == stateName.toLowerCase()) {
        listOfOtherStateDistrictsData = stateDistrictsData;
        // print(listOfOtherStateDistrictsData.);

        listOfOtherStateDistrictsData.districtData
            .sort((a, b) => b.confirmed.compareTo(a.confirmed));
      }
    });
  }

  @action
  void getMyDistrictData({String stateName, String districtName}) {
    List<DistrictData> _myStateDistrictsData = [];

    allStatesDistrictsData.forEach((stateDistrictsData) {
      if (stateDistrictsData.state.toLowerCase() == stateName.toLowerCase()) {
        _myStateDistrictsData = stateDistrictsData.districtData;
      }
    });

    // _myStateDistrictsData.sort((a, b) => b.confirmed.compareTo(a.confirmed));

    _myStateDistrictsData.forEach((districtData) {
      if (districtData.district.toLowerCase() == districtName.toLowerCase()) {
        myDistrictData = districtData;
      } else {
        isMyDistrictDataAvailable = false;
      }
    });
  }

  // Zones
  List<Zone> _allZonesList;

  @observable
  List<String> zonesStateList;

  @observable
  List<Zone> myStateZonesList;

  @observable
  Zone myDistrictZone;

  @observable
  List<Zone> otherStateZonesList;

  Future<API1ZonesData> _fetchAPI1ZonesData() async {
    final _dataURL = "https://api.covid19india.org/zones.json";
    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return API1ZonesData.fromJson(response.data);
    } else {
      throw Exception('Failed to load state _fetchAPI1ZonesData data.');
    }
  }

  @action
  Future fetchAPI1ZonesData() async {
    try {
      var api1ZonesData = await _fetchAPI1ZonesData();
      _allZonesList = api1ZonesData.allZones;

      zonesStateList = [];

      for (var zoneData in _allZonesList) {
        if (!zonesStateList.contains(zoneData.state)) {
          zonesStateList.add(zoneData.state);
        }
      }

      // print(zonesStateList);
    } catch (e) {
      print("Error in fetchAPI1ZonesData : " + e.toString());
    }
  }

  @action
  void getMyAreaZoneData({String stateName, String distName}) {
    myStateZonesList = [];
    _allZonesList.forEach((zoneData) {
      if (zoneData.state.toLowerCase() == stateName.toLowerCase()) {
        myStateZonesList.add(zoneData);

        if (zoneData.district.toLowerCase() == distName.toLowerCase()) {
          myDistrictZone = zoneData;
        }
      }
    });
  }

  @action
  void getOtherStateZoneData({String stateName}) {
    otherStateZonesList = [];
    _allZonesList.forEach((zoneData) {
      if (zoneData.state.toLowerCase() == stateName.toLowerCase()) {
        // otherStateZonesStateList.add(zoneData.district)
        otherStateZonesList.add(zoneData);
      }
    });
  }

  // api1 - states daily data
  // It dont have any model
  List<dynamic> _statesDailyData;

  @observable
  List<String> stateDailyDataDates = [];

  List<dynamic> _statesDailyDataConfirmedMapList = [];

  List<dynamic> _statesDailyDataRecoveredMapList = [];

  List<dynamic> _statesDailyDataDeceasedMapList = [];

  @observable
  List<String> myStateDailyDataTotalConfirmed = [];

  @observable
  List<String> myStateDailyDataTotalRecovered = [];

  @observable
  List<String> myStateDailyDataTotalDeceased = [];

  @observable
  List<String> stateDailyDataTotalConfirmed = [];

  @observable
  List<String> stateDailyDataTotalRecovered = [];

  @observable
  List<String> stateDailyDataTotalDeceased = [];

  @action
  Future fetchStatesDaily() async {
    Response response =
        await _dio.get("https://api.covid19india.org/states_daily.json");

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await response.data;
      _statesDailyData = [];
      _statesDailyData = data['states_daily'];

      _statesDailyDataConfirmedMapList.clear();
      _statesDailyDataRecoveredMapList.clear();
      _statesDailyDataDeceasedMapList.clear();

      _statesDailyData.forEach((dailyData) {
        if (!stateDailyDataDates.contains(dailyData['date'])) {
          stateDailyDataDates.add(dailyData['date']);
        }

        if (dailyData['status'].toLowerCase() == "confirmed") {
          _statesDailyDataConfirmedMapList.add(dailyData);
        }
        if (dailyData['status'].toLowerCase() == "recovered") {
          _statesDailyDataRecoveredMapList.add(dailyData);
        }
        if (dailyData['status'].toLowerCase() == "deceased") {
          _statesDailyDataDeceasedMapList.add(dailyData);
        }
      });
    } else {
      throw Exception('Failed to load fetchStatesDaily data');
    }
  }

  @action
  void getMyStateDaily({String stateCode}) {
    myStateDailyDataTotalConfirmed.clear();
    myStateDailyDataTotalRecovered.clear();
    myStateDailyDataTotalDeceased.clear();

    stateCode = stateCode.toLowerCase();

    _statesDailyDataConfirmedMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        var totalTillNow = myStateDailyDataTotalConfirmed.length <= 0
            ? dailyData[stateCode]
            : (int.parse(myStateDailyDataTotalConfirmed[
                        myStateDailyDataTotalConfirmed.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        myStateDailyDataTotalConfirmed.add(totalTillNow);
      }
    });

    _statesDailyDataRecoveredMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        var totalTillNow = myStateDailyDataTotalRecovered.length <= 0
            ? dailyData[stateCode]
            : (int.parse(myStateDailyDataTotalRecovered[
                        myStateDailyDataTotalRecovered.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        myStateDailyDataTotalRecovered.add(totalTillNow);
      }
    });

    _statesDailyDataDeceasedMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        var totalTillNow = myStateDailyDataTotalDeceased.length <= 0
            ? dailyData[stateCode]
            : (int.parse(myStateDailyDataTotalDeceased[
                        myStateDailyDataTotalDeceased.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        myStateDailyDataTotalDeceased.add(totalTillNow);
      }
    });
  }

  @action
  void getOtherStateDaily({String stateCode}) {
    stateDailyDataTotalConfirmed.clear();
    stateDailyDataTotalRecovered.clear();
    stateDailyDataTotalDeceased.clear();

    stateCode = stateCode.toLowerCase();
    _statesDailyDataConfirmedMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        dailyData[stateCode] =
            dailyData[stateCode] == "" ? "0" : dailyData[stateCode];
        var totalTillNow = stateDailyDataTotalConfirmed.length <= 0
            ? dailyData[stateCode]
            : (int.parse(stateDailyDataTotalConfirmed[
                        stateDailyDataTotalConfirmed.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        stateDailyDataTotalConfirmed.add(totalTillNow);
      }
    });

    _statesDailyDataRecoveredMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        var totalTillNow = stateDailyDataTotalRecovered.length <= 0
            ? dailyData[stateCode]
            : (int.parse(stateDailyDataTotalRecovered[
                        stateDailyDataTotalRecovered.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        stateDailyDataTotalRecovered.add(totalTillNow);
      }
    });

    _statesDailyDataDeceasedMapList.forEach((dailyData) {
      if (dailyData[stateCode] != null) {
        var totalTillNow = stateDailyDataTotalDeceased.length <= 0
            ? dailyData[stateCode]
            : (int.parse(stateDailyDataTotalDeceased[
                        stateDailyDataTotalDeceased.length - 1]) +
                    int.parse(dailyData[stateCode]))
                .toString();
        stateDailyDataTotalDeceased.add(totalTillNow);
      }
    });
  }

  // district daily
  @observable
  Map<String, dynamic> districtsDaily;

  // @observable
  // List<dynamic> districtDaily;

  @observable
  List<String> districtDailyDates = [];

  @observable
  List<int> districtDailyConfirmed = [];

  @observable
  List<int> districtDailyRecovered = [];

  @observable
  List<int> districtDailyDeceased = [];

  @action
  Future fetchDistrictDaily() async {
    Response response = await _dio.get(
      "https://api.covid19india.org/districts_daily.json",
    );

    if (response.statusCode == 200) {
      districtsDaily = response.data['districtsDaily'];
    }
  }

  @action
  void getDistrictDaily({String stateName, String districtName}) {
    // print(districtsDaily);
    // districtDaily = [];
    districtDailyDates.clear();
    districtDailyConfirmed.clear();
    districtDailyRecovered.clear();
    districtDailyDeceased.clear();

    if (districtsDaily.containsKey(stateName) &&
        districtsDaily[stateName].containsKey(districtName)) {
      // districtDaily.addAll(_districtsDaily[stateName][districtName]);
      List _districtDailyList = districtsDaily[stateName][districtName];

      // print(_districtDailyList);

      _districtDailyList.forEach((districtDailyData) {
        if (!districtDailyDates.contains(districtDailyData['date'])) {
          districtDailyDates.add(districtDailyData['date']);
        }
      });

      // print(districtDailyDates);

      _districtDailyList.forEach((districtDailyData) {
        districtDailyConfirmed.add(districtDailyData['confirmed']);
      });

      // print(districtDailyConfirmed);

      _districtDailyList.forEach((districtDailyData) {
        districtDailyRecovered.add(districtDailyData['recovered']);
      });

      _districtDailyList.forEach((districtDailyData) {
        districtDailyDeceased.add(districtDailyData['deceased']);
      });
    }
  }

  // api 2 - world data
  @observable
  WorldStatisticsDataModelV2 worldStatisticsData;

  Future<API2WorldTotalStatistics> _fetchAPI2WorldTotalStatistics() async {
    Response response = await _dio.get(
      "https://corona.lmao.ninja/v2/all",
    );

    if (response.statusCode == 200) {
      return API2WorldTotalStatistics.fromJson(response.data);
    } else {
      _fetchAPI2WorldTotalStatistics();
      throw Exception('Failed to load data');
    }
  }

  @action
  Future fetchAPI2WorldTotalStatistics() async {
    try {
      final _worldStatisticsDataModelV2 = WorldStatisticsDataModelV2();
      var api2WorldTotalStatistics = await _fetchAPI2WorldTotalStatistics();

      _worldStatisticsDataModelV2.confirmed = api2WorldTotalStatistics.confirmed
          .toString()
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.recovered = api2WorldTotalStatistics.recovered
          .toString()
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.deaths = api2WorldTotalStatistics.deaths
          .toString()
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.active =
          (int.parse(_worldStatisticsDataModelV2.confirmed) -
                  int.parse(_worldStatisticsDataModelV2.recovered) -
                  int.parse(_worldStatisticsDataModelV2.deaths))
              .toString();

      _worldStatisticsDataModelV2.deltaConfirmed = api2WorldTotalStatistics
          .deltaConfirmed
          .toString()
          .replaceAllMapped(RegExp(r","), (match) => "");
      _worldStatisticsDataModelV2.deltaDeathes = api2WorldTotalStatistics
          .deltaDeathes
          .toString()
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.lastUpdatedTime =
          api2WorldTotalStatistics.lastUpdatedTime.toString();

      worldStatisticsData = _worldStatisticsDataModelV2;
      print(worldStatisticsData);
    } catch (e) {
      print("Error in fetchAPI2WorldTotalStatistics : " + e.toString());
    }
  }

  @observable
  List<CountryData> listOfCountriesData = [];

  Future<API2CasesByCountriesData> _fetchAPI2CasesByCountriesData() async {
    Response response = await _dio.get(
      "https://corona.lmao.ninja/v2/countries",
    );

    if (response.statusCode == 200) {
      return API2CasesByCountriesData.fromJson(response.data);
    } else {
      throw Exception('Failed to load _fetchAPI2CasesByCountriesData data');
    }
  }

  @action
  Future fetchAPI2CasesByCountriesData() async {
    try {
      var api2CasesByCountriesData = await _fetchAPI2CasesByCountriesData();
      listOfCountriesData = api2CasesByCountriesData.countryData;
      listOfCountriesData.sort((a, b) => b.confirmed.compareTo(a.confirmed));
    } catch (e) {
      print("Error in fetchAPI2CasesByCountriesData : " + e.toString());
    }
  }

  // api 2 - get worlds historicalData
  @observable
  Map<String, dynamic> worldDailyData;

  Map<String, dynamic> _worldDailyDataConfirmedMap;
  Map<String, dynamic> _worldDailyDataRecoveredMap;
  Map<String, dynamic> _worldDailyDataDeathsMap;

  @observable
  List<String> worldDailyDataDates = [];

  @observable
  List<dynamic> worldDailyDataTotalConfirmed = [];

  @observable
  List<dynamic> worldDailyDataTotalRecovered = [];

  @observable
  List<dynamic> worldDailyDataTotalDeceased = [];

  @action
  Future fetchWorldDaily() async {
    Response response = await _dio.get(
      "https://corona.lmao.ninja/v2/historical/all",
    );

    if (response.statusCode == 200) {
      worldDailyData = await response.data;
      _worldDailyDataConfirmedMap = worldDailyData['cases'];
      _worldDailyDataRecoveredMap = worldDailyData['recovered'];
      _worldDailyDataDeathsMap = worldDailyData['deaths'];

      worldDailyDataDates.clear();
      worldDailyDataTotalConfirmed.clear();
      worldDailyDataTotalRecovered.clear();
      worldDailyDataTotalDeceased.clear();

      worldDailyDataDates.addAll(_worldDailyDataConfirmedMap.keys);
      worldDailyDataTotalConfirmed.addAll(_worldDailyDataConfirmedMap.values);
      worldDailyDataTotalRecovered.addAll(_worldDailyDataRecoveredMap.values);
      worldDailyDataTotalDeceased.addAll(_worldDailyDataDeathsMap.values);
    } else {
      throw Exception('Failed to fetchWorldDaily data');
    }
  }

  // api 2 - get country historicalData
  @observable
  Map<String, dynamic> countryDailyData;

  Map<String, dynamic> _countryDailyDataConfirmedMap;
  Map<String, dynamic> _countryDailyDataRecoveredMap;
  Map<String, dynamic> _countryDailyDataDeathsMap;

  @observable
  List<String> countryDailyDataDates = [];

  @observable
  List<dynamic> countryDailyDataTotalConfirmed = [];

  @observable
  List<dynamic> countryDailyDataTotalRecovered = [];

  @observable
  List<dynamic> countryDailyDataTotalDeceased = [];

  @action
  Future fetchCountryDaily({String countryName}) async {
    countryDailyDataDates.clear();
    countryDailyDataTotalConfirmed.clear();
    countryDailyDataTotalRecovered.clear();
    countryDailyDataTotalDeceased.clear();

    Response response = await _dio.get(
      "https://corona.lmao.ninja/v2/historical/${countryName}",
    );

    if (response.statusCode == 200) {
      countryDailyData = await response.data['timeline'];
      _countryDailyDataConfirmedMap = countryDailyData['cases'];
      _countryDailyDataRecoveredMap = countryDailyData['recovered'];
      _countryDailyDataDeathsMap = countryDailyData['deaths'];

      countryDailyDataDates.addAll(_countryDailyDataConfirmedMap.keys);
      countryDailyDataTotalConfirmed
          .addAll(_countryDailyDataConfirmedMap.values);
      countryDailyDataTotalRecovered
          .addAll(_countryDailyDataRecoveredMap.values);
      countryDailyDataTotalDeceased.addAll(_countryDailyDataDeathsMap.values);
      print(_countryDailyDataDeathsMap.values);
    } else {
      throw Exception('Failed to fetchCountryDaily data');
    }
  }

  // twitter handels
  @observable
  List<TwitterHandleOfState> twitterHandleOfStatesList = [];

  @observable
  TwitterHandleOfState twitterHandleOfMyState;

  Future<TwitterHandlesStatewise> _fetchTwitterHandlesStatewise() async {
    final _dataURL =
        "https://devsmranjan.github.io/covid-19-tracker-api/twitter_handles_statewise.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return TwitterHandlesStatewise.fromJson(response.data);
    } else {
      throw Exception('Failed to load fetchTwitterHandlesStatewise data');
    }
  }

  @action
  Future fetchTwitterHandlesStatewise() async {
    try {
      var twitterHandlesStatewise = await _fetchTwitterHandlesStatewise();
      twitterHandleOfStatesList = twitterHandlesStatewise.twitterHandelOfState;
    } catch (e) {
      print("Error in fetchTwitterHandlesStatewise : " + e.toString());
    }
  }

  @action
  void getTwitterHandleOfMyState(String stateName) {
    twitterHandleOfStatesList.forEach((twitterHandleData) {
      if (twitterHandleData.state.toLowerCase() == stateName.toLowerCase()) {
        twitterHandleOfMyState = twitterHandleData;
      }
    });
  }

  // Helplines
  @observable
  List<HelplinesOfState> helplinesOfStatesList;

  Future<HelplinesStatewiseData> _fetchtHelplinesStatewiseData() async {
    final _dataURL =
        "https://devsmranjan.github.io/covid-19-tracker-api/help_lines.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return HelplinesStatewiseData.fromJson(response.data);
    } else {
      throw Exception('Failed to load _fetchtHelplinesStatewiseData data');
    }
  }

  @action
  Future fetchtHelplinesStatewiseData() async {
    try {
      var helplinesStatewiseData = await _fetchtHelplinesStatewiseData();
      helplinesOfStatesList = helplinesStatewiseData.helplinesOfStatesList;
    } catch (e) {
      print("Error in fetchtHelplinesStatewiseData : " + e.toString());
    }
  }

  // Donation
  @observable
  List<OrganisationProfile> organisationProfileList;

  @observable
  List<OrganisationProfile> myStateOrganisationsList = [];

  Future<DonationData> _fetchtDonationData() async {
    final _dataURL =
        "https://devsmranjan.github.io/covid-19-tracker-api/donation.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return DonationData.fromJson(response.data);
    } else {
      throw Exception('Failed to load _fetchtDonationData data');
    }
  }

  @action
  Future fetchtDonationData() async {
    try {
      var donationData = await _fetchtDonationData();
      organisationProfileList = donationData.organisationProfileList;
    } catch (e) {
      print("Error in fetchtDonationData : " + e.toString());
    }
  }

  @action
  void getMyStatesOrganisationLists(String stateName) {
    myStateOrganisationsList.clear();
    organisationProfileList.forEach((organisationProfile) {
      if (organisationProfile.state == stateName) {
        myStateOrganisationsList.add(organisationProfile);
      }
    });
  }
}
