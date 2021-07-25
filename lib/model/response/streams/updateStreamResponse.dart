class UpdateStreamResponse {
  List<String> streams;

  UpdateStreamResponse({this.streams});

  UpdateStreamResponse.fromJson(Map<String, dynamic> json) {
    streams = json['streams'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streams'] = this.streams;
    return data;
  }
}
