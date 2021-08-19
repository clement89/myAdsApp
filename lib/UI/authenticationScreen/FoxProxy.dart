import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/Demo/DemographicsScreen.dart';

import '../CheckMyCoupons.dart';
import '../charts/BarChart.dart';
import '../settings/SettingScreen.dart';

class FoxProxyScreen extends StatefulWidget {
  @override
  _FoxProxyScreenState createState() => _FoxProxyScreenState();
}

class _FoxProxyScreenState extends State<FoxProxyScreen> {
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
            // Positioned(    // To take AppBar Size only
            //   top: 10.0,
            //   left:320.0,
            //   right: 20.0,
            //   child: _DividerPopMenu(),
            // )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: Container(
        height: media.size.height * 2.3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Center(
                child: Text(
                  MyStrings.foxPrivacy,
                  style: MyStyles.robotoLight54.copyWith(
                      letterSpacing: 1.0,
                      color: MyColors.accentsColors,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          MyStrings.introduction,
                          style: MyStyles.robotoBold12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.textdColor,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 40,
                        ),
                        Text(
                          MyStrings.introduction1,
                          style: MyStyles.robotoLight13.copyWith(
                              color: MyColors.lightGray,
                              letterSpacing: 0.5,
                              height: 1.4,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 35,
                        ),
                        Text(
                          MyStrings.introduction2,
                          style: MyStyles.robotoLight13.copyWith(
                              color: MyColors.lightGray,
                              letterSpacing: 0.5,
                              height: 1.4,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 35,
                        ),
                        Text(
                          MyStrings.introduction3,
                          style: MyStyles.robotoLight13.copyWith(
                              color: MyColors.lightGray,
                              letterSpacing: 0.5,
                              height: 1.4,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 35,
                        ),
                        Text(
                          MyStrings.introduction4,
                          style: MyStyles.robotoLight13.copyWith(
                              color: MyColors.lightGray,
                              letterSpacing: 0.5,
                              height: 1.4,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 35,
                        ),
                        Text(
                          MyStrings.introduction5,
                          style: MyStyles.robotoLight13.copyWith(
                              color: MyColors.lightGray,
                              letterSpacing: 0.5,
                              height: 1.4,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0, right: 100),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new DemographicsScreen()));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                        },
                        child: _submitButton(MyStrings.agree)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCouponScreen()));
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
