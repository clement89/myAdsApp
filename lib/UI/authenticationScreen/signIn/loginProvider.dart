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
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends BaseProvider {
  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController otpController;

  bool _fromSharedPref;
  bool _autoValidate;

  initialProvider() async {
    print('initialising again');

    String emailid =
        await SharedPrefManager.instance.getString(Constants.userEmail);
    String pass =
        await SharedPrefManager.instance.getString(Constants.password);
    print('email --- $emailid $pass');

    if (emailid == null) {
      final prefs = await SharedPreferences.getInstance();
      emailid = prefs.getString('email_new');
    }

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

  initialProviderNew() async {
    print('initialising again');
    otpController = TextEditingController();

    String emailid =
        await SharedPrefManager.instance.getString(Constants.userEmail);
    String pass =
        await SharedPrefManager.instance.getString(Constants.password);

    if (emailid == null) {
      final prefs = await SharedPreferences.getInstance();
      emailid = prefs.getString('email_new');
    }

    print('new email --- $emailid $pass');

    if (emailid != null && pass != null) {
      usernameController = TextEditingController(text: emailid);
      passwordController = TextEditingController(text: pass);
    }
    notifyListeners();
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

  performOtpValidation() async {
    print('otp validation...');

    String userId =
        await SharedPrefManager.instance.getString(Constants.userId);

    print(usernameController.text);
    print(passwordController.text);
    Map<String, String> qParams = {'id': userId, "otp": otpController.text};

    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.otpValidation, queryParameters: qParams)
        .then((response) => successResponseNew(response))
        .catchError((onError) {
      print('otp error - $onError');

      listener.onFailure(DioErrorUtil.handleErrors(onError));
    });
  }

  void successResponse(Response response) {
    SignInResponse _response = SignInResponse.fromJson(response.data);
    listener.onSuccess(_response, reqId: ResponseIds.LOGIN_SCREEN);
  }

  void successResponseNew(Response response) {
    listener.onSuccess(response.data, reqId: ResponseIds.OTP_SCREEN);
  }

  clearProvider() {
    usernameController.clear();
    passwordController.clear();
    otpController.clear();
  }
}
