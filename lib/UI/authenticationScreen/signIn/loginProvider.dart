import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/authentication/login_response.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class LoginProvider extends BaseProvider {
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController otpController;

  bool _fromSharedPref;
  bool _autoValidate;

  initialProvider() async {
    String emailid =
        await SharedPrefManager.instance.getString(Constants.userEmail);
    String pass =
        await SharedPrefManager.instance.getString(Constants.password);
    if (emailid != null && pass != null) {
      usernameController = TextEditingController(text: emailid);
      passwordController = TextEditingController(text: pass);
      _fromSharedPref = true;
      performSignIn();
    } else {
      _fromSharedPref = false;
      usernameController = TextEditingController();
      passwordController = TextEditingController();
      otpController = TextEditingController();
    }
    _autoValidate = false;
  }

  void setAutoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  bool get getAutoValidate => _autoValidate;

  performSignIn() async {
    print("1");
    if (_fromSharedPref) {
      print(usernameController.text);
      print(passwordController.text);
      Map<String, String> qParams = {
        'e': usernameController.text,
        "p": passwordController.text
      };
      await ApiManager()
          .getDio(isJsonType: false)
          .post(Endpoints.signIn, queryParameters: qParams)
          .then((response) => successResponse(response))
          .catchError((onError) {
        print("5");
        listener.onFailure(DioErrorUtil.handleErrors(onError));
        print("6");
      });
    } else {
      await SharedPrefManager.instance
          .setString(Constants.userEmail, usernameController.text)
          .whenComplete(() => print(
              "Written to SharedPrefLogin Screen" + usernameController.text));
      await SharedPrefManager.instance
          .setString(Constants.password, passwordController.text)
          .whenComplete(() => print(
              "Written to pass to SharedPref Login Screen" +
                  passwordController.text));
      print(usernameController.text);
      print(passwordController.text);
      Map<String, String> qParams = {
        'e': usernameController.text,
        "p": passwordController.text
      };
      await ApiManager()
          .getDio(isJsonType: false)
          .post(Endpoints.signIn, queryParameters: qParams)
          .then((response) => successResponse(response))
          .catchError((onError) {
        print("5");
        listener.onFailure(DioErrorUtil.handleErrors(onError));
        print("6");
      });
    }
  }

  void successResponse(Response response) {
    SignInResponse _response = SignInResponse.fromJson(response.data);
    listener.onSuccess(_response, reqId: ResponseIds.LOGIN_SCREEN);
  }

  clearProvider() {
    usernameController.clear();
    passwordController.clear();
    otpController.clear();
  }
}
