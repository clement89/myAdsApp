class UpdatePasswordResponse {
  String error;
  String success;

  UpdatePasswordResponse({this.error, this.success});

  UpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['success'] = this.success;
    return data;
  }
}
