import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/settings/updatePasswordResponse.dart';
import 'package:myads_app/model/response/settings/updatePlaybackResponse.dart';
import 'package:myads_app/model/response/settings/updateProfileResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class SettingsProvider extends BaseProvider{

  TextEditingController oldController;
  TextEditingController emailController;
  TextEditingController mobileController;
  TextEditingController newController;
  bool _autoValidate;
  String type;
  initialProvider(){
    oldController = TextEditingController();
    newController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    _autoValidate = false;

  }

  void setAutoValidate(bool value){
    _autoValidate = value;
    notifyListeners();
  }

  bool get getAutoValidate => _autoValidate;



  //update profile
  performProfileUpdate() async {
    print("1");
    print(mobileController.text);
    print(emailController.text);
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'e': emailController.text,
      "m": mobileController.text
    };
    await ApiManager().getDio(isJsonType: false).
    post(Endpoints.updateProfile,queryParameters: qParams).
    then((response) =>
        successResponse(response)
    ).catchError((onError){
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  void successResponse(Response response){
    UpdateProfileResponse _response = UpdateProfileResponse.fromJson(response.data);
    listener.onSuccess(_response,reqId: ResponseIds.UPDATE_PROFILE);
  }


  //update password
  performPasswordUpdate() async {
    print("1");
    print(oldController.text);
    print(newController.text);
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'o': oldController.text,
      "n": newController.text
    };
    await ApiManager().getDio(isJsonType: false).
    post(Endpoints.updatePassword,queryParameters: qParams).
    then((response) =>
        updatePasswordResponse  (response)
    ).catchError((onError){
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  void updatePasswordResponse(Response response){
    UpdatePasswordResponse _response = UpdatePasswordResponse.fromJson(response.data);
    listener.onSuccess(_response,reqId: ResponseIds.UPDATE_PASSWORD);
  }

  //update playback
  performPlayBackUpdate() async {
    print("1");
    print(oldController.text);
    print(newController.text);
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'pbopt': type,
    };
    await ApiManager().getDio(isJsonType: false).
    post(Endpoints.updatePlayBack,queryParameters: qParams).
    then((response) =>
        updatePlayBackResponse  (response)
    ).catchError((onError){
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  void updatePlayBackResponse(Response response){
    UpdatePlayBackResponse _response = UpdatePlayBackResponse.fromJson(response.data);
    listener.onSuccess(_response,reqId: ResponseIds.UPDATE_PLAYBACK);
  }


  clearProvider(){
    oldController.clear();
    newController.clear();
    emailController.clear();
    mobileController.clear();

  }


}