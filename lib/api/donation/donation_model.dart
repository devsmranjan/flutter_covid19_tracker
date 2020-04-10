class DonationData {
  List<OrganisationProfile> organisationProfileList;

  DonationData.fromJson(List<dynamic> json) {
    organisationProfileList =
        json.map((i) => OrganisationProfile.fromJson(i)).toList();
  }
}

class OrganisationProfile {
  String organisation;
  String state;
  String accountName;
  String accountNumber;
  String ifscCode;
  String upi;
  String bank;

  OrganisationProfile(
      {this.organisation,
      this.state,
      this.accountName,
      this.accountNumber,
      this.ifscCode,
      this.upi,
      this.bank});

  OrganisationProfile.fromJson(Map<String, dynamic> json) {
    organisation = json['organisation'];
    state = json['state'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    ifscCode = json['IFSC_code'];
    upi = json['upi'];
    bank = json['bank'];
  }
}
