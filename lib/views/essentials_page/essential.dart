class Essential {
  final String category;
  final String city;
  final String contact;
  final String descriptionAndOrServiceprovided;
  final String nameOfTheOrganisation;
  final List phoneNumber;
  final String state;
  bool isExpanded;

  Essential(
      {this.category,
      this.city,
      this.contact,
      this.descriptionAndOrServiceprovided,
      this.nameOfTheOrganisation,
      this.phoneNumber,
      this.state,
      this.isExpanded});

  set updateExpand(bool isExpandedValue) {
    this.isExpanded = isExpandedValue;
  }
}
