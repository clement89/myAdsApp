class GetStreamResponse {
  List<StreamList> streamList;
  List<double> targetList;

  GetStreamResponse({this.streamList});

  GetStreamResponse.fromJson(Map<String, dynamic> json) {
    if (json['stream_list'] != null) {
      streamList = [];
      targetList = [];
      json['stream_list'].forEach((v) {
        streamList.add(new StreamList.fromJson(v));
      });

      targetList.add(json['target']['1']);
      targetList.add(json['target']['2']);
      targetList.add(json['target']['3']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.streamList != null) {
      data['stream_list'] = this.streamList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StreamList {
  String value;
  bool ischecked;

  StreamList(this.value, this.ischecked);

  StreamList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    if ((json['ischecked']) == true) {
      ischecked = true;
    } else {
      ischecked = false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['ischecked'] = this.ischecked;
    return data;
  }
}
