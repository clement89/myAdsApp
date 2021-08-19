import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/Widgets/custom_textformfield.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/authenticationScreen/forgotPassword/ForgotPasswordScreen.dart';
import 'package:myads_app/UI/authenticationScreen/signIn/loginProvider.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/authentication/login_response.dart';
import 'package:myads_app/model/response/authentication/signup2Response.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';

import '../../CheckMyCoupons.dart';
import '../../charts/BarChart.dart';
import '../../settings/SettingScreen.dart';

class LoginScreen extends StatefulWidget {
  final bool showOtp;
  LoginScreen({
    this.showOtp,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  LoginProvider _loginProvider;
  String emailID, Password;
  bool _passwordVisible = true;
  bool _otpVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _loginProvider.listener = this;

    if (widget.showOtp != null) {
      //cjc added
      _loginProvider.initialProviderNew();
      SharedPrefManager.instance.setString('signUp_staging', 'otp');
    } else {
      _loginProvider.initialProvider();
    }
  }

  String videoUrl;

  void _performSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performLogin();
    } else {
      _loginProvider.setAutoValidate(true);
    }
  }

  void _performLogin() {
    _loginProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    if (widget.showOtp != null) {
      _loginProvider.performOtpValidation();
    } else {
      _loginProvider.performSignIn();
    }
  }

  @override
  Future<void> onSuccess(any, {int reqId}) async {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.LOGIN_SCREEN:
        SignInResponse _response = any as SignInResponse;
        if (_response.userid != null) {
          // print("success");
          await SharedPrefManager.instance
              .setString(Constants.userId, _response.userid);
          await SharedPrefManager.instance
              .setString(Constants.userName, _response.username);
          await SharedPrefManager.instance
              .setString(Constants.userEmail, _response.useremail);
          print(
              "userid ${SharedPrefManager.instance.getString(Constants.userId)}");
          print("success ${_response.username}");
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DashBoardScreen()));
        } else if (_response.error == 'Incorrect Password') {
          CodeSnippet.instance.showMsg(_response.error);
        } else if (_response.error == 'User Not Found') {
          CodeSnippet.instance.showMsg(_response.error);
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.username);
        }
        break;
      case ResponseIds.OTP_SCREEN:
        Map<String, dynamic> _response = any as Map<String, dynamic>;
        CodeSnippet.instance.showMsg(_response['message']);
        SharedPrefManager.instance
            .setString('signUp_staging', 'completed'); //cjc staging..
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DashBoardScreen()));
    }
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Text(
                  "",
                ),
              ),
              color: MyColors.colorLight,
              height: 60,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 20.0,
              left: 20.0,
              right: 20.0,
              child: Image.asset(
                MyImages.appBarLogo,
                height: 60,
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // if (widget.showOtp != null) {
    //   //cjc added
    //   _loginProvider.initialProvider();
    // }

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: _appBar(AppBar().preferredSize.height),
        body: SingleChildScrollView(
          child: Consumer<LoginProvider>(builder: (context, provider, _) {
            return Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          MyStrings.letSGetThis,
                          style: MyStyles.robotoLight28.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.accentsColors,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child: Text(
                        MyStrings.theRoad,
                        style: MyStyles.robotoLight28.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.accentsColors,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    CustomTextFormField(
                      labelText: MyStrings.loginName,
                      controller: provider.usernameController,
                      validator: ValidateInput.validateEmail,
                      onSave: (value) {
                        provider.usernameController.text = value;
                      },
                    ),
                    CustomTextFormField(
                      labelText: MyStrings.password,
                      controller: provider.passwordController,
                      validator: ValidateInput.validatePassword,
                      isPwdType: _passwordVisible,
                      onSave: (value) {
                        provider.passwordController.text = value;
                      },
                      iconButton: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    widget.showOtp != null
                        ? CustomTextFormField(
                            labelText: 'Please Enter the OTP',
                            controller: provider.otpController,
                            validator: ValidateInput.validateOtp,
                            isPwdType: _otpVisible,
                            onSave: (value) {
                              provider.otpController.text = value;
                            },
                            iconButton: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _otpVisible == true
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _otpVisible = !_otpVisible;
                                });
                              },
                            ),
                          )
                        : Container(),

                    // _entryField(MyStrings.loginName),
                    // _entryField(MyStrings.password,isPassword: true),
                    SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                        onTap: () {
                          _performSubmit();
                          // print(provider.usernameController.text);
                          // print(provider.passwordController.text);
                        },
                        child: _submitButton(MyStrings.logIn)),
                    SizedBox(height: media.size.height / 5),
                    InkWell(
                      onTap: () {
                                           // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ForgotPasswordScreen()));;
                        //
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new ForgotPasswordScreen()));
                        _formKey.currentState.reset();
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          MyStrings.didYouForgot,
                          style: MyStyles.robotoLight16.copyWith(
                            letterSpacing: 1.0,
                            height: 2.0,
                            color: MyColors.lightGray,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> getSharedPrefForUser(String uid) async {
    Map<String, String> qParams = {'u': uid};
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.userDetails, queryParameters: qParams)
        .then((response) => successResponse2(response))
        .catchError((onError) {
      onError.toString();
      print("WelcomeScreen SharedprefCall");
    });
  }

  successResponse2(Response response) async {
    SignUp2Response _response = SignUp2Response.fromJson(response.data);
    await SharedPrefManager.instance
        .setString(Constants.firstName, _response.name);
    await SharedPrefManager.instance
        .setString(Constants.lastName, _response.lastName);
    await SharedPrefManager.instance
        .setString(Constants.userEmail, _response.email);
    await SharedPrefManager.instance
        .setString(Constants.userMobile, _response.mobile);
    await SharedPrefManager.instance
        .setString(Constants.userPostalCode, _response.postalCode);
    await SharedPrefManager.instance
        .setString(Constants.agegroup, _response.ageGroup);
    print(_response.name + _response.email);
    print("Set all sharefdpref in login");
  }
}

Widget _DividerPopMenu() {
  return new PopupMenuButton<String>(
      offset: const Offset(0, 30),
      color: MyColors.blueShade,
      icon: const Icon(
        Icons.menu,
        color: MyColors.accentsColors,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            new PopupMenuItem<String>(
                value: 'value01',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard                  ',
                      style: MyStyles.robotoMedium16.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.lightGray,
                          fontWeight: FontWeight.w100),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: MyColors.darkGray,
                    )
                  ],
                )),
            new PopupMenuDivider(height: 3.0),
            new PopupMenuItem<String>(
                value: 'value02',
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new SettingScreen()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SettingScreen()));
                    },
                    child: new Text(
                      'Settings',
                      style: MyStyles.robotoMedium16.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.black,
                          fontWeight: FontWeight.w100),
                    ))),
            new PopupMenuDivider(height: 3.0),
            new PopupMenuItem<String>(
                value: 'value03',
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new MyCouponScreen()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyCouponScreen()));
                    },
                    child: new Text(
                      'Gift Card',
                      style: MyStyles.robotoMedium16.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.black,
                          fontWeight: FontWeight.w100),
                    ))),
            new PopupMenuDivider(height: 3.0),
            new PopupMenuItem<String>(
                value: 'value04',
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //     pageBuilder: (_, __, ___) => new ChartsDemo()));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChartsPage()));
                  },
                  child: new Text(
                    'Graphs',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ))
          ],
      onSelected: (String value) {
        // setState(() { _bodyStr = value; });
      });
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 170.0,
    height: 40.0,
    padding: EdgeInsets.symmetric(vertical: 13),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.blueAccent.withAlpha(100),
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 1)
        ],
        color: MyColors.primaryColor),
    child: Text(
      buttonName,
      style: MyStyles.robotoMedium12.copyWith(
          letterSpacing: 3.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}
