import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/clipper.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/UI/dashboardScreen/dashboardProvider.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitProvider.dart';
import 'package:myads_app/UI/survey/SurveyScreen.dart';
import 'package:myads_app/UI/webview.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/custom_orientation_player/controls.dart';
import 'package:myads_app/custom_orientation_player/data_manager.dart';
import 'package:myads_app/model/balance/creditBalance.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../CheckMyCoupons.dart';
import '../charts/BarChart.dart';
import '../settings/SettingScreen.dart';

class WatchPortrait extends StatefulWidget {
  final String videoUrl,
      VideoId,
      watchtime,
      productUrl,
      rons,
      surveyid,
      multiplyId,
      badgeId;
  WatchPortrait(
      {this.videoUrl,
      this.VideoId,
      this.watchtime,
      this.productUrl,
      this.rons,
      this.surveyid,
      this.multiplyId,
      this.badgeId});

  @override
  _WatchPortraitState createState() => _WatchPortraitState();
}

class _WatchPortraitState extends BaseState<WatchPortrait> {
  FlickManager flickManager;
  DataManager dataManager;
  BuildContext subcontext;
  String tempWatchTime, tempYetToWatch, textTime;
  // List<String> urls = (mockData["items"] as List)
  //     .map<String>((item) => item["trailer_url"])
  //     .toList();
  WatchPortraitProvider _watchPortraitProvider;
  DashboardProvider _dashboardProvider;
 String videoUrl;
  @override
  void initState() {
    super.initState();
    videoUrl = widget.videoUrl;
    print("watch screen --------- ${widget.badgeId}");
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _dashboardProvider.listener = this;
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.videoUrl),
        autoPlay: true,
        onVideoEnd: () {
          // flickManager.flickVideoManager.autoInitialize.initialize();
          if(_dashboardProvider.getNextVideo != null){
            print("next video");
            _dashboardProvider.performGetVideos(_dashboardProvider.getNextVideo.videoId);
          }else if(_dashboardProvider.getPreviousVideo != null){
            print("previous video");
            _dashboardProvider.performGetVideos(_dashboardProvider.previousVideo.videoId);
          }else{
            print("replay");
            flickManager.flickControlManager.replay();
          }
        });
    print(flickManager.flickVideoManager.videoPlayerValue.position.inSeconds);
    print(flickManager.flickVideoManager.videoPlayerValue.duration.inSeconds);
    _watchPortraitProvider =
        Provider.of<WatchPortraitProvider>(context, listen: false);
    _watchPortraitProvider.listener = this;
    dataManager = DataManager(
        flickManager: flickManager,
        urls:
            'https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/example/the_valley_compressed.mp4?raw=true');
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  skipToVideo(String url) {
    flickManager.handleChangeVideo(VideoPlayerController.network(url));
  }

  String balance = "0.0", username = '';
  String a;
  String textPosition;
  String watch;
  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.CREDIT_BALANCE:
        CreditBalance _response = any as CreditBalance;
        if (_response.balance != null) {
          print("success");
          print("success ${_response.balance}");
          setState(() {
            balance = _response.balance.toString();
          });
          return _showAlertPopupTransparentt();
          // print("Signup res username ${SharedPrefManager.instance.getString(Constants.userName)}");
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.balance.toString());
        }
        break;
      case ResponseIds.GET_VIDEO:
        VideoResponse _response = any as VideoResponse;

        if (_response.userId.toString().isNotEmpty) {
          print("success ${_response.flag}");
          // if(_response.flag == true){

          setState(() {
            videoUrl = _response.videoLink;
            flickManager.handleChangeVideo(VideoPlayerController.network(_response.videoLink));
                //   videoChangeDuration: duration, timerCancelCallback: (bool playNext) {
              // videoChangeTimer.cancel();
              // if (playNext) {
              //   currentIndex++;
              // }
            // });
            _dashboardProvider.setUserBadge(_response.userBadges);
            _dashboardProvider.setPreviousVideo(_response.previousVideo);
            _dashboardProvider.setNextVideo(_response.nextVideo);
            _dashboardProvider.setSurveyVideo(_response.surveyDetails);

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
            Positioned(
              // To take AppBar Size only
              top: 10.0,
              left: 320.0,
              right: 20.0,
              child: _DividerPopMenu(),
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: _appBar(AppBar().preferredSize.height),

        // AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: MyColors.colorLight,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(''),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 26.0),
        //         child: Image.asset(MyImages.appBarLogo,height: 60,),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top:8.0),
        //         child: _DividerPopMenu(),
        //       ),
        //     ],
        //   ),
        // ),
        body: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && this.mounted) {
              flickManager.flickControlManager?.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager.flickControlManager?.autoResume();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                    preferredDeviceOrientationFullscreen: [
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ],
                    systemUIOverlayFullscreen: [],
                    flickVideoWithControls: FlickVideoWithControls(
                      videoFit: BoxFit.fitWidth,
                      controls: CustomOrientationControls(
                          dataManager: dataManager,
                          videoId: widget.VideoId,
                          yetToWatch: tempYetToWatch,
                          rons: widget.rons,
                          surveyId: widget.surveyid,
                          productUrl: widget.productUrl,
                          username: username,
                          multiplyId: widget.multiplyId,
                          badgeId: widget.badgeId),
                    ),
                    flickVideoWithControlsFullscreen: FlickVideoWithControls(
                      videoFit: BoxFit.fitWidth,
                      controls:
                          // CustomOrientationControlsCheck(    dataManager: dataManager,
                          //   videoId: widget.VideoId,),
                          CustomOrientationControls(
                              dataManager: dataManager,
                              videoId: widget.VideoId,
                              yetToWatch: tempYetToWatch,
                              rons: widget.rons,
                              surveyId: widget.surveyid,
                              productUrl: widget.productUrl,
                              username: username,
                              multiplyId: widget.multiplyId,
                              badgeId: widget.badgeId),
                    ),
                    // flickVideoWithControlsFullscreen: FlickVideoWithControls(
                    //   controls: CustomOrientationPlayer(),
                    // )
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, right: 50.0, top: 30.0),
                  child: widget.productUrl == null ||
                      widget.productUrl ==
                          'http://myads-web.vitruvian-test.com.au/new/api'?
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            _watchPortraitProvider.listener = this;
                            _watchPortraitProvider.performUpdateReaction(
                                "1", widget.VideoId);
                            Fluttertoast.showToast(
                                msg: "Smile Reaction added ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Image.asset(MyImages.group3,height: 35)),
                      InkWell(
                          onTap: () {
                            _watchPortraitProvider.listener = this;
                            _watchPortraitProvider.performUpdateReaction(
                                "0", widget.VideoId);
                            Fluttertoast.showToast(
                                msg: "Sad Reaction added ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Image.asset(MyImages.group4,height: 35)),
                      InkWell(
                          onTap: () {
                            if (widget.surveyid != null) {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new SurveyScreen(videoId: widget.VideoId)));
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "The survey for this Ads is not Available, pls try again later.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Image.asset(MyImages.group1,height: 35)),
                    ],
                  ):
                      widget.surveyid == null ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                if (widget.productUrl != null &&
                                    widget.productUrl !=
                                        'http://myads-web.vitruvian-test.com.au/new/api') {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => new WebViewScreen(
                                        url: widget.productUrl,
                                        title: "Google",
                                      )));
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                      "There is no Special Offers available now, please try again later.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }

                                print(widget.productUrl);
                              },
                              child: Image.asset(MyImages.group2,height: 35,)),
                          InkWell(
                              onTap: () {
                                _watchPortraitProvider.listener = this;
                                _watchPortraitProvider.performUpdateReaction(
                                    "1", widget.VideoId);
                                Fluttertoast.showToast(
                                    msg: "Smile Reaction added ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Image.asset(MyImages.group3,height: 35)),
                          InkWell(
                              onTap: () {
                                _watchPortraitProvider.listener = this;
                                _watchPortraitProvider.performUpdateReaction(
                                    "0", widget.VideoId);
                                Fluttertoast.showToast(
                                    msg: "Sad Reaction added ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Image.asset(MyImages.group4,height: 35)),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                if (widget.productUrl != null &&
                                    widget.productUrl !=
                                        'http://myads-web.vitruvian-test.com.au/new/api') {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => new WebViewScreen(
                                        url: widget.productUrl,
                                        title: "Google",
                                      )));
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                      "There is no Special Offers available now, please try again later.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }

                                print(widget.productUrl);
                              },
                              child: Image.asset(MyImages.group2,height: 35,)),
                          InkWell(
                              onTap: () {
                                _watchPortraitProvider.listener = this;
                                _watchPortraitProvider.performUpdateReaction(
                                    "1", widget.VideoId);
                                Fluttertoast.showToast(
                                    msg: "Smile Reaction added ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Image.asset(MyImages.group3,height: 35)),
                          InkWell(
                              onTap: () {
                                _watchPortraitProvider.listener = this;
                                _watchPortraitProvider.performUpdateReaction(
                                    "0", widget.VideoId);
                                Fluttertoast.showToast(
                                    msg: "Sad Reaction added ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Image.asset(MyImages.group4,height: 35)),
                          InkWell(
                              onTap: () {
                                if (widget.surveyid != null) {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                      new SurveyScreen(videoId: widget.VideoId)));
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                      "The survey for this Ads is not Available, pls try again later.",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              child: Image.asset(MyImages.group1,height: 35)),
                        ],
                      )

                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ValueListenableBuilder(
                              valueListenable: flickManager
                                  .flickVideoManager.videoPlayerController,
                              builder: (context, VideoPlayerValue value, child) {
                                //Do Something with the value.
                                tempWatchTime =
                                    value.position.toString().substring(0, 7);
                                return Text(
                                  tempWatchTime,
                                  style: MyStyles.robotoLight60.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Center(
                              child: Text(
                                MyStrings.minutesThis,
                                style: MyStyles.robotoMedium12.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.white,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      color: MyColors.lightBlueShade,
                    ),
                    Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ValueListenableBuilder(
                                valueListenable: flickManager
                                    .flickVideoManager.videoPlayerController,
                                builder:
                                    (context, VideoPlayerValue value, child) {
                                  //Do Something with the value.print(value);
                                  a = value.position.toString().substring(0, 7);
                                  Duration position = flickManager
                                      .flickVideoManager
                                      .videoPlayerValue
                                      .position;

                                  String positionInSeconds = position != null
                                      ? (position -
                                              Duration(
                                                  minutes: position.inMinutes))
                                          .inSeconds
                                          .toString()
                                          .padLeft(2, '0')
                                      : null;

                                  textPosition = position != null
                                      ? '${position.inMinutes}.$positionInSeconds'
                                      : '0.00';
                                  var format = DateFormat("HH:mm:ss");
                                  var one = format.parse(
                                      value.position.toString().substring(0, 7));
                                  var two = format.parse(widget.watchtime);
                                  print("watchportaitScreen" +
                                      one.toString() +
                                      " " +
                                      two.difference(one).toString());
                                  print(one.toString());
                                  print(two.toString());
                                  print(two
                                      .difference(one)
                                      .toString()
                                      .substring(0, 8));
                                  print(two.difference(one).inHours);
                                  tempYetToWatch = widget.watchtime;
                                  textTime = two
                                      .difference(one)
                                      .toString()
                                      .split('.')
                                      .first
                                      .padLeft(8, "0");
                                  return Text(
                                    textTime,
                                    style: MyStyles.robotoLight60.copyWith(
                                      letterSpacing: 1.0,
                                      color: MyColors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Center(
                                child: Text(
                                  MyStrings.yearned,
                                  style: MyStyles.robotoMedium12.copyWith(
                                      letterSpacing: 1.0,
                                      color: MyColors.white,
                                      fontWeight: FontWeight.w100),
                                ),
                              ),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 100.0,
                        color: MyColors.accentsColors,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 30.0,
                // ),
                // InkWell(
                //   onTap: () async {
                //     _watchPortraitProvider.listener = this;
                //     _watchPortraitProvider.performAddBalance(
                //         textPosition, widget.VideoId, textPosition);
                //     username = await SharedPrefManager.instance
                //         .getString(Constants.userName);
                //     print(username);
                //   },
                //   child: _submitButton(MyStrings.addtocredit),
                // ),
                SizedBox(
                  height: 50.0,
                ),
                InkWell(
                  onTap: () async {
                    _watchPortraitProvider.listener = this;
                    Duration position =
                        flickManager.flickVideoManager.videoPlayerValue.position;
                    String positionInSeconds = position != null
                        ? (position - Duration(minutes: position.inMinutes))
                            .inSeconds
                            .toString()
                            .padLeft(2, '0')
                        : null;
                    String textPosition = position != null
                        ? '${position.inMinutes}.$positionInSeconds'
                        : '0.00';
                    print("textposition" + textPosition);
                    if (await SharedPrefManager.instance
                            .getString("videoEnded") ==
                        "1") {
                      await SharedPrefManager.instance
                          .setString("videoEnded", "0");
                    } else {
                      await SharedPrefManager.instance
                          .setString("videoEnded", "0");
                      _watchPortraitProvider.performUpdateBalance(
                          textPosition,
                          textPosition,
                          widget.VideoId,
                          widget.multiplyId,
                          widget.badgeId);
                    }

                    print(username);

                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new DashBoardScreen()));
                  },
                  child: _submitButton(MyStrings.enoughForNow),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _DividerPopMenu() {
  //   return new PopupMenuButton<String>(
  //       offset: const Offset(0, 30),
  //       color: MyColors.blueShade,
  //       icon: const Icon(
  //         Icons.menu,
  //         color: MyColors.accentsColors,
  //       ),
  //       itemBuilder: (BuildContext context) {
  //         subcontext = context;
  //
  //         return <PopupMenuEntry<String>>[
  //           new PopupMenuItem<String>(
  //               value: 'value01',
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.of(context).push(PageRouteBuilder(
  //                       pageBuilder: (_, __, ___) => new DashBoardScreen()));
  //                 },
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Dashboard                  ',
  //                       style: MyStyles.robotoMedium16.copyWith(
  //                           letterSpacing: 1.0,
  //                           color: MyColors.black,
  //                           fontWeight: FontWeight.w100),
  //                     ),
  //                     Icon(
  //                       Icons.keyboard_arrow_down,
  //                       color: MyColors.darkGray,
  //                     )
  //                   ],
  //                 ),
  //               )),
  //           new PopupMenuDivider(height: 3.0),
  //           new PopupMenuItem<String>(
  //               value: 'value02',
  //               child: InkWell(
  //                   onTap: () {
  //                     Navigator.of(context).push(PageRouteBuilder(
  //                         pageBuilder: (_, __, ___) => new SettingScreen()));
  //                     // Navigator.push(
  //                     //     context,
  //                     //     MaterialPageRoute(
  //                     //         builder: (context) => SettingScreen()));
  //                   },
  //                   child: new Text(
  //                     'Settings',
  //                     style: MyStyles.robotoMedium16.copyWith(
  //                         letterSpacing: 1.0,
  //                         color: MyColors.black,
  //                         fontWeight: FontWeight.w100),
  //                   ))),
  //           new PopupMenuDivider(height: 3.0),
  //           new PopupMenuItem<String>(
  //               value: 'value03',
  //               child: InkWell(
  //                   onTap: () {
  //                     Navigator.of(context).push(PageRouteBuilder(
  //                         pageBuilder: (_, __, ___) => new MyCouponScreen()));
  //                     // Navigator.push(
  //                     //     context,
  //                     //     MaterialPageRoute(
  //                     //         builder: (context) => MyCouponScreen()));
  //                   },
  //                   child: new Text(
  //                     'Gift Card',
  //                     style: MyStyles.robotoMedium16.copyWith(
  //                         letterSpacing: 1.0,
  //                         color: MyColors.black,
  //                         fontWeight: FontWeight.w100),
  //                   ))),
  //           new PopupMenuDivider(height: 3.0),
  //           new PopupMenuItem<String>(
  //               value: 'value04',
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.of(context).push(PageRouteBuilder(
  //                       pageBuilder: (_, __, ___) => new ChartsDemo()));
  //                   // Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(
  //                   //         builder: (context) => ChartsDemo()));
  //                 },
  //                 child: new Text(
  //                   'Graphs',
  //                   style: MyStyles.robotoMedium16.copyWith(
  //                       letterSpacing: 1.0,
  //                       color: MyColors.black,
  //                       fontWeight: FontWeight.w100),
  //                 ),
  //               )),
  //           new PopupMenuDivider(height: 3.0),
  //           new PopupMenuItem<String>(
  //               value: 'value05',
  //               child: InkWell(
  //                 onTap: () {
  //
  //                 },
  //                 child: new Text(
  //                   'Rons Report',
  //                   style: MyStyles.robotoMedium16.copyWith(
  //                       letterSpacing: 1.0,
  //                       color: MyColors.black,
  //                       fontWeight: FontWeight.w100),
  //                 ),
  //               )),
  //           new PopupMenuDivider(height: 3.0),
  //           new PopupMenuItem<String>(
  //               value: 'value06',
  //               child: InkWell(
  //                 onTap: () async {
  //                   await SharedPrefManager.instance
  //                       .clearAll()
  //                       .whenComplete(() => print("All set to null"));
  //
  //                   Navigator.of(subcontext).push(PageRouteBuilder(
  //                       pageBuilder: (_, __, ___) => new WelcomeScreen()));
  //
  //                   // Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(
  //                   //         builder: (context) => ChartsDemo()));
  //                 },
  //                 child: new Text(
  //                   'Logout',
  //                   style: MyStyles.robotoMedium16.copyWith(
  //                       letterSpacing: 1.0,
  //                       color: MyColors.black,
  //                       fontWeight: FontWeight.w100),
  //                 ),
  //               ))
  //         ];
  //       },
  //       onSelected: (String value) async {
  //         if (value == 'value02') {
  //           Navigator.of(subcontext).push(PageRouteBuilder(
  //               pageBuilder: (_, __, ___) => new SettingScreen()));
  //         } else if (value == 'value03') {
  //           Navigator.of(subcontext).push(PageRouteBuilder(
  //               pageBuilder: (_, __, ___) => new MyCouponScreen()));
  //         } else if (value == 'value04') {
  //           Navigator.of(subcontext).push(PageRouteBuilder(
  //               pageBuilder: (_, __, ___) => new ChartsDemo()));
  //         } else if (value == 'value05') {
  //           await SharedPrefManager.instance
  //               .clearAll()
  //               .whenComplete(() => print("All set to null"));
  //           Navigator.of(subcontext).push(PageRouteBuilder(
  //               pageBuilder: (_, __, ___) => new WelcomeScreen()));
  //         }
  //       });
  // }
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
                        pageBuilder: (_, __, ___) => new ChartsPage()));
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
            // new PopupMenuItem<String>(
            //     value: 'value05',
            //     child: InkWell(
            //       onTap: () {
            //         Navigator.of(subcontext).push(PageRouteBuilder(
            //             pageBuilder: (_, __, ___) => new ActivityScreen()));
            //       },
            //       child: new Text(
            //         'My Activity',
            //         style: MyStyles.robotoMedium16.copyWith(
            //             letterSpacing: 1.0,
            //             color: MyColors.black,
            //             fontWeight: FontWeight.w100),
            //       ),
            //     )),
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
                pageBuilder: (_, __, ___) => new ChartsPage()));
            // } else if (value == 'value05') {
            //   Navigator.of(subcontext).push(PageRouteBuilder(
            //       pageBuilder: (_, __, ___) => new ActivityScreen()));
          } else if (value == 'value06') {
            await SharedPrefManager.instance
                .clearAll()
                .whenComplete(() => print("All set to null"));
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new WelcomeScreen()));
          }
        });
  }

  void _showAlertPopupTransparentt() {
    AlertDialog dialog = new AlertDialog(
      contentPadding: EdgeInsets.only(
        left: 0.0,
      ),
      content: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          fit: StackFit.loose,
          children: [
            Stack(
              children: [
                RotatedBox(
                  quarterTurns: 4,
                  child: ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: Container(
                      height: 25,
                      color: MyColors.lightBlueShade,
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 4,
                  child: ClipPath(
                    clipper: DiagonalPathClipperTwo(),
                    child: Container(
                      height: 25,
                      color: MyColors.accentsColors,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 150.0,
                          width: 150.0,
                          child: Image.asset('assets/images/FoziSmall.png')),
                      SizedBox(
                          width: 170.0,
                          child: Image.asset('assets/images/MaskGroup.png'))
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hi $username',
                            textAlign: TextAlign.left,
                            style: MyStyles.robotoLight30.copyWith(
                                letterSpacing: Dimens.letterSpacing_14,
                                color: MyColors.textColor1b1c20,
                                fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            MyStrings.congratulations,
                            textAlign: TextAlign.left,
                            style: MyStyles.robotoBold30.copyWith(
                                letterSpacing: Dimens.letterSpacing_14,
                                color: MyColors.textColor1b1c20,
                                fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 80.0,
                            ),
                            child: Text(
                              MyStrings.thanksForWatching,
                              style: MyStyles.robotoMedium18.copyWith(
                                  letterSpacing: 1.0,
                                  height: 1.5,
                                  color: MyColors.textColor1b1c20,
                                  fontWeight: FontWeight.w100),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      insetPadding:
          EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 0),
      // backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
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
          letterSpacing: 1.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}
