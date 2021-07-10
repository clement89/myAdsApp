class GraphModel {
  List<Views> views;

  GraphModel({this.views});

  GraphModel.fromJson(Map<String, dynamic> json) {
    if (json['views'] != null) {
      views = new List<Views>();
      json['views'].forEach((v) {
        views.add(new Views.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.views != null) {
      data['views'] = this.views.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Views {
  String date;
  String seconds;
  String minutesDot;
  String minutes;
  String bonusSeconds;
  String bonusMinutesDot;
  String bonusMinutes;
  String cumSeconds;
  String cumMinutesDot;
  String cumMinutes;

  Views(
      {this.date,
        this.seconds,
        this.minutesDot,
        this.minutes,
        this.bonusSeconds,
        this.bonusMinutesDot,
        this.bonusMinutes,
        this.cumSeconds,
        this.cumMinutesDot,
        this.cumMinutes});

  Views.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    seconds = json['seconds'];
    minutesDot = json['minutes_dot'];
    minutes = json['minutes'];
    bonusSeconds = json['bonus_seconds'];
    bonusMinutesDot = json['bonus_minutes_dot'];
    bonusMinutes = json['bonus_minutes'];
    cumSeconds = json['cum_seconds'];
    cumMinutesDot = json['cum_minutes_dot'];
    cumMinutes = json['cum_minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['seconds'] = this.seconds;
    data['minutes_dot'] = this.minutesDot;
    data['minutes'] = this.minutes;
    data['bonus_seconds'] = this.bonusSeconds;
    data['bonus_minutes_dot'] = this.bonusMinutesDot;
    data['bonus_minutes'] = this.bonusMinutes;
    data['cum_seconds'] = this.cumSeconds;
    data['cum_minutes_dot'] = this.cumMinutesDot;
    data['cum_minutes'] = this.cumMinutes;
    return data;
  }
}
