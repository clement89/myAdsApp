class SignUpResponse {
  String username;
  String useremail;
  int userid;
  int otp;
  String error;

  SignUpResponse({this.username, this.useremail, this.userid, this.otp,this.error});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    useremail = json['useremail'];
    userid = json['userid'];
    otp = json['otp'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userid'] = this.userid;
    data['error'] = this.error;
    data['otp'] = this.otp;
    return data;
  }
}
