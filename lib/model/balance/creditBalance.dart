class CreditBalance {
  int insId;
  double balance;
  int giftStatus;
  String referenceID;
  String referenceOrderID;
  String amount;
  String balanceTime;
  String balanceReward;

  CreditBalance(
      {this.insId,
        this.balance,
        this.giftStatus,
        this.referenceID,
        this.referenceOrderID,
        this.amount,
        this.balanceTime,
        this.balanceReward});

  CreditBalance.fromJson(Map<String, dynamic> json) {
    insId = json['insId'];
    balance = json['balance'];
    giftStatus = json['giftStatus'];
    referenceID = json['referenceID'];
    referenceOrderID = json['referenceOrderID'];
    amount = json['amount'];
    balanceTime = json['balance_time'];
    balanceReward = json['balance_reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insId'] = this.insId;
    data['balance'] = this.balance;
    data['giftStatus'] = this.giftStatus;
    data['referenceID'] = this.referenceID;
    data['referenceOrderID'] = this.referenceOrderID;
    data['amount'] = this.amount;
    data['balance_time'] = this.balanceTime;
    data['balance_reward'] = this.balanceReward;
    return data;
  }
}
