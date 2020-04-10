class TwitterHandlesStatewise {
  List<TwitterHandleOfState> twitterHandelOfState;

  TwitterHandlesStatewise.fromJson(List<dynamic> json) {
    twitterHandelOfState =
        json.map((i) => TwitterHandleOfState.fromJson(i)).toList();
  }
}

class TwitterHandleOfState {
  String state;
  String stateCode;
  String twitterId;
  String twitterProfileName;

  TwitterHandleOfState(
      {this.state, this.stateCode, this.twitterId, this.twitterProfileName});

  TwitterHandleOfState.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    stateCode = json['state_code'];
    twitterId = json['twitter_id'];
    twitterProfileName = json['twitter_profile_name'];
  }
}
