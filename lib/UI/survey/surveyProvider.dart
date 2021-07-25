import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/request/surveyReq.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/model/response/survey/surveyResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class SurveyProvider extends BaseProvider {
  TextEditingController commentController;
  SurveyRequest _surveyRequest;
  bool _autoValidate;
  String yesNo, truefalse, rating, likedislike, boolean, unlikely;
  int yesid, noid;
  bool byesno, isLike, isLove, isDislike;
  List<String> questionList = [];
  initialProvider(String comment) {
    commentController = TextEditingController(text: comment);
    _autoValidate = false;
  }

  void setAutoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  bool get getAutoValidate => _autoValidate;

  addQuestions(String getQuest) {
    questionList.add(getQuest);
  }

  // add survey 1
  performSurvey(String vid, surveyid) async {
    print('questionList ${questionList.join("&\$&")}');
    print("1f");
    print("1");
    Map<String, dynamic> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      "v": vid,
      "s": surveyid,
      "answer": questionList.join("&\$&")
    };
    _surveyRequest = SurveyRequest();
    _surveyRequest.u =
        await SharedPrefManager.instance.getString(Constants.userId);
    _surveyRequest.v = vid;
    // _surveyRequest.answers = questionList;
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.survey, queryParameters: qParams)
        .then((response) => getSuveyResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getSuveyResponse(Response response) {
    questionList = [];
    print("2");
    SurveyResponse _response = SurveyResponse.fromJson(response.data);
    print("3");
    // listener.onSuccess(_response);
    listener.onSuccess(_response, reqId: ResponseIds.ADD_SURVEY); //cjc added

    print("4");
  }

  SurveyDetails surveyDetails;

  void setSurveyData(SurveyDetails _survey) {
    surveyDetails = _survey;
    //   int count=0;
    // for(var i in surveyDetails.question){
    //   if(surveyDetails.question[count].type == 'Star Rating'){
    //     rating = surveyDetails.question[count].answer;
    //     print("yes star");
    //
    //   }
    //   else if(surveyDetails.question[count].type == 'Boolean (True / False)'){
    //     if(surveyDetails.question[count].answer == 'True'){
    //       yesid = 1;
    //     }else{
    //       noid = 2;
    //     }
    //
    //   }
    //   else if(surveyDetails.question[count].type == 'Yes / No'){
    //     if(surveyDetails.question[count].answer == 'Yes'){
    //       byesno = true;
    //     }else{
    //       byesno = true;
    //     }
    //   }
    //   else if(surveyDetails.question[count].type == 'Dislike / Liked / Loved'){
    //     if(surveyDetails.question[count].answer == 'Dislike'){
    //       isLike = false;
    //       isDislike = true;
    //       isLove = false;
    //     }else if(surveyDetails.question[count].answer == 'Liked'){
    //       isLike = true;
    //       isDislike = false;
    //       isLove = false;
    //     }else{
    //       isLike = false;
    //       isDislike = false;
    //       isLove = true;
    //     }
    //   }
    //   else if(surveyDetails.question[count].type == 'Text Box'){
    //     print("yes like");
    //     commentController.text = surveyDetails.question[count].answer;
    //   }
    //   count++;
    // }

    notifyListeners();
  }

  SurveyDetails get getSurveyData => surveyDetails;
  clearProvider() {
    commentController.clear();
  }
}
