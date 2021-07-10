class SignUp2Response {
  String firstName;
  String lastName;
  String ageGroup;
  String incomeGroup;
  String mobile;
  String email;
  String postalCode;
  String country;
  String gender;
  String userIn, streamIn; //List<dynamic> cjc
  String playback;
//Found??
  SignUp2Response(
      this.firstName,
      this.lastName,
      this.ageGroup,
      this.incomeGroup,
      this.mobile,
      this.email,
      this.postalCode,
      this.country,
      this.gender,
      this.userIn,
      this.streamIn,
      this.playback);

  SignUp2Response.fromJson(List<dynamic> jsonList) {
    print("GOT USer");

    Map<String, dynamic> json = jsonList.first; //cjc changed
    // print(json);
    firstName = json['name'];
    lastName = json['last_name'];
    ageGroup = json['age_group'];
    incomeGroup = json['income_group'];
    mobile = json['mobile'];
    postalCode = json['postal_code'];
    country = json['country'];
    gender = json['gender'];
    playback = json['playback_option'];
    print('playback - $playback');
    userIn = json['user_intresets'];
    print('userIn - $userIn');
    streamIn = json['streaming_lst'];
    print('streamIn - $streamIn');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['name'] = this.firstName;
    json['last_name'] = this.lastName;
    json['age_group'] = this.ageGroup;
    json['income_group'] = this.incomeGroup;
    json['mobile'] = this.mobile;
    json['email'] = this.email;
    json['postal_code'] = this.postalCode;
    json['country'] = this.country;
    json['gender'] = this.gender;
    json['playback_option'] = this.playback;
    json['user_intresets'] = this.userIn;
    json['streaming_lst'] = this.streamIn;
    return json;
  }
}
