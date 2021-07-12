import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/authenticationScreen/signIn/LogInScreen.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/Demo/DemographicsScreen.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/SignUpScreen.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: media.padding.top + 20,
              ),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(MyImages.appLogo),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 150,
            ),
            Center(
                child: Text(
              MyStrings.WelcomeTo,
              style: MyStyles.robotoLight60.copyWith(
                  letterSpacing: Dimens.letterSpacing_14,
                  color: MyColors.accentsColors,
                  fontWeight: FontWeight.w100),
            )),
            RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                children: <TextSpan>[
                  new TextSpan(
                    text: MyStrings.My,
                    style: MyStyles.robotoLight60.copyWith(
                        letterSpacing: Dimens.letterSpacing_14,
                        color: MyColors.accentsColors,
                        fontWeight: FontWeight.bold),
                  ),
                  new TextSpan(
                    text: MyStrings.Ads,
                    style: MyStyles.robotoLight60.copyWith(
                        letterSpacing: Dimens.letterSpacing_14,
                        color: MyColors.accentsColors,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              MyStrings.Watch,
              style: MyStyles.robotoMedium20.copyWith(
                  color: MyColors.darkGray, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 120,
            ),
            Text(
              MyStrings.Contribute,
              style: MyStyles.robotoLight20
                  .copyWith(color: MyColors.black, fontWeight: FontWeight.w500),
            ),
            Text(
              MyStrings.Paid,
              style: MyStyles.robotoLight20
                  .copyWith(color: MyColors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Dimens.dp_40,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new SignUpScreen()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: _submitButton(MyStrings.SignUp)),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new LoginScreen()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: _submitButton(MyStrings.LogIn)),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(String buttonName) {
    return Container(
      width: MediaQuery.of(context).size.height / 4,
      height: MediaQuery.of(context).size.height / 16,
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

  Future<void> checkSession() async {
    String emailid =
        await SharedPrefManager.instance.getString(Constants.userEmail);
    String pass =
        await SharedPrefManager.instance.getString(Constants.password);
    String uid = await SharedPrefManager.instance.getString(Constants.userId);
    if (emailid != null && pass != null && uid != null) {
      //cjc staging..

      String staging =
          await SharedPrefManager.instance.getString('signUp_staging');
      if (staging == 'DemographicsScreen') {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DemographicsScreen()));
      } else if (staging == 'DemographicsScreen') {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DemographicsScreen()));
      }

      print(emailid + pass + uid);
      Navigator.of(context).push(
          PageRouteBuilder(pageBuilder: (_, __, ___) => new DashBoardScreen()));
    } else {
      print("Welcome Screen:NO user Data Found");
    }
  }
}
