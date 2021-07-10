import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/authentication/signupResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class SignUpProvider extends BaseProvider {
  TextEditingController usernameController;
  TextEditingController passwordController;
  bool _autoValidate;

  initialProvider() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _autoValidate = false;
  }

  void setAutoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  bool get getAutoValidate => _autoValidate;

  performSignUp() async {
    print("SignupProvider.dart: 1");
    String tempMail, tempPass;
    tempMail = (usernameController.text);
    tempPass = (passwordController.text);
    await SharedPrefManager.instance
        .setString(Constants.userEmail, Constants.userEmail)
        .whenComplete(() =>
            print("SignupProvider.dart: Written to SharedPref" + tempMail));
    await SharedPrefManager.instance
        .setString(Constants.password, tempPass)
        .whenComplete(() => print(
            "SignupProvider.dart: Written to pass to SharedPref" + tempPass));
    Map<String, String> qParams = {
      'e': usernameController.text,
      "p": passwordController.text
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.signUp1, queryParameters: qParams)
        .then((response) => successResponse(response))
        .catchError((onError) {
      print("SignupProvider.dart: 5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("SignupProvider.dart: 6");
    });
  }

  void successResponse(Response response) {
    print('got here  - ${response.data['error']}');
    if (response.data['error'] != null) {
      listener.onFailure(DioErrorUtil.handleErrors(response.data['error']));
    }
    SignUpResponse _response = SignUpResponse.fromJson(response.data);
    listener.onSuccess(_response, reqId: ResponseIds.SIGN_UP1);
  }

  clearProvider() {
    usernameController.clear();
    passwordController.clear();
  }
}
