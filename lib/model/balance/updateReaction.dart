import 'package:charts_flutter/flutter.dart';

class UpdateReaction {
  String userId;
  String videoId;
  String reaction;

  UpdateReaction({this.userId, this.videoId, this.reaction});

  UpdateReaction.fromJson(Map<String, dynamic> json) {
    userId = json['u'];
    videoId = json['v'];
    reaction= json['r'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u'] = this.userId;
    data['v'] = this.videoId;
    data['r'] = this.reaction;
    return data;
  }
}
