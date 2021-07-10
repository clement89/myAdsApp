import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/authentication/forgot_response.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';

class ForgotProvider extends BaseProvider{

  TextEditingController usernameController;

  bool _autoValidate;

  initialProvider(){
    usernameController = TextEditingController();
    _autoValidate = false;
  }

  void setAutoValidate(bool value){
    _autoValidate = value;
    notifyListeners();
  }

  bool get getAutoValidate => _autoValidate;




  performForgot() async {
    print("1");
    print(usernameController.text);
    Map<String, String> qParams = {
      'e': usernameController.text,
    };
    await ApiManager().getDio(isJsonType: false).
    post(Endpoints.forgot,queryParameters: qParams).
    then((response) =>
        successResponse(response)
    ).catchError((onError){
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  void successResponse(Response response){
    ForgotResponse _response = ForgotResponse.fromJson(response.data);
    listener.onSuccess(_response,reqId: ResponseIds.FORGOT_SCREEN);
  }


  clearProvider(){
    usernameController.clear();
  }


}