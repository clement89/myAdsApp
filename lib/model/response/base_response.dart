class BaseResponse {

  String message;
  String status;
  int statusCode;

  BaseResponse({this.statusCode, this.message, this.status});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
