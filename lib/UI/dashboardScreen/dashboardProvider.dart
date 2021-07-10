import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class DashboardProvider extends BaseProvider {
  NextVideos nextVideo;
  PreviousVideo previousVideo;
  SurveyDetails surveyDetails;

  performGetVideos(String videoID) async {
    print("1");
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      "v": videoID
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.getVideos, queryParameters: qParams)
        .then((response) => getSuccessResponse(response))
        .catchError((onError) {
      print('error 3213 - $onError');
    });
  }

  getSuccessResponse(Response response) {
    print("getSuccessResponse - 321 ");

    VideoResponse _response = VideoResponse.fromJson(response.data);

    // print("Response Data: vandhudhu");
    // print("Response Data:" + _response.toJson().toString());
    listener.onSuccess(_response, reqId: ResponseIds.GET_VIDEO);
    // print("Triggered listener for GetSUccessResponse");
  }

  // void setMemberList(List<Members> memberList){
  //   _members = memberList;
  //   notifyListeners();
  // }
  //
  // List<Members> get getMemberList => _members;
  void setNextVideo(NextVideos _nextVideo) {
    nextVideo = _nextVideo;
    notifyListeners();
  }

  NextVideos get getNextVideo => nextVideo;

  //set previous
  void setPreviousVideo(PreviousVideo _previousVideo) {
    previousVideo = _previousVideo;
    notifyListeners();
  }

  PreviousVideo get getPreviousVideo => previousVideo;

  //set survey
  void setSurveyVideo(SurveyDetails _surveyDetails) {
    surveyDetails = _surveyDetails;
    notifyListeners();
  }

  SurveyDetails get getSurveyVideo => surveyDetails;
  List<UserBadges> userBadges;
  // SpecialOffer
  //  specialOffer;
  // Bonus bonus;
  // Multiply multiply;
  // List<SpecialOffer> specialOffer;
  // List<Bonus> bonus;
  // List<Multiply> multiply;
  void setUserBadge(List<UserBadges> _userbadge) {
    userBadges = _userbadge;
    notifyListeners();
  }

  List<UserBadges> get getuserBadge => userBadges;

  // void setmultiply(List<Multiply> _mult){
  //   multiply = _mult;
  //   notifyListeners();
  // }
  // List<Multiply> get getmultiple => multiply;
  //
  //
  // void setbonus(List<Bonus> _bonus){
  //   bonus = _bonus;
  //   notifyListeners();
  // }
  // List<Bonus> get getbonus => bonus;
  //
  // void setspecialOffer(List<SpecialOffer> _offer){
  //   specialOffer = _offer;
  //   notifyListeners();
  // }
  // List<SpecialOffer> get getspecialOffer => specialOffer;

}
