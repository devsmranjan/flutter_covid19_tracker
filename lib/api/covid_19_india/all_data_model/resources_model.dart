class API1ResourcesData {
  List<Resource> allResources;

  API1ResourcesData({this.allResources});

  API1ResourcesData.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      allResources = List<Resource>();

      json['resources'].forEach((v) {
        allResources.add(Resource.fromJson(v));
      });
    }
  }
}

class Resource {
  String category;
  String state;
  String city;
  String contact;
  String descriptionAndOrServiceprovided;
  String nameOfTheOrganisation;
  List phoneNumber;

  Resource(
      {this.category,
      this.state,
      this.city,
      this.contact,
      this.descriptionAndOrServiceprovided,
      this.nameOfTheOrganisation,
      this.phoneNumber});

  Resource.fromJson(Map<String, dynamic> json) {
    category = json["category"];
    state = json["state"];
    city = json["city"];
    contact = json["contact"];
    descriptionAndOrServiceprovided = json["descriptionandorserviceprovided"];
    nameOfTheOrganisation = json["nameoftheorganisation"];
    phoneNumber = json["phonenumber"].split(",");

    for (var i = 0; i < phoneNumber.length; i++) {
      phoneNumber[i] = phoneNumber[i].toString().trim();
    }
  }
}
