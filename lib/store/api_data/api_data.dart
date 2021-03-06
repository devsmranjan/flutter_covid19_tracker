import 'dart:convert';
import 'dart:math';
import '../../api/app_versions/app_versions_model.dart';
import '../../api/donation/donation_model.dart';
import '../../api/factoids/factoids_model.dart';
import '../../api/help_lines/help_lines.dart';
import '../../api/rapid_api_astsiatsko/world_statistics_data_model_v2.dart';
import '../../api/twitter_handles_statewise/twitter_handles_statewise.dart';
import '../../api/rapid_api_astsiatsko/world_total_statistics_data_model.dart';
import '../../api/rapid_api_astsiatsko/cases_by_country_data_model.dart';
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

  // state data
  @observable
  List<StateData> allStatesData = [];

  @observable
  List<CasesTimeSeries> allCaseTimeSeriesData = [];

  @observable
  Map<String, List<String>> mapOfIndivisualListOfCaseTimeSeries = {};

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

  Future<API1Data> _fetchAPI1Data() async {
    final _dataURL = "https://api.covid19india.org/data.json";

    final response = await _dio.get(_dataURL);
    if (response.statusCode == 200) {
      return API1Data.fromJson(response.data);
    } else {
      throw Exception('Failed to load data');
    }
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
  Future fetchAPI1Data() async {
    try {
      var api1Data = await _fetchAPI1Data();
      allStatesData = api1Data.stateData;
      myCountryData = api1Data.stateData[0];
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
    List<String> _dates = [];
    List<String> _totalConfirmed = [];
    List<String> _totalRecovered = [];
    List<String> _totalDeceased = [];

    allCaseTimeSeriesData.forEach((ctsd) {
      _dates.add(ctsd.date);
      _totalConfirmed.add(ctsd.totalConfirmed);
      _totalRecovered.add(ctsd.totalRecovered);
      _totalDeceased.add(ctsd.totalDeceased);
    });

    mapOfIndivisualListOfCaseTimeSeries = {
      "dates": _dates,
      "totalConfirmed": _totalConfirmed,
      "totalRecovered": _totalRecovered,
      "totalDeceased": _totalDeceased
    };

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
      }
    });
  }

  @action
  void getListOfOtherStateDistrictsData({String stateName}) {
    allStatesDistrictsData.forEach((stateDistrictsData) {
      if (stateDistrictsData.state.toLowerCase() == stateName.toLowerCase()) {
        listOfOtherStateDistrictsData = stateDistrictsData;
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

    _myStateDistrictsData.forEach((districtData) {
      if (districtData.district.toLowerCase() == districtName.toLowerCase()) {
        myDistrictData = districtData;
      }
    });
  }

  // api 2 - world data
  @observable
  WorldStatisticsDataModelV2 worldStatisticsData;

  @observable
  List<CountryData> listOfCountriesData = [];

  @observable
  String lastUpadetedTimeCasesByCountriesData;

  Future<API2WorldTotalStatistics> _fetchAPI2WorldTotalStatistics() async {
    Response response = await _dio.get(
        "https://coronavirus-monitor.p.rapidapi.com/coronavirus/worldstat.php",
        options: Options(headers: {
          'content-type': 'application/json',
          "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
          "x-rapidapi-key": "YOUR_API_KEY"
        }));

    if (response.statusCode == 200) {
      return API2WorldTotalStatistics.fromJson(json.decode(response.data));
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
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.recovered = api2WorldTotalStatistics.recovered
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.deaths = api2WorldTotalStatistics.deaths
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.active =
          (int.parse(_worldStatisticsDataModelV2.confirmed) -
                  int.parse(_worldStatisticsDataModelV2.recovered) -
                  int.parse(_worldStatisticsDataModelV2.deaths))
              .toString();

      _worldStatisticsDataModelV2.deltaConfirmed = api2WorldTotalStatistics
          .deltaConfirmed
          .replaceAllMapped(RegExp(r","), (match) => "");
      _worldStatisticsDataModelV2.deltaDeathes = api2WorldTotalStatistics
          .deltaDeathes
          .replaceAllMapped(RegExp(r","), (match) => "");

      _worldStatisticsDataModelV2.lastUpdatedTime =
          api2WorldTotalStatistics.lastUpdatedTime;

      worldStatisticsData = _worldStatisticsDataModelV2;
    } catch (e) {
      print("Error in fetchAPI2WorldTotalStatistics : " + e.toString());
    }
  }

  Future<API2CasesByCountriesData> _fetchAPI2CasesByCountriesData() async {
    Response response = await _dio.get(
        "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php",
        options: Options(headers: {
          'content-type': 'application/json',
          "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
          "x-rapidapi-key": "ec10cd426bmsh3f5a4374a5c4830p175217jsnf3faaf2e0cde"
        }));

    if (response.statusCode == 200) {
      return API2CasesByCountriesData.fromJson(json.decode(response.data));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @action
  Future fetchAPI2CasesByCountriesData() async {
    try {
      var api2CasesByCountriesData = await _fetchAPI2CasesByCountriesData();
      listOfCountriesData = api2CasesByCountriesData.countryData;

      lastUpadetedTimeCasesByCountriesData =
          api2CasesByCountriesData.lastUpdatedTime;
    } catch (e) {
      print("Error in fetchAPI2CasesByCountriesData : " + e.toString());
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
