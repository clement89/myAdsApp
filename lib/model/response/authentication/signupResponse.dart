class SignUpResponse {
  String username;
  String useremail;
  int userid;
  String error;

  SignUpResponse({this.username, this.useremail, this.userid, this.error});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    useremail = json['useremail'];
    userid = json['userid'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userid'] = this.userid;
    data['error'] = this.error;
    return data;
  }
}
