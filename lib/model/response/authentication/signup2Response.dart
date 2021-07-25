// class SignUp2Response {
//   String firstName;
//   String lastName;
//   String ageGroup;
//   String incomeGroup;
//   String mobile;
//   String email;
//   String postalCode;
//   String country;
//   String gender;
//   String userIn, streamIn; //List<dynamic> cjc
//   String playback;
// //Found??
//   SignUp2Response(
//       this.firstName,
//       this.lastName,
//       this.ageGroup,
//       this.incomeGroup,
//       this.mobile,
//       this.email,
//       this.postalCode,
//       this.country,
//       this.gender,
//       this.userIn,
//       this.streamIn,
//       this.playback);
//
//   SignUp2Response.fromJson(Map<String, dynamic> json) {
//     print("GOT USer");
//
//     // Map<String, dynamic> json = jsonList.first; //cjc changed
//     // print(json);
//     firstName = json['name'];
//     lastName = json['last_name'];
//     ageGroup = json['age_group'];
//     incomeGroup = json['income_group'];
//     mobile = json['mobile'];
//     postalCode = json['postal_code'];
//     country = json['country'];
//     gender = json['gender'];
//     playback = json['playback_option'];
//     print('playback - $playback');
//     userIn = json['user_intresets'];
//     print('userIn - $userIn');
//     streamIn = json['streaming_lst'];
//     print('streamIn - $streamIn');
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> json = new Map<String, dynamic>();
//     json['name'] = this.firstName;
//     json['last_name'] = this.lastName;
//     json['age_group'] = this.ageGroup;
//     json['income_group'] = this.incomeGroup;
//     json['mobile'] = this.mobile;
//     json['email'] = this.email;
//     json['postal_code'] = this.postalCode;
//     json['country'] = this.country;
//     json['gender'] = this.gender;
//     json['playback_option'] = this.playback;
//     json['user_intresets'] = this.userIn;
//     json['streaming_lst'] = this.streamIn;
//     return json;
//   }
// }
//
//

class SignUp2Response {
  String id;
  String name;
  String lastName;
  String email;
  String mobile;
  String gender;
  String address1;
  String city;
  String postalCode;
  String password;
  String state;
  String country;
  String cardholderId;
  String cardId;
  String createdAt;
  String updatedAt;
  String status;
  String intresetLst;
  String streamingLst;
  String incomeGroip;
  String ageGroup;
  String playbackOption;
  String totalWatchedTime;
  String totalReward;
  String balanceTime;
  String balanceReward;
  String emailActivationStatus;
  String emailActivationCode;
  String emailActivatedAt;

  SignUp2Response(
      {this.id,
        this.name,
        this.lastName,
        this.email,
        this.mobile,
        this.gender,
        this.address1,
        this.city,
        this.postalCode,
        this.password,
        this.state,
        this.country,
        this.cardholderId,
        this.cardId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.intresetLst,
        this.streamingLst,
        this.incomeGroip,
        this.ageGroup,
        this.playbackOption,
        this.totalWatchedTime,
        this.totalReward,
        this.balanceTime,
        this.balanceReward,
        this.emailActivationStatus,
        this.emailActivationCode,
        this.emailActivatedAt});

  SignUp2Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    address1 = json['address1'];
    city = json['city'];
    postalCode = json['postal_code'];
    password = json['password'];
    state = json['state'];
    country = json['country'];
    cardholderId = json['cardholder_id'];
    cardId = json['card_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    intresetLst = json['intreset_lst'];
    streamingLst = json['streaming_lst'];
    incomeGroip = json['income_groip'];
    ageGroup = json['age_group'];
    playbackOption = json['playback_option'];
    totalWatchedTime = json['total_watched_time'];
    totalReward = json['total_reward'];
    balanceTime = json['balance_time'];
    balanceReward = json['balance_reward'];
    emailActivationStatus = json['email_activation_status'];
    emailActivationCode = json['email_activation_code'];
    emailActivatedAt = json['email_activated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['address1'] = this.address1;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['password'] = this.password;
    data['state'] = this.state;
    data['country'] = this.country;
    data['cardholder_id'] = this.cardholderId;
    data['card_id'] = this.cardId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['intreset_lst'] = this.intresetLst;
    data['streaming_lst'] = this.streamingLst;
    data['income_groip'] = this.incomeGroip;
    data['age_group'] = this.ageGroup;
    data['playback_option'] = this.playbackOption;
    data['total_watched_time'] = this.totalWatchedTime;
    data['total_reward'] = this.totalReward;
    data['balance_time'] = this.balanceTime;
    data['balance_reward'] = this.balanceReward;
    data['email_activation_status'] = this.emailActivationStatus;
    data['email_activation_code'] = this.emailActivationCode;
    data['email_activated_at'] = this.emailActivatedAt;
    return data;
  }
}
