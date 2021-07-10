class UpdatePlayBackResponse {
  String playbackOption;

  UpdatePlayBackResponse({this.playbackOption});

  UpdatePlayBackResponse.fromJson(Map<String, dynamic> json) {
    playbackOption = json['playback_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playback_option'] = this.playbackOption;
    return data;
  }
}
