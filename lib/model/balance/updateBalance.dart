class UpdateBalanceTimeResponse {
  String time;
  String balance;

  UpdateBalanceTimeResponse({this.time, this.balance});

  UpdateBalanceTimeResponse.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['balance'] = this.balance;
    return data;
  }
}
