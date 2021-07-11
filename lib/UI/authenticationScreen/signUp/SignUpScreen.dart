import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/CheckMyCoupons.dart';
import 'package:myads_app/UI/Widgets/custom_textformfield.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/authenticationScreen/FoxProxy.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/signupProvider.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/authentication/signupResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';

import '../../charts/BarChart.dart';
import '../../settings/SettingScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUpProvider _signUpProvider;
  @override
  void initState() {
    super.initState();
    _signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    _signUpProvider.initialProvider();
    _signUpProvider.listener = this;
  }

  void _performSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performSignup();
    } else {
      _signUpProvider.setAutoValidate(true);
    }
  }

  void _performSignup() {
    _signUpProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _signUpProvider.performSignUp();
  }

  @override
  Future<void> onSuccess(any, {int reqId}) async {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.SIGN_UP1:
        SignUpResponse _response = any as SignUpResponse;
        if (_response.useremail != null) {
          await SharedPrefManager.instance
              .setString(Constants.userId, _response.userid.toString());
          await SharedPrefManager.instance
              .setString(Constants.userEmail, _response.useremail);
          String emailid =
              await SharedPrefManager.instance.getString(Constants.userEmail);
          print("success ${_response.username} ${emailid}");

          await SharedPrefManager.instance
              .setString('signUp_staging', 'not_started'); //cjc staging..

          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (_, __, ___) => new FoxProxyScreen()));
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.error);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.colorLight,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(''),
              Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Center(child: Image.asset(MyImages.appBarLogo)),
              ),
              // _simplePopup(),
              // _DividerPopMenu(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: IconButton(icon: Icon(Icons.menu, color: MyColors.accentsColors, size: 30,),onPressed: (){
              //    print("jhkl");
              //     _simplePopup();
              //   },),
              // ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<SignUpProvider>(builder: (context, provider, _) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    color: MyColors.colorLight,
                    child: Image.asset(
                      MyImages.signInPic,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    MyStrings.EnterName,
                    style: MyStyles.robotoMedium26.copyWith(
                        letterSpacing: 2.0,
                        color: MyColors.accentsColors,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  labelText: MyStrings.email,
                  controller: provider.usernameController,
                  validator: ValidateInput.validateEmail,
                  onSave: (value) {
                    provider.usernameController.text = value;
                  },
                ),
                CustomTextFormField(
                  labelText: MyStrings.password,
                  controller: provider.passwordController,
                  isPwdType: true,
                  validator: ValidateInput.validatePassword,
                  onSave: (value) {
                    provider.passwordController.text = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                    onTap: _performSubmit,
                    child: _submitButton(MyStrings.signMeUp)),
                SizedBox(height: media.size.height / 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Center(
                        child: RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            children: <TextSpan>[
                              new TextSpan(
                                text: MyStrings.termCondition,
                                style: MyStyles.robotoLight12.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.lightGray,
                                    fontWeight: FontWeight.w100),
                              ),
                              new TextSpan(
                                text: MyStrings.terms,
                                style: MyStyles.robotoLight12.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.darkGray,
                                    fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                text: MyStrings.read,
                                style: MyStyles.robotoLight12.copyWith(
                                  letterSpacing: 1.0,
                                  color: MyColors.lightGray,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Center(
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              children: <TextSpan>[
                                new TextSpan(
                                  text: MyStrings.haveReadOur,
                                  style: MyStyles.robotoLight12.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.lightGray,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                new TextSpan(
                                  text: MyStrings.privacyPolicy,
                                  style: MyStyles.robotoLight12.copyWith(
                                      letterSpacing: 1.0,
                                      color: MyColors.darkGray,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
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
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new ChartsDemo()));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChartsDemo()));
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
    width: 220.0,
    height: 45.0,
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
      style: MyStyles.robotoMedium14.copyWith(
          letterSpacing: 3.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}

class DropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Show Dialog'),
        backgroundColor: Color(0xff8c3a3a),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.blue[100],
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: Constants2.FirstItem,
                  child: Text(Constants2.FirstItem),
                ),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<String>(
                  value: Constants2.SecondItem,
                  child: Text(Constants2.FirstItem),
                ),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<String>(
                  value: Constants2.FirstItem,
                  child: Text(Constants2.FirstItem),
                ),
              ];
            },
          )
        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants2.FirstItem) {
      print('I First Item');
    } else if (choice == Constants2.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants2.ThirdItem) {
      print('I Third Item');
    }
  }
}

class Constants2 {
  static const String FirstItem = 'Settings';
  static const String SecondItem = 'Gift Card        ';
  static const String ThirdItem = 'Third Item';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
  ];
}
