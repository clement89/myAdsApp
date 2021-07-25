import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/activity/activityScreen.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

import 'CheckMyCoupons.dart';
import 'charts/BarChart.dart';
import 'settings/SettingScreen.dart';

class RewardsScreen extends StatefulWidget {
  List<UserBadges> userbadge;
  RewardsScreen({this.userbadge});
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BuildContext subcontext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.white,
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
        body: PageView.builder(
          controller: _controller, //cjc added
          itemBuilder: (context, position) {
            return widget.userbadge != null
                ? widget.userbadge[position].type == 'multiply'
                    ? MyPage1Widget(
                        multiply: widget.userbadge[position],
                        controller: _controller)
                    : widget.userbadge[position].type == 'bonus'
                        ? MyPage2Widget(
                            bonus: widget.userbadge[position],
                            controller: _controller)
                        : MyPage3Widget(
                            special: widget.userbadge[position],
                            controller: _controller)
                : Container();
            // widget.userbadge.bonus != null ?    MyPage2Widget(bonus: widget.userbadge,controller: _controller) : Container(),
            // widget.userbadge.specialOffer[0].image != null ?    MyPage3Widget(special: widget.userbadge.specialOffer[0],controller: _controller): Container(),
          },
          itemCount: widget.userbadge.length, // Can be null
        ));
  }

  Widget _DividerPopMenu() {
    return new PopupMenuButton<String>(
        offset: const Offset(0, 30),
        color: MyColors.blueShade,
        icon: const Icon(
          Icons.menu,
          color: MyColors.accentsColors,
        ),
        itemBuilder: (BuildContext context) {
          subcontext = context;
          return <PopupMenuEntry<String>>[
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
                )),
            new PopupMenuDivider(height: 3.0),
            new PopupMenuItem<String>(
                value: 'value05',
                child: InkWell(
                  onTap: () {
                    Navigator.of(subcontext).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ActivityScreen()));
                  },
                  child: new Text(
                    'My Activity',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                )),
            new PopupMenuDivider(height: 3.0),
            new PopupMenuItem<String>(
                value: 'value06',
                child: InkWell(
                  onTap: () async {
                    await SharedPrefManager.instance
                        .setString(Constants.userEmail, null)
                        .whenComplete(
                            () => print("user logged out . set to null"));
                    await SharedPrefManager.instance
                        .setString(Constants.password, null)
                        .whenComplete(
                            () => print("user logged out . set to null"));
                    Navigator.of(subcontext).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new WelcomeScreen()));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ChartsDemo()));
                  },
                  child: new Text(
                    'Logout',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                ))
          ];
        },
        onSelected: (String value) async {
          if (value == 'value02') {
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new SettingScreen()));
          } else if (value == 'value03') {
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new MyCouponScreen()));
          } else if (value == 'value04') {
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ChartsDemo()));
          } else if (value == 'value05') {
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ActivityScreen()));
          } else if (value == 'value06') {
            await SharedPrefManager.instance
                .clearAll()
                .whenComplete(() => print("All set to null"));
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new WelcomeScreen()));
          }
        });
  }
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 280.0,
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

class MyPage1Widget extends StatelessWidget {
  UserBadges multiply;
  PageController controller;
  MyPage1Widget({this.multiply, this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              '${MyStrings.congratulations}!',
              style: MyStyles.robotoMedium28.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            'Multiply: ${multiply.name}',
            style: MyStyles.robotoLight28.copyWith(
                letterSpacing: 1.0,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            'Benefit: ${(multiply.multiply - 100)}% multiplier',
            style: MyStyles.robotoLight28.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            "Criteria: ${multiply.criteria}",
            style: MyStyles.robotoLight22.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Stack(
          children: [
            Image.network(multiply.image),
            // Padding(
            //   padding: const EdgeInsets.only(top:150.0, left: 190.0),
            //   child: Text("${(multiply.multiply - 100).toString()}%",
            //     style: MyStyles.robotoMedium40.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top:200.0, left: 160.0),
            //   child: Text(MyStrings.multipliers,
            //     style: MyStyles.robotoMedium26.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              multiply.notification,
              style: MyStyles.robotoLight22.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.accentsColors,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //cjc commented
              // multiply.multiply != null
              //     ? SizedBox()
              //     : IconButton(
              //         icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: _submitButton(MyStrings.returnTo),
              ),
              Container(
                  width: 40,
                  height: 50,
                  color: Color.fromRGBO(112, 174, 222, 90),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                      })),
            ],
          ),
        ),
      ],
    );
  }
}

class MyPage2Widget extends StatelessWidget {
  UserBadges bonus;
  PageController controller;
  MyPage2Widget({this.bonus, this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              "${MyStrings.congratulations}!",
              style: MyStyles.robotoMedium28.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            'Bonus: ${bonus.name}',
            style: MyStyles.robotoLight28.copyWith(
                letterSpacing: 1.0,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            "Criteria: ${bonus.criteria}",
            style: MyStyles.robotoLight22.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            'Benefit: ${bonus.creditHours} Hours',
            style: MyStyles.robotoLight28.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Stack(
          children: [
            Image.network(bonus.image),
            // Padding(
            //   padding: const EdgeInsets.only(top:90.0, left: 110.0),
            //   child: Text((multiply.multiply - 100).toString() ,
            //     style: MyStyles.robotoMedium60.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              bonus.notification,
              style: MyStyles.robotoLight22.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.accentsColors,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 40,
                  height: 50,
                  color: Color.fromRGBO(112, 174, 222, 90),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.previousPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                      })),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: _submitButton(MyStrings.returnTo),
              ),
              //cjc commented
              // bonus.notification != null
              //     ? Container(
              //         width: 40,
              //         height: 50,
              //         color: Color.fromRGBO(112, 174, 222, 90),
              //         child: IconButton(
              //             icon: Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.white,
              //             ),
              //             onPressed: () {
              //               controller.nextPage(
              //                   duration: Duration(milliseconds: 250),
              //                   curve: Curves.easeInOut);
              //             }))
              //     : SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}

class MyPage3Widget extends StatelessWidget {
  UserBadges special;
  PageController controller;
  MyPage3Widget({this.special, this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              "${MyStrings.congratulations}!",
              style: MyStyles.robotoMedium28.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Center(
            child: Text(
              'Special Offer: ${special.name}.',
              style: MyStyles.robotoLight20.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        // SizedBox(height: 5.0,),
        Center(
          child: Text(
            'Benefit: ${special.promoCode}',
            style: MyStyles.robotoLight28.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            special.promoUrl,
            style: MyStyles.robotoLight22.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),

        SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            'Criteria: ${special.criteria}',
            style: MyStyles.robotoLight22.copyWith(
                letterSpacing: 1.0,
                color: MyColors.accentsColors,
                fontWeight: FontWeight.w100),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Stack(
          children: [
            Image.network(special.image),
            // Padding(
            //   padding: const EdgeInsets.only(top:90.0, left: 110.0),
            //   child: Text((multiply.multiply - 100).toString() ,
            //     style: MyStyles.robotoMedium60.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
            //   ),
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: Text(
              special.notification,
              style: MyStyles.robotoLight22.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.accentsColors,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //cjc commented
              // Container(
              //   width: 40,
              //   height: 50,
              //   color: Color.fromRGBO(112, 174, 222, 90),
              //   child: IconButton(
              //     icon: Icon(
              //       Icons.arrow_back_ios,
              //       color: Colors.white,
              //     ),
              //     onPressed: () {
              //       controller.previousPage(
              //           duration: Duration(milliseconds: 250),
              //           curve: Curves.easeInOut);
              //     },
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: _submitButton(MyStrings.returnTo),
              ),
              special == null
                  ? Container()
                  : Container(
                      width: 40,
                      height: 50,
                      color: Color.fromRGBO(112, 174, 222, 90),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          controller.nextPage(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
