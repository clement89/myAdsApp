class UpdateInterestResponse {
  List<String> intrests;

  UpdateInterestResponse({this.intrests});

  UpdateInterestResponse.fromJson(Map<String, dynamic> json) {
    intrests = json['intrests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intrests'] = this.intrests;
    return data;
  }
}
