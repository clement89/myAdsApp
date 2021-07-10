// class VideoResponse {
//   String userId;
//   String cb;
//   String timeAdded;
//   String timeBalance;
//   String videoId;
//   String videoName;
//   String videoImage;
//   String videoLink;
//   String productURL;
//   NextVideos nextVideos;
//   UserBadges userBadges;
//   // List<PreviousVideo> previousVideo;
//   PreviousVideo previousVideo;
//   String toWatchtime, watchedtime;
//   String wtachedPercentage;
//   String daysLeftThisMonth;
//   String balanceTime;
//   String balanceReward;
//   String reaction;
//   Survey survey;
//   Badge badge;
//   SurveyDetails surveyDetails;
//
//   VideoResponse(
//       this.userId,
//       this.cb,
//       this.timeAdded,
//       this.timeBalance,
//       this.videoId,
//       this.videoName,
//       this.videoImage,
//       this.videoLink,
//       this.productURL,
//       this.nextVideos,
//       this.userBadges,
//       this.previousVideo,
//       this.toWatchtime,
//       this.watchedtime,
//       this.wtachedPercentage,
//       this.daysLeftThisMonth,
//       this.balanceTime,
//       this.balanceReward,
//       this.reaction,
//       this.survey,
//       this.badge,
//       this.surveyDetails);
//
//   VideoResponse.fromJson(Map<String, dynamic> data) {
//     userId = data['user_id'];
//     cb = data['cb'];
//     timeAdded = data['time_added'];
//     timeBalance = data['time_balance'];
//     videoId = data['video_id'];
//     videoName = data['video_name'];
//     videoImage = data['video_image'];
//     videoLink = data['video_link'];
//     productURL = data['product_url'];
//     nextVideos = data['next_video'] != null
//         ? new NextVideos.fromJson(data['next_video'])
//         : null;
//     userBadges = data['userBadges'] != null
//         ? new UserBadges.fromJson(data['userBadges'])
//         : null;
//     previousVideo = data['previous_video'] != null
//         ? new PreviousVideo.fromJson(data['previous_video'])
//         : null;
//     if (data['to_watch_time'] != null) {
//       TimeFormatter timeFormatter =
//           TimeFormatter.fromJson(data['to_watch_time']);
//       toWatchtime = (timeFormatter.hrs).toString() +
//           ":" +
//           (timeFormatter.mins).toString() +
//           ":" +
//           (timeFormatter.sec).toString();
//     }
//     if (data['watched_time'] != null) {
//       TimeFormatter timeFormatter =
//           TimeFormatter.fromJson(data['watched_time']);
//       watchedtime = (timeFormatter.hrs).toString() +
//           ":" +
//           (timeFormatter.mins).toString() +
//           ":" +
//           (timeFormatter.sec).toString();
//     }
//
//     //  toWatchtime=data['to_watch_time'];
//     //  watchedtime=data['watched_time'];
//
//     wtachedPercentage = data['wtached_percentage'];
//     print(wtachedPercentage);
//     daysLeftThisMonth = data['days_left_this_month'];
//     print(daysLeftThisMonth);
//     balanceTime = data['balance_time'];
//     print(balanceTime);
//     balanceReward = data['balance_reward'];
//     print(balanceReward);
//     reaction = data['reaction'];
//     // survey=data['survey'];
//     print(reaction);
//     print(data['survey']);
//     if (data['survey'] != null) {
//       survey = Survey.fromJson(data['survey']);
//     }
//     print(survey);
//     badge = Badge.fromJson(data['badge']);
//     print(badge);
//     print(data['survey_details']);
//     surveyDetails = data['survey_details'] != null
//         ? new SurveyDetails.fromJson(data['survey_details'])
//         : null;
//     // surveyDetails = SurveyDetails.fromJson(data['survey_details']);
//     print("VideoResponse Page " + surveyDetails.toString());
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['cb'] = this.cb;
//     data['time_added'] = this.timeAdded;
//     data['time_balance'] = this.timeBalance;
//     data['video_id'] = this.videoId;
//     data['video_name'] = this.videoName;
//     data['video_image'] = this.videoImage;
//     data['video_link'] = this.videoLink;
//     data['product_url'] = this.productURL;
//     if (this.nextVideos != null) {
//       data['next_video'] = this.nextVideos.toJson();
//     }
//     if (this.userBadges != null) {
//       data['userBadges'] = this.userBadges.toJson();
//     }
//     if (this.previousVideo != null) {
//       data['previous_video'] = this.previousVideo.toJson();
//     }
//     data['to_watch_time'] = this.toWatchtime;
//     data['watched_time'] = this.watchedtime;
//     data['wtached_percentage'] = this.wtachedPercentage;
//     data['days_left_this_month'] = this.daysLeftThisMonth;
//     data['balance_time'] = this.balanceTime;
//     data['balance_reward'] = this.balanceReward;
//     data['reaction'] = this.reaction;
//     data['survey'] = this.survey;
//     if (this.surveyDetails != null) {
//       data['survey_details'] = this.surveyDetails.toJson();
//     }
//     data['badge'] = this.badge;
//     return data;
//   }
// }
//
// class TimeFormatter {
//   int hrs, mins, sec;
//   TimeFormatter(this.hrs, this.mins, this.sec);
//   TimeFormatter.fromJson(Map<String, dynamic> data) {
//     hrs = data['hrs'];
//     mins = data['mins'];
//     sec = data['sec'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['hrs'] = this.hrs;
//     data['mins'] = this.mins;
//     data['sec'] = this.sec;
//     return data;
//   }
// }
//
// class NextVideos {
//   String videoId;
//   String videoName;
//   String videoImage;
//   String videoLink;
//
//   NextVideos({this.videoId, this.videoName, this.videoImage, this.videoLink});
//
//   NextVideos.fromJson(Map<String, dynamic> json) {
//     videoId = json['video_id'];
//     videoName = json['video_name'];
//     videoImage = json['video_image'];
//     videoLink = json['video_link'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['video_id'] = this.videoId;
//     data['video_name'] = this.videoName;
//     data['video_image'] = this.videoImage;
//     data['video_link'] = this.videoLink;
//     return data;
//   }
// }
//
// class PreviousVideo {
//   String videoId;
//   String videoName;
//   String videoImage;
//   String videoLink;
//
//   PreviousVideo(
//       {this.videoId, this.videoName, this.videoImage, this.videoLink});
//
//   PreviousVideo.fromJson(Map<String, dynamic> json) {
//     videoId = json['video_id'];
//     videoName = json['video_name'];
//     videoImage = json['video_image'];
//     videoLink = json['video_link'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['video_id'] = this.videoId;
//     data['video_name'] = this.videoName;
//     data['video_image'] = this.videoImage;
//     data['video_link'] = this.videoLink;
//     return data;
//   }
// }
//
// class UserBadges {
//   SpecialOffer specialOffer;
//   Bonus bonus;
//   Multiply multiply;
//
//   UserBadges({this.specialOffer, this.bonus, this.multiply});
//
//   UserBadges.fromJson(Map<String, dynamic> json) {
//     specialOffer = json['special_offer'] != null
//         ? new SpecialOffer.fromJson(json['special_offer'])
//         : null;
//     bonus = json['bonus'] != null ? new Bonus.fromJson(json['bonus']) : null;
//     multiply = json['multiply'] != null
//         ? new Multiply.fromJson(json['multiply'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.specialOffer != null) {
//       data['special_offer'] = this.specialOffer.toJson();
//     }
//     if (this.bonus != null) {
//       data['bonus'] = this.bonus.toJson();
//     }
//     if (this.multiply != null) {
//       data['multiply'] = this.multiply.toJson();
//     }
//     return data;
//   }
// }
//
// class SpecialOffer {
//   String criteria;
//   String promoUrl;
//   String promoCode;
//   String notification;
//   String image;
//   double totViewMinutes;
//
//   SpecialOffer(
//       {this.criteria,
//         this.promoUrl,
//         this.promoCode,
//         this.notification,
//         this.image,
//         this.totViewMinutes});
//
//   SpecialOffer.fromJson(Map<String, dynamic> json) {
//     criteria = json['criteria'];
//     promoUrl = json['promoUrl'];
//     promoCode = json['promoCode'];
//     notification = json['notification'];
//     image = json['image'];
//     totViewMinutes = json['totViewMinutes'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['criteria'] = this.criteria;
//     data['promoUrl'] = this.promoUrl;
//     data['promoCode'] = this.promoCode;
//     data['notification'] = this.notification;
//     data['image'] = this.image;
//     data['totViewMinutes'] = this.totViewMinutes;
//     return data;
//   }
// }
//
// class Bonus {
//   String id;
//   String image;
//   String surveysCompleted;
//   String creditHours;
//   String notification;
//
//   Bonus(
//       {this.id,
//         this.image,
//         this.surveysCompleted,
//         this.creditHours,
//         this.notification});
//
//   Bonus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     surveysCompleted = json['surveysCompleted'];
//     creditHours = json['creditHours'];
//     notification = json['notification'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['image'] = this.image;
//     data['surveysCompleted'] = this.surveysCompleted;
//     data['creditHours'] = this.creditHours;
//     data['notification'] = this.notification;
//     return data;
//   }
// }
//
// class Multiply {
//   String id;
//   String period;
//   String image;
//   String notification;
//   int multiply;
//
//   Multiply(
//       {this.id, this.period, this.image, this.notification, this.multiply});
//
//   Multiply.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     period = json['period'];
//     image = json['image'];
//     notification = json['notification'];
//     multiply = json['multiply'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['period'] = this.period;
//     data['image'] = this.image;
//     data['notification'] = this.notification;
//     data['multiply'] = this.multiply;
//     return data;
//   }
// }
//
// class Survey {
//   String one, two, comment;
//   Survey(this.one, this.two, this.comment);
//
//   Survey.fromJson(Map<String, dynamic> json) {
//     one = json["1"];
//     two = json["2"];
//     comment = json["comment"];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['1'] = this.one;
//     data['2'] = this.two;
//     data['comment'] = this.comment;
//     return data;
//   }
// }
// class SurveyDetails {
//   String name;
//   List<Question> question;
//
//   SurveyDetails({this.name, this.question});
//
//   SurveyDetails.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if (json['question'] != null) {
//       question = new List<Question>();
//       json['question'].forEach((v) {
//         question.add(new Question.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     if (this.question != null) {
//       data['question'] = this.question.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
// class Question {
//   String question;
//   String type;
//
//   Question({this.question, this.type});
//
//   Question.fromJson(Map<String, dynamic> json) {
//     question = json['question'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['question'] = this.question;
//     data['type'] = this.type;
//     return data;
//   }
// }
// class Badge {
//   String image, type, benefit;
//
//   Badge(this.image, this.type, this.benefit);
//
//   Badge.fromJson(Map<String, dynamic> data) {
//     image = data['image'];
//     type = data['type'];
//     benefit = data['benifit'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['type'] = this.type;
//     data['benifit'] = this.benefit;
//     return data;
//   }
// }


class VideoResponse {
  bool flag;
  bool badgeFlag;
  String userId;
  String cb;
  String timeAdded;
  String timeBalance;
  List<UserBadges> userBadges;
  SurveyDetails surveyDetails;
  String videoName;
  String productUrl;
  String videoImage;
  String videoLink;
  String videoId;
  String rons;
  NextVideos nextVideo;
  PreviousVideo previousVideo;
  String watchedMinutes;
  String toWatchMinutes;
  String toWatchtime, watchedtime;
  String wtachedPercentage;
  String daysLeftThisMonth;
  String balanceTime;
  String balanceReward;
  String reaction;
  Survey survey;

  VideoResponse(
      {this.userId,
      this.badgeFlag,
      this.flag,
        this.cb,
        this.timeAdded,
        this.timeBalance,
        this.userBadges,
        this.surveyDetails,
        this.videoName,
        this.productUrl,
        this.videoImage,
        this.videoLink,
        this.videoId,
        this.rons,
        this.nextVideo,
        this.previousVideo,
        this.watchedMinutes,
        this.toWatchMinutes,
        this.watchedtime,
        this.toWatchtime,
        this.wtachedPercentage,
        this.daysLeftThisMonth,
        this.balanceTime,
        this.balanceReward,
        this.reaction,
        this.survey});

  VideoResponse.fromJson(Map<String, dynamic> json) {
    badgeFlag = json["badgeFlag"];
  flag = json["flag"];
    userId = json['user_id'];
    cb = json['cb'];
    timeAdded = json['time_added'];
    timeBalance = json['time_balance'];
    // userBadges = json['userBadges'] != null
    //     ? new UserBadges.fromJson(json['userBadges'])
    //     : null;
    if (json['userBadges'] != null) {
      userBadges = new List<UserBadges>();
      json['userBadges'].forEach((v) {
        userBadges.add(new UserBadges.fromJson(v));
      });
    }
    surveyDetails = json['survey_details'] != null
        ? new SurveyDetails.fromJson(json['survey_details'])
        : null;
    videoName = json['video_name'];
    productUrl = json['product_url'];
    videoImage = json['video_image'];
    videoLink = json['video_link'];
    videoId = json['video_id'];
    rons = json['rons'];
    nextVideo = json['next_video'] != null
        ? new NextVideos.fromJson(json['next_video'])
        : null;
    previousVideo = json['previous_video'] != null
        ? new PreviousVideo.fromJson(json['previous_video'])
        : null;
    watchedMinutes = json['watched_minutes'];
    toWatchMinutes = json['to_watch_minutes'];
    if (json['to_watch_time'] != null) {
      TimeFormatter timeFormatter =
      TimeFormatter.fromJson(json['to_watch_time']);
      toWatchtime = (timeFormatter.hrs).toString() +
          ":" +
          (timeFormatter.mins).toString() +
          ":" +
          (timeFormatter.sec).toString();
    }
    if (json['watched_time'] != null) {
      TimeFormatter timeFormatter =
      TimeFormatter.fromJson(json['watched_time']);
      watchedtime = (timeFormatter.hrs).toString() +
          ":" +
          (timeFormatter.mins).toString() +
          ":" +
          (timeFormatter.sec).toString();
    }
    wtachedPercentage = json['wtached_percentage'];
    daysLeftThisMonth = json['days_left_this_month'];
    balanceTime = json['balance_time'];
    balanceReward = json['balance_reward'];
    reaction = json['reaction'];
    survey =
    json['survey'] != null ? new Survey.fromJson(json['survey']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["badgeFlag"]= this.badgeFlag;
    data['flag']= this.flag;
    data['user_id'] = this.userId;
    data['cb'] = this.cb;
    data['time_added'] = this.timeAdded;
    data['time_balance'] = this.timeBalance;
    if (this.userBadges != null) {
      data['userBadges'] = this.userBadges.map((v) => v.toJson()).toList();
    }
    if (this.surveyDetails != null) {
      data['survey_details'] = this.surveyDetails.toJson();
    }
    data['video_name'] = this.videoName;
    data['product_url'] = this.productUrl;
    data['video_image'] = this.videoImage;
    data['video_link'] = this.videoLink;
    data['video_id'] = this.videoId;
    data['rons'] = this.rons;
    if (this.nextVideo != null) {
      data['next_video'] = this.nextVideo.toJson();
    }
    if (this.previousVideo != null) {
      data['previous_video'] = this.previousVideo.toJson();
    }
    data['watched_minutes'] = this.watchedMinutes;
    data['to_watch_minutes'] = this.toWatchMinutes;
    data['to_watch_time'] = this.toWatchtime;
    data['watched_time'] = this.watchedtime;
    data['wtached_percentage'] = this.wtachedPercentage;
    data['days_left_this_month'] = this.daysLeftThisMonth;
    data['balance_time'] = this.balanceTime;
    data['balance_reward'] = this.balanceReward;
    data['reaction'] = this.reaction;
    if (this.survey != null) {
      data['survey'] = this.survey.toJson();
    }
    return data;
  }
}



class SurveyDetails {
  String name;
  String id;
  List<Question> question;

  SurveyDetails({this.name, this.question, this.id});

  SurveyDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    if (json['question'] != null) {
      question = new List<Question>();
      json['question'].forEach((v) {
        question.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.question != null) {
      data['question'] = this.question.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String question;
  String type;
  String answer;

  Question({this.question, this.type, this.answer});

  Question.fromJson(Map<String, dynamic> json) {
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

class NextVideos {
  String videoId;
  String videoName;
  String videoImage;
  String videoLink;

  NextVideos({this.videoId, this.videoName, this.videoImage, this.videoLink});

  NextVideos.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoName = json['video_name'];
    videoImage = json['video_image'];
    videoLink = json['video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['video_name'] = this.videoName;
    data['video_image'] = this.videoImage;
    data['video_link'] = this.videoLink;
    return data;
  }
}

class PreviousVideo {
  String videoId;
  String videoName;
  String videoImage;
  String videoLink;

  PreviousVideo({this.videoId, this.videoName, this.videoImage, this.videoLink});

  PreviousVideo.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoName = json['video_name'];
    videoImage = json['video_image'];
    videoLink = json['video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['video_name'] = this.videoName;
    data['video_image'] = this.videoImage;
    data['video_link'] = this.videoLink;
    return data;
  }
}
class WatchedTime {
  int hrs;
  int mins;
  int sec;

  WatchedTime({this.hrs, this.mins, this.sec});

  WatchedTime.fromJson(Map<String, dynamic> json) {
    hrs = json['hrs'];
    mins = json['mins'];
    sec = json['sec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hrs'] = this.hrs;
    data['mins'] = this.mins;
    data['sec'] = this.sec;
    return data;
  }
}

class Survey {
  String s1;
  String s2;
  String comment;

  Survey({this.s1, this.s2, this.comment});

  Survey.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['comment'] = this.comment;
    return data;
  }
}


class TimeFormatter {
  int hrs, mins, sec;
  TimeFormatter(this.hrs, this.mins, this.sec);
  TimeFormatter.fromJson(Map<String, dynamic> data) {
    hrs = data['hrs'];
    mins = data['mins'];
    sec = data['sec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hrs'] = this.hrs;
    data['mins'] = this.mins;
    data['sec'] = this.sec;
    return data;
  }
}

class UserBadges {
  int available;
  String type;
  String name;
  String id;
  String period;
  String image;
  String notification;
  int multiply;
  String promoUrl;
  String promoCode;
  String totViewMinutes;
  String surveysCompleted;
  String creditHours;
  String criteria;

  UserBadges(
      {this.available,
        this.type,
        this.name,
        this.id,
        this.period,
        this.image,
        this.notification,
        this.multiply,
        this.promoUrl,
        this.promoCode,
        this.totViewMinutes,
        this.surveysCompleted,
        this.creditHours,
        this.criteria});

  UserBadges.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    type = json['type'];
    name = json['name'];
    id = json['id'];
    period = json['period'];
    image = json['image'];
    notification = json['notification'];
    multiply = json['multiply'];
    promoUrl = json['promoUrl'];
    promoCode = json['promoCode'];
    totViewMinutes = json['totViewMinutes'];
    surveysCompleted = json['surveysCompleted'];
    creditHours = json['creditHours'];
    criteria = json['criteria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['type'] = this.type;
    data['name'] = this.name;
    data['id'] = this.id;
    data['period'] = this.period;
    data['image'] = this.image;
    data['notification'] = this.notification;
    data['multiply'] = this.multiply;
    data['promoUrl'] = this.promoUrl;
    data['promoCode'] = this.promoCode;
    data['totViewMinutes'] = this.totViewMinutes;
    data['surveysCompleted'] = this.surveysCompleted;
    data['creditHours'] = this.creditHours;
    data['criteria'] = this.criteria;
    return data;
  }
}



