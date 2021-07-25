class GetUserDetailsResponse {
  String name;
  String lastName;
  String email;
  String mobile;
  String postalCode;
  String country;
  List<String> userIntresets;
  List<String> streamingLst;
  String incomeGroup;
  String ageGroup;
  String playbackOption;
  String gender;

  GetUserDetailsResponse(
      {this.name,
        this.lastName,
        this.email,
        this.mobile,
        this.postalCode,
        this.country,
        this.userIntresets,
        this.streamingLst,
        this.incomeGroup,
        this.ageGroup,
        this.playbackOption,
        this.gender});

  GetUserDetailsResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    postalCode = json['postal_code'];
    country = json['country'];
    userIntresets = json['user_intresets'].cast<String>();
    streamingLst = json['streaming_lst'].cast<String>();
    incomeGroup = json['income_group'];
    ageGroup = json['age_group'];
    playbackOption = json['playback_option'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['user_intresets'] = this.userIntresets;
    data['streaming_lst'] = this.streamingLst;
    data['income_group'] = this.incomeGroup;
    data['age_group'] = this.ageGroup;
    data['playback_option'] = this.playbackOption;
    data['gender'] = this.gender;
    return data;
  }
}
