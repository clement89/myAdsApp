class SignUpResponse {
  String username;
  String useremail;
  int userid;
  int otp;
  String status;
  String formNo;
  String error;

  SignUpResponse(
      {this.username,
        this.useremail,
        this.userid,
        this.otp,
        this.status,
        this.formNo,
        this.error});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    useremail = json['useremail'];
    userid = json['userid'];
    otp = json['otp'];
    status = json['status'];
    formNo = json['formNo'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['useremail'] = this.useremail;
    data['userid'] = this.userid;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['formNo'] = this.formNo;
    data['error'] = this.error;
    return data;
  }
}
