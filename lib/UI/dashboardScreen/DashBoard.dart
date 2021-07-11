import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/activity/activityScreen.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitScreen.dart';
import 'package:myads_app/UI/settings/SettingScreen.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/authentication/signup2Response.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../CheckMyCoupons.dart';
import '../RewardScreen.dart';
import '../charts/BarChart.dart';
import 'dashboardProvider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends BaseState<DashBoardScreen> {
  DashboardProvider _dashboardProvider;
  VideoResponse listOfVideos;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _dashboardProvider.listener = this;
    _dashboardProvider.performGetVideos("14");
    checkSession();
  }

  String imageUrl, videoUrl, watchTime = '0.0';
  String daysLeft = '0.0', Videoid, rons, per, producturl;
  double percentage = 0.0;
  int multiply = 0;
  BuildContext subcontext;
  bool flag;
  bool badgeFlag;

  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    print("in on success dashboard");
    switch (reqId) {
      case ResponseIds.GET_VIDEO:
        VideoResponse _response = any as VideoResponse;

        if (_response.userId.toString().isNotEmpty) {
          print("success ${_response.flag}");
          // if(_response.flag == true){

          setState(() {
            flag = _response.flag;
            badgeFlag = _response.badgeFlag;
            String s1 = _response.watchedtime;
            String s2 = _response.toWatchtime;
            var format = DateFormat("Hms", "en_US");
            var two = format.parse(s2);

            var three = DateFormat("hh:mm:ss").format(two);
            videoUrl = _response.videoLink;
            imageUrl = _response.videoImage;
            rons = _response.rons;
            watchTime = three;
            print("Current to Watch time" + s2);
            percentage = double.parse(_response.wtachedPercentage) / 1000;
            per = _response.wtachedPercentage;
            daysLeft = _response.daysLeftThisMonth.toString();
            Videoid = _response.videoId;
            producturl = _response.productUrl;
            _dashboardProvider.setUserBadge(_response.userBadges);
            listOfVideos = _response;
            _dashboardProvider.setPreviousVideo(_response.previousVideo);
            _dashboardProvider.setNextVideo(_response.nextVideo);
            _dashboardProvider.setSurveyVideo(_response.surveyDetails);
            print('Check getVideo ${_dashboardProvider.getSurveyVideo.id}');
            print('Check getVideo ${_response.surveyDetails.id}');
          });
        }
        // else{
        //    print("success1 ${_response.flag}");
        //   setState(() {
        //       flag = _response.flag;
        //   badgeFlag= _response.badgeFlag;
        //   String s1 = _response.watchedtime;
        //   String s2 = _response.toWatchtime;
        //   var format = DateFormat("Hms","en_US");
        //   var two = format.parse(s2);
        //   imageUrl = _response.videoImage;
        //   var three =  DateFormat("hh:mm:ss").format(two);
        //   percentage = double.parse(_response.wtachedPercentage) / 1000;
        //   per = _response.wtachedPercentage;
        //   daysLeft = _response.daysLeftThisMonth.toString();
        //   });
        // }

        // print("Signup res username ${SharedPrefManager.instance.getString(Constants.userName)}");
        // }
        else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.userId.toString());
        }
        break;
    }
  }

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
      body: SingleChildScrollView(
          child: Consumer<DashboardProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Text(
                  MyStrings.yourDashBoard,
                  style: MyStyles.robotoMedium28.copyWith(
                      letterSpacing: 1.0,
                      color: MyColors.accentsColors,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    color: MyColors.accentsColors,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            '$watchTime',
                            style: MyStyles.robotoLight28.copyWith(
                                color: MyColors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            'yet to watch',
                            style: MyStyles.robotoMedium14.copyWith(
                                color: MyColors.colorLight,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    color: MyColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: CircularPercentIndicator(
                            radius: 75.0,
                            lineWidth: 5.0,
                            backgroundColor: MyColors.accentsColors,
                            animation: true,
                            percent: percentage,
                            center: new Text(
                              "${per.toString()}%",
                              style: MyStyles.robotoMedium20.copyWith(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w100),
                            ),
                            // circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                          ),
                        )),
                        Text(
                          "monthly progress",
                          style: MyStyles.robotoMedium14.copyWith(
                              color: MyColors.white,
                              fontWeight: FontWeight.w100),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3,
                    color: MyColors.accentsColors,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            '$daysLeft',
                            style: MyStyles.robotoLight45.copyWith(
                                color: MyColors.white,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            'days left in month',
                            style: MyStyles.robotoMedium14.copyWith(
                                color: MyColors.colorLight,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            flag == false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text("No Preview",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)))),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            imageUrl ?? '',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _dashboardProvider.getPreviousVideo != null
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: 50,
                                      height: 70,
                                      color: Color.fromRGBO(112, 174, 222, 90),
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.chevron_compact_left,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (_dashboardProvider
                                                  .getPreviousVideo !=
                                              null) {
                                            setState(() {
                                              videoUrl = _dashboardProvider
                                                  .getPreviousVideo.videoLink;
                                              imageUrl = _dashboardProvider
                                                  .getPreviousVideo.videoImage;
                                              Videoid = _dashboardProvider
                                                  .getPreviousVideo.videoId;
                                            });
                                            _dashboardProvider.listener = this;
                                            _dashboardProvider
                                                .performGetVideos(Videoid);
                                          }
                                          // _dashboardProvider.performGetVideos(
                                          //     ((videoResponseList[index].nextVideos)[0]).videoId);
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            _dashboardProvider.getNextVideo != null
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 50,
                                      height: 70,
                                      color: Color.fromRGBO(112, 174, 222, 90),
                                      child: IconButton(
                                        icon: Icon(
                                          CupertinoIcons.chevron_compact_right,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          if (_dashboardProvider.getNextVideo !=
                                              null) {
                                            setState(() {
                                              videoUrl = _dashboardProvider
                                                  .getNextVideo.videoLink;
                                              imageUrl = _dashboardProvider
                                                  .getNextVideo.videoImage;
                                              Videoid = _dashboardProvider
                                                  .getNextVideo.videoId;
                                              // Videoid = _dashboardProvider.getNextVideo.videoId;
                                            });
                                          }
                                          _dashboardProvider.listener = this;
                                          _dashboardProvider
                                              .performGetVideos(Videoid);
                                          // _dashboardProvider.performGetVideos(
                                          //     ((videoResponseList[index].nextVideos)[0]).videoId);
                                        },
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: Container(
                            width: 60,
                            height: 30,
                            color: MyColors.blueShade.withOpacity(0.3),
                            child: Text(
                              "$rons\nRons",
                              style: MyStyles.robotoBold12.copyWith(
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w100),
                            )),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top:8.0,left: 15),
                      //   child: Image(image: NetworkImage(_dashboardProvider.getmultiple.image),height: 20,),
                      // )
                    ],
                  ),
            // PrefetchImageDemo(listOfVideos),
            SizedBox(height: 10),
            Stack(
              children: <Widget>[
                //First thing in the stack is the background
                //For the backgroud i create a column
                Column(
                  children: <Widget>[
                    //first element in the column is the white background (the Image.asset in your case)
                    flag == true
                        ? Container(
                            color: MyColors.lightBlueShade,
                            width: MediaQuery.of(context).size.width,
                            height: 140.0,
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => new
                                        // CustomOrientationPlayer(
                                        //     videoUrl: videoUrl,
                                        //     VideoId: Videoid,
                                        //     watchtime: watchTime,
                                        //     productUrl: producturl,
                                        //     rons: rons,
                                        //     surveyid: _dashboardProvider.getSurveyVideo.id
                                        // )
                                        WatchPortrait(
                                      videoUrl: videoUrl,
                                      VideoId: Videoid,
                                      watchtime: watchTime,
                                      productUrl: producturl,
                                      rons: rons,
                                      surveyid:
                                          _dashboardProvider.getSurveyVideo.id,
                                      // multiplyId: _dashboardProvider.getmultiple[0].id,
                                      // badgeId: _dashboardProvider.getbonus[0].id,
                                    ),
                                  ));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => WatchPortrait()));
                                },
                                child: Center(
                                    child: _submitButton('WATCH MYADS'))),
                          )
                        : Container(),
                    //second item in the column is a transparent space of 20
                    Container(height: 10.0)
                  ],
                ),
                //for the button i create another column
                Column(children: <Widget>[
                  //first element in column is the transparent offset
                  Container(height: 100.0),
                  Center(
                    child: badgeFlag == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _dashboardProvider
                                                .getuserBadge.isNotEmpty
                                            ? Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        new RewardsScreen(
                                                            userbadge:
                                                                _dashboardProvider
                                                                    .getuserBadge)))
                                            : Fluttertoast.showToast(
                                                msg:
                                                    "No Rewards Available Try Again later",
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor:
                                                    MyColors.primaryColor,
                                                textColor: Colors.white,
                                                timeInSecForIosWeb: 5,
                                              );
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => RewardsScreen()));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70.0,
                                            child:
                                                Image.asset(MyImages.goldIcon),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(19.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '100',
                                                  style: MyStyles.robotoBold14
                                                      .copyWith(
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                                Text(
                                                  'minutes',
                                                  style: MyStyles.robotoMedium8
                                                      .copyWith(
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _dashboardProvider
                                                .getuserBadge.isNotEmpty
                                            ? Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        new RewardsScreen(
                                                            userbadge:
                                                                _dashboardProvider
                                                                    .getuserBadge)))
                                            : Fluttertoast.showToast(
                                                msg:
                                                    "No Rewards Available Try Again later",
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor:
                                                    MyColors.primaryColor,
                                                textColor: Colors.white,
                                                timeInSecForIosWeb: 5,
                                              );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70.0,
                                            child:
                                                Image.asset(MyImages.goldIcon),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(22.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '500',
                                                  style: MyStyles.robotoBold14
                                                      .copyWith(
                                                          letterSpacing: 1.0,
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                                Text(
                                                  "minutes",
                                                  style: MyStyles.robotoMedium8
                                                      .copyWith(
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _dashboardProvider
                                                .getuserBadge.isNotEmpty
                                            ? Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        new RewardsScreen(
                                                            userbadge:
                                                                _dashboardProvider
                                                                    .getuserBadge)))
                                            : Fluttertoast.showToast(
                                                msg:
                                                    "No Rewards Available Try Again later",
                                                toastLength: Toast.LENGTH_SHORT,
                                                backgroundColor:
                                                    MyColors.primaryColor,
                                                textColor: Colors.white,
                                                timeInSecForIosWeb: 5,
                                              );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70.0,
                                            child:
                                                Image.asset(MyImages.goldIcon),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '1000',
                                                  style: MyStyles.robotoBold14
                                                      .copyWith(
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                                Text(
                                                  'minutes',
                                                  style: MyStyles.robotoMedium8
                                                      .copyWith(
                                                          color: MyColors
                                                              .accentsColors,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                child: InkWell(
                                  onTap: () {
                                    _dashboardProvider.getuserBadge.isNotEmpty
                                        ? Navigator.of(context).push(
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    new RewardsScreen(
                                                        userbadge:
                                                            _dashboardProvider
                                                                .getuserBadge)))
                                        : Fluttertoast.showToast(
                                            msg:
                                                "No Rewards Available Try Again later",
                                            toastLength: Toast.LENGTH_SHORT,
                                            backgroundColor:
                                                MyColors.primaryColor,
                                            textColor: Colors.white,
                                            timeInSecForIosWeb: 5,
                                          );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70.0,
                                        child: Image.asset(MyImages.goldShield),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "0",
                                              // _dashboardProvider.getuserBadge.isNotEmpty ?(_dashboardProvider.getuserBadge[0].multiply - 100).toString() : '0',
                                              style: MyStyles.robotoBold14
                                                  .copyWith(
                                                      color: MyColors
                                                          .accentsColors,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                            Text(
                                              MyStrings.multipliers,
                                              style: MyStyles.robotoMedium8
                                                  .copyWith(
                                                      color: MyColors
                                                          .accentsColors,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  )
                ])
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new SettingScreen()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                    },
                    child: _submitButton1('SETTINGS')),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new ChartsDemo()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ChartsDemo()));
                    },
                    child: _submitButton1('GRAPHS')),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        );
      })),
    );
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
                        pageBuilder: (_, __, ___) => new ActivityScreen()));
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

  Future<void> checkSession() async {
    String emailid =
        await SharedPrefManager.instance.getString(Constants.userEmail);
    String pass =
        await SharedPrefManager.instance.getString(Constants.password);
    String uid = await SharedPrefManager.instance.getString(Constants.userId);
    if (emailid != null && pass != null && uid != null) {
      print(emailid + pass + uid);
    } else {
      getSharedPrefForUser(uid);
      print("NO user Data Found");
    }
  }

  Future<void> getSharedPrefForUser(String uid) async {
    Map<String, String> qParams = {'u': uid};
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.userDetails, queryParameters: qParams)
        .then((response) => successResponse4(response))
        .catchError((onError) {
      print(onError);
      print("WelcomeScreen SharedprefCall");
    });
  }
}

successResponse4(Response response) async {
  SignUp2Response _response = SignUp2Response.fromJson(response.data);
  print(_response.firstName +
      " " +
      _response.lastName +
      " " +
      _response.mobile +
      " " +
      _response.postalCode +
      " " +
      _response.ageGroup +
      " ");
  await SharedPrefManager.instance
      .setString(Constants.firstName, _response.firstName);
  await SharedPrefManager.instance
      .setString(Constants.lastName, _response.lastName);
  await SharedPrefManager.instance
      .setString(Constants.userMobile, _response.mobile);
  await SharedPrefManager.instance
      .setString(Constants.userPostalCode, _response.postalCode);
  await SharedPrefManager.instance
      .setString(Constants.agegroup, _response.ageGroup);
  print("Dashboard Set all sharefdpref in login");
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 190.0,
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

Widget _submitButton1(String buttonName) {
  return Container(
    width: 100.0,
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

class ProgressIndicator extends StatefulWidget {
  ProgressIndicator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 5.0,
            backgroundColor: MyColors.accentsColors,
            animation: true,
            percent: 0.25,
            center: new Text(
              "25%",
              style: MyStyles.robotoMedium22
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            footer: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 0.0),
              child: new Text(
                "monthly progress",
                style: MyStyles.robotoLight14.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.w100),
              ),
            ),
            // circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
