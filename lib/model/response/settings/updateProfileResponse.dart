class UpdateProfileResponse {
  String username;
  String useremail;
  String usermobile;
  String userid;

  UpdateProfileResponse(
      {this.username, this.useremail, this.usermobile, this.userid});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    useremail = json['useremail'];
    usermobile = json['usermobile'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['usermobile'] = this.usermobile;
    data['userid'] = this.userid;
    return data;
  }
}
