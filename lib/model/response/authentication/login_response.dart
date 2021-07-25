class SignInResponse {
  String username;
  String useremail;
  String userid;
  String error;
  String found;

  SignInResponse(
      {this.username, this.useremail, this.userid, this.error, this.found});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    useremail = json['useremail'];
    userid = json['userid'];
    error = json['error'];
    found = json['found'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userid'] = this.userid;
    data['error'] = this.error;
    data['found'] = this.found;
    return data;
  }
}
