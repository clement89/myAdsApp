class SurveyRequest {
  String u;
  String v;
  List<Answers> answers;

  SurveyRequest({this.u, this.v, this.answers});

  SurveyRequest.fromJson(Map<String, dynamic> json) {
    u = json['u'];
    v = json['v'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u'] = this.u;
    data['v'] = this.v;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String question;
  String type;
  String answer;

  Answers({this.question, this.type, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    type = json['type'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['type'] = this.type;
    data['answer'] = this.answer;
    return data;
  }
}
