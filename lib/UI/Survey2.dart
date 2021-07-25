import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitScreen.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SurveyScreen2 extends StatefulWidget {
  @override
  _SurveyScreen2State createState() => _SurveyScreen2State();
}

class _SurveyScreen2State extends State<SurveyScreen2> {

  double _rating = 3;
  // double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.colorLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(''),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Image.asset(MyImages.group4),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
                color: MyColors.accentsColors,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  MyStrings.whatHaveYouSay,
                  style: MyStyles.robotoLight28.copyWith(
                      letterSpacing: 1.0,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Container(
                color: MyColors.blueShade,
                height: MediaQuery.of(context).size.height/4.8,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text( MyStrings.question1,
                        style: MyStyles.robotoLight24.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w100),),
                      Text( MyStrings.questions4s,
                        style: MyStyles.robotoLight24.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w100),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:50.0, top: 10.0),
                            child: SmoothStarRating(
                              // rating: rating,
                              isReadOnly: false,
                              size: 40,
                              color: MyColors.primaryColor,
                              borderColor: MyColors.black,
                              filledIconData: Icons.star,
                              halfFilledIconData: Icons.star_half,
                              defaultIconData: Icons.star_border,
                              starCount: 5,
                              allowHalfRating: false,
                              spacing: 30.0,
                              onRated: (value) {
                                print("rating value -> $value");
                                // print("rating value dd -> ${value.truncate()}");
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:40.0, right: 40.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Disliked it',style: MyStyles.robotoBold12.copyWith(
                                letterSpacing: 1.0,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w100),),
                            Text('It was fine',style: MyStyles.robotoBold12.copyWith(
                                letterSpacing: 1.0,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w100),),
                            Text('Loved it',style: MyStyles.robotoBold12.copyWith(
                                letterSpacing: 1.0,
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w100),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: MyColors.white,
              height: MediaQuery.of(context).size.height/4.8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( MyStrings.question2,
                      style: MyStyles.robotoLight24.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w100),),
                    Text( MyStrings.question5s,
                      style: MyStyles.robotoLight24.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w100),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:50.0, top: 10.0),
                          child: SmoothStarRating(
                            // rating: rating,
                            isReadOnly: false,
                            size: 40,
                            color: MyColors.primaryColor,
                            borderColor: MyColors.black,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: false,
                            spacing: 30.0,
                            onRated: (value) {
                              print("rating value -> $value");
                              // print("rating value dd -> ${value.truncate()}");
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:40.0, right: 40.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Unlikely',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                          Text('Fairly likely',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                          Text('Very likely',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            Container(
              color: MyColors.blueShade,
              height: MediaQuery.of(context).size.height/4.8,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top:20.0,bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( MyStrings.question3,
                      style: MyStyles.robotoLight24.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w100),),
                    Text( MyStrings.question6S,
                      style: MyStyles.robotoLight24.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w100),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:50.0, top: 10.0),
                          child: SmoothStarRating(
                            // rating: rating,
                            isReadOnly: false,
                            size: 40,
                            color: MyColors.primaryColor,
                            borderColor: MyColors.black,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            allowHalfRating: true,
                            spacing: 30.0,
                            onRated: (value) {
                              print("rating value -> $value");
                              // print("rating value dd -> ${value.truncate()}");
                            },
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:40.0, right: 40.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Disliked it',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                          Text('It was fine',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                          Text('Loved it',style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w100),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            Text( MyStrings.howCouldWe,
              style: MyStyles.robotoLight24.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w100),),
            SizedBox(height: 30.0,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.colorLight,
                  border: Border.all(color: MyColors.darkGray)
              ),
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.height/2.5,
            ),
            SizedBox(height: 30.0,),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new WatchPortrait()));

                },
                child: _submitButton('RETURN TO MYADS')),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 250.0,
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
    child: Align(
      alignment: Alignment.center,
      child: Text(
        buttonName,
        style: MyStyles.robotoMedium12.copyWith(
            letterSpacing: 4.0,
            color: MyColors.white,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}