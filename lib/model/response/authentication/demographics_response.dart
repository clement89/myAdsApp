class DemoGraphicsResponse {
  List<Interests> interests;
  List<GenerGroups> generGroups;
  List<AgeGroups> ageGroups;
  List<IncomeGroups> incomeGroups;
  List<StreamList> streamList;
  List<CountryList> countryList;

  DemoGraphicsResponse(
      {this.interests,
        this.generGroups,
        this.ageGroups,
        this.incomeGroups,
        this.streamList,
        this.countryList});

  DemoGraphicsResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    if (json['interests'] != null) {
      // ignore: deprecated_member_use
      interests = new List<Interests>();
      json['interests'].forEach((v) {
        interests.add(new Interests.fromJson(v));
      });
    }
    if (json['gener_groups'] != null) {
      // ignore: deprecated_member_use
      generGroups = new List<GenerGroups>();
      json['gener_groups'].forEach((v) {
        generGroups.add(new GenerGroups.fromJson(v));
      });
    }
    if (json['age_groups'] != null) {
      // ignore: deprecated_member_use
      ageGroups = new List<AgeGroups>();
      json['age_groups'].forEach((v) {
        ageGroups.add(new AgeGroups.fromJson(v));
      });
    }
    if (json['income_groups'] != null) {
      // ignore: deprecated_member_use
      incomeGroups = new List<IncomeGroups>();
      json['income_groups'].forEach((v) {
        incomeGroups.add(new IncomeGroups.fromJson(v));
      });
    }
    if (json['stream_list'] != null) {
      // ignore: deprecated_member_use
      streamList = new List<StreamList>();
      json['stream_list'].forEach((v) {
        streamList.add(new StreamList.fromJson(v));
      });
    }
    if (json['country_list'] != null) {
      // ignore: deprecated_member_use
      countryList = new List<CountryList>();
      json['country_list'].forEach((v) {
        countryList.add(new CountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interests != null) {
      data['interests'] = this.interests.map((v) => v.toJson()).toList();
    }
    if (this.generGroups != null) {
      data['gener_groups'] = this.generGroups.map((v) => v.toJson()).toList();
    }
    if (this.ageGroups != null) {
      data['age_groups'] = this.ageGroups.map((v) => v.toJson()).toList();
    }
    if (this.incomeGroups != null) {
      data['income_groups'] = this.incomeGroups.map((v) => v.toJson()).toList();
    }
    if (this.streamList != null) {
      data['stream_list'] = this.streamList.map((v) => v.toJson()).toList();
    }
    if (this.countryList != null) {
      data['country_list'] = this.countryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Interests {
  String value;
  String image;

  Interests({this.value, this.image});

  Interests.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['image'] = this.image;
    return data;
  }
}

class GenerGroups {
  String value;

  GenerGroups({this.value});

  GenerGroups.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class CountryList {
  String code;
  String value;
  String pinlength;

  CountryList({this.code, this.value,this.pinlength});

  CountryList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = json['value'];
    pinlength = json['pin_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['value'] = this.value;
    data['pin_length'] = this.pinlength;
    return data;
  }
}

class AgeGroups {
  String value;

  AgeGroups({this.value});

  AgeGroups.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class IncomeGroups {
  String value;

  IncomeGroups({this.value});

  IncomeGroups.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class StreamList {
  String value;

  StreamList({this.value});

  StreamList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}