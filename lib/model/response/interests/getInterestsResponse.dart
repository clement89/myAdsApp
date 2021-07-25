class GetInterestsResponse {
  List<Interests> interests;

  GetInterestsResponse({this.interests});

  GetInterestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['interests'] != null) {
      interests = new List<Interests>();
      json['interests'].forEach((v) {
        print(v);
        interests.add(new Interests.fromJson(v));
        print("next Iteration");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interests != null) {
      data['interests'] = this.interests.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interests {
  String value;
  String image;
  bool ischecked;
  Interests({this.value, this.image, this.ischecked});

  Interests.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    image = json['image'];
    print(json['ischecked']);
    // print((json['ischecked']) == true);
    if ((json['ischecked']) == true) {
      ischecked = true;
    } else {
      ischecked = false;
    }
    //  print((json['ischecked']).toLowerCase() == 'true');
    print(ischecked);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['image'] = this.image;
    data['ischecked'] = this.ischecked;
    return data;
  }
}
