class PerformanceResponse {
  String ron;
  String ronAud;
  List<DailyReport> dailyReport;
  String cardNo;
  String emailId;
  String cardStatus;
  String status;

  PerformanceResponse(
      {this.ron, this.ronAud, this.dailyReport, this.cardNo, this.emailId,this.cardStatus,this.status});

  PerformanceResponse.fromJson(Map<String, dynamic> json) {
    ron = json['ron'];
    ronAud = json['ron_aud'];
    if (json['daily_report'] != null) {
      dailyReport = new List<DailyReport>();
      json['daily_report'].forEach((v) {
        dailyReport.add(new DailyReport.fromJson(v));
      });
    }
    cardNo = json['card_no'];
    emailId = json['email_id'];
    cardStatus = json['card_status'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ron'] = this.ron;
    data['ron_aud'] = this.ronAud;
    if (this.dailyReport != null) {
      data['daily_report'] = this.dailyReport.map((v) => v.toJson()).toList();
    }
    data['card_no'] = this.cardNo;
    data['email_id'] = this.emailId;
    data['card_status'] = this.cardStatus;
    data['status'] = this.status;
    return data;
  }
}

class DailyReport {
  String date;
  String surveys;
  String badge;
  String watchSeconds;
  String ron;
  String ronAud;

  DailyReport(
      {this.date,
        this.surveys,
        this.badge,
        this.watchSeconds,
        this.ron,
        this.ronAud});

  DailyReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    surveys = json['surveys'];
    badge = json['badge'];
    watchSeconds = json['watch_seconds'];
    ron = json['ron'];
    ronAud = json['ron_aud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['surveys'] = this.surveys;
    data['badge'] = this.badge;
    data['watch_seconds'] = this.watchSeconds;
    data['ron'] = this.ron;
    data['ron_aud'] = this.ronAud;
    return data;
  }
}
