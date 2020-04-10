class AppVersionsData {
  String latestAppVersion;
  String latestAppLink;

  AppVersionsData.fromJson(Map<String, dynamic> json) {
    latestAppVersion = json['latest_app_version'];
    latestAppLink = json['latest_app_link'];
  }
}
