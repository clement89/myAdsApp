import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => WelcomeScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: MyColors.accentsColors,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: media.padding.top + 20,
            ),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width / 1.8,
                child: Image.asset(MyImages.Logo),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
              child: Text(
            MyStrings.WelcomeTo,
            style: MyStyles.robotoLight60.copyWith(
                letterSpacing: Dimens.letterSpacing_14,
                color: MyColors.white,
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
                      color: MyColors.white,
                      fontWeight: FontWeight.w100),
                ),
                new TextSpan(
                  text: MyStrings.Ads,
                  style: MyStyles.robotoLight60.copyWith(
                      letterSpacing: Dimens.letterSpacing_14,
                      color: MyColors.white,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.9,
            width: MediaQuery.of(context).size.width / 2.9,
            child: Image.asset('assets/images/ellipse.png'),
          ),
        ],
      ),
    );
  }
}
