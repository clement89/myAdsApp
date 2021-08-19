import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/Widgets/custom_textformfield.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/authenticationScreen/signIn/LogInScreen.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/authentication/forgot_response.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:provider/provider.dart';
import '../../charts/BarChart.dart';
import '../../CheckMyCoupons.dart';
import '../../settings/SettingScreen.dart';
import 'ForgotPasswordProvider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends BaseState<ForgotPasswordScreen> {
  String screenName = "Forgot";
  ForgotProvider _forgotProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _forgotProvider = Provider.of<ForgotProvider>(context, listen: false);
    _forgotProvider.initialProvider();
    _forgotProvider.listener = this;
  }

  String videoUrl;
  bool isExpanded = false;

  void _performSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performForgot();
    } else {
      _forgotProvider.setAutoValidate(true);
    }
  }

  void _performForgot() {
    _forgotProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _forgotProvider.performForgot();
  }


  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.FORGOT_SCREEN:
        ForgotResponse _response = any as ForgotResponse;
        if (_response .success!= '') {
          // print("success");
          print("success ${_response.success}");
          // Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: _response.success,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: MyColors.primaryColor,
              textColor: MyColors.white,
              fontSize: 16.0);

        }else if(_response.error =='No User Found"'){
          print("else");
          Fluttertoast.showToast(
              msg: _response.success,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: MyColors.primaryColor,
              textColor: MyColors.white,
              fontSize: 16.0);
          // CodeSnippet.instance.showMsg(_response.success);
        }
        else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.error);
        }
        break;
    }
  }

  void _finishAccountCreation() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
      ModalRoute.withName('/'),
    );
  }
  _appBar(height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, 80 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Center(
            child: Text("",),),
          color: MyColors.colorLight,
          height: 60,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 20.0,
          left: 20.0,
          right: 20.0,
          child: Image.asset(MyImages.appBarLogo,height: 60,),
        ),

      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _appBar(AppBar().preferredSize.height),
      body: SingleChildScrollView(
        child: Consumer<ForgotProvider>(
            builder: (context, provider, _) {
              return Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Column(
                    children: [
                      SizedBox(height: 150.0,),
                      CustomTextFormField(
                        labelText: MyStrings.loginName,
                        controller: provider.usernameController,
                        validator: ValidateInput.validateEmail,
                        onSave: (value) {
                          provider.usernameController.text = value;
                        },
                      ),
                      SizedBox(height: 30.0,),
                      InkWell(
                          onTap: _performSubmit,
                          child: _submitButton(MyStrings.reset)),
                      SizedBox(height: 30.0,),
                      // Text('or'),
                      // SizedBox(height: 30.0,),
                      InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                            // Navigator.of(context).popUntil((route) => route.isFirst);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));;
                          },
                          child: _submitButton(MyStrings.logIn)),

                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _DividerPopMenu() {
    return PopupMenuButton(
      offset: const Offset(0, 30),
      color: MyColors.blueShade,
      // shape: RoundedRectangleBorder(
      // side: BorderSide(
      // color: MyColors.primaryColor
      // ),),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.horizontal(),
        side: BorderSide(
            color: MyColors.primaryColor
        ),
      ),
      onSelected: (value) {
        if (value == 'value02') {
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  WelcomeScreen()), (Route<dynamic> route) => false);
        }
      },
      icon: const Icon(
        Icons.menu,
        color: MyColors.accentsColors,
      ),
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry>[
        new PopupMenuItem(
          value: 'value01',
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: MyColors.blueShade,
              collapsedBackgroundColor: MyColors.blueShade,

              title: Text(
                'Dashboard                  ',
                style: MyStyles.robotoMedium16.copyWith(
                    letterSpacing: 1.0,
                    color: MyColors.lightGray,
                    fontWeight: FontWeight.w100),
              ),
              children: <Widget>[
                Divider(height: 2,color: MyColors.primaryColor,),
                ListTile(
                  onTap:(){
                    // print('settings');

                    Navigator.of(context).pop();
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new SettingScreen()));
                  },
                  title: Text(
                    'Settings',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                Divider(height: 2,color: MyColors.primaryColor,),
                ListTile(
                  onTap:(){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new MyCouponScreen()));

                  },
                  title: Text(
                    'Gift Cards',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                Divider(height: 2,color: MyColors.primaryColor,),
                ListTile(
                  onTap:(){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new ChartsPage()));

                  },
                  title: Text(
                    'Graphs',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                Divider(height: 2,color: MyColors.primaryColor),
                // Divider(height: 2,color: Colors.grey,),
              ],
            ),
          ),
        ),
        new PopupMenuItem(
          value: 'value02',
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Logout',
              style: MyStyles.robotoMedium16.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.black,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ],
    );
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
        style: MyStyles.robotoMedium12.copyWith(letterSpacing: 3.0,
            color: MyColors.white,
            fontWeight: FontWeight.w500),

      ),
    );
  }


}