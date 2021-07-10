import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/Demo/DemographicsScreen.dart';

import '../charts/BarChart.dart';
import '../CheckMyCoupons.dart';
import '../settings/SettingScreen.dart';

class FoxProxyScreen extends StatefulWidget {
  @override
  _FoxProxyScreenState createState() => _FoxProxyScreenState();
}

class _FoxProxyScreenState extends State<FoxProxyScreen> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
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
              child: Image.asset(MyImages.appBarLogo),
            ),
            _DividerPopMenu(),
          ],
        ),
      ),
      body: Container(
        height: media.size.height * 2.3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Center(
                child: Text(
                  MyStrings.foxPrivacy,
                  style: MyStyles.robotoLight58.copyWith(
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
                          style: MyStyles.robotoBold14.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.black,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 28,
                        ),
                        Text(
                          MyStrings.introduction1,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 32,
                        ),
                        Text(
                          MyStrings.introduction2,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 32,
                        ),
                        Text(
                          MyStrings.introduction3,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 32,
                        ),
                        Text(
                          MyStrings.introduction3,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 32,
                        ),
                        Text(
                          MyStrings.introduction4,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: media.size.height / 32,
                        ),
                        Text(
                          MyStrings.introduction5,
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.lightGray,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:100.0,right: 100),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  new DemographicsScreen()));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
                        },
                        child: _submitButton(MyStrings.agree)),
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
                        MaterialPageRoute(builder: (context) => ChartsDemo()));
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
    width: 200.0,
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
