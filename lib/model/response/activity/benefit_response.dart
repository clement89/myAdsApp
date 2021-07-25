class BenefitResponse {
  String ron;
  String ronAud;
  String status;
  String cardNo;
  String cardStatus;
  String emailId;

  BenefitResponse(
      {this.ron,
        this.ronAud,
        this.status,
        this.cardNo,
        this.cardStatus,
        this.emailId});

  BenefitResponse.fromJson(Map<String, dynamic> json) {
    ron = json['ron'];
    ronAud = json['ron_aud'];
    status = json['status'];
    cardNo = json['card_no'];
    cardStatus = json['card_status'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ron'] = this.ron;
    data['ron_aud'] = this.ronAud;
    data['status'] = this.status;
    data['card_no'] = this.cardNo;
    data['card_status'] = this.cardStatus;
    data['email_id'] = this.emailId;
    return data;
  }
}
