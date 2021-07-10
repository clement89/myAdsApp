class SurveyResponse {
  int id;

  SurveyResponse({this.id});

  SurveyResponse.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString()); //cjc fixed
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
