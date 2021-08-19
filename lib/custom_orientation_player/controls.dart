import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/clipper.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitProvider.dart';
import 'package:myads_app/UI/survey/SurveyScreen.dart';
import 'package:myads_app/UI/webview.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/landscape_player/play_toggle.dart';
import 'package:myads_app/model/balance/creditBalance.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'data_manager.dart';

class CustomOrientationControls extends StatefulWidget {
  const CustomOrientationControls(
      {Key key,
      this.iconSize = 20,
      this.fontSize = 12,
      this.dataManager,
      this.videoId,
      this.yetToWatch,
      this.rons,
      this.surveyId,
      this.productUrl,
      this.username,
      this.multiplyId,
      this.badgeId,

      })
      : super(key: key);
  final double iconSize;
  final double fontSize;
  final DataManager dataManager;
  final String videoId;
  final String yetToWatch;
  final String rons;
  final String surveyId;
  final String productUrl;
  final String username;
  final String multiplyId;
  final String badgeId;

  @override
  _CustomOrientationControlsState createState() => _CustomOrientationControlsState();
}

class _CustomOrientationControlsState extends BaseState<CustomOrientationControls> {

  WatchPortraitProvider _watchPortraitProvider;


   @override
  void initState() {
    // TODO: implement initState
     print("controller screen --------- ${widget.badgeId}");
     _watchPortraitProvider = Provider.of<WatchPortraitProvider>(context, listen: false);
     _watchPortraitProvider.listener = this;
  }

  String balance = '0.0' ;
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
    }
  }
  @override
  Widget build(BuildContext context) {
    FlickVideoManager flickVideoManager =
        Provider.of<FlickVideoManager>(context);
    FlickControlManager controlManager =
    Provider.of<FlickControlManager>(context);
    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(
                      VideoId: this.widget.videoId, YetToWatch: this.widget.yetToWatch,multiplyId: widget.multiplyId,badgeId: widget.badgeId,),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickCurrentPosition(
                        fontSize: widget.fontSize,
                      ),
                      Text('/'),
                      FlickTotalDuration(
                        fontSize: widget.fontSize,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickSoundToggle(
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlickFullScreenToggleCheck(

                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0,left: 15),
          child: Container(
              width:60,
              height: 30,
              color: MyColors.blueShade.withOpacity(0.3),
              child: Text("${this.widget.rons}\nRons",
                style: MyStyles.robotoBold12.copyWith( color: MyColors.black, fontWeight: FontWeight.w100),
              )
          ),
        ),
        Positioned(
            right: 1,
            top: MediaQuery.of(context).size.height / 3.4,
            child: Column(
              children: [
                Container(
                  height: 100.0,
                  width: 240.0,
                  color: MyColors.primaryColor.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ValueListenableBuilder(
                              valueListenable:
                              flickVideoManager.videoPlayerController,
                              builder:
                                  (context, VideoPlayerValue value, child) {
                                //Do Something with the value.

                                return Text(
                                  value.position.toString().substring(0, 7),
                                  style: MyStyles.robotoLight60.copyWith(
                                    letterSpacing: 1.0,
                                    color: MyColors.white,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            MyStrings.Watched,
                            style: MyStyles.robotoLight12.copyWith(
                                letterSpacing: 1.0,
                                color: MyColors.colorLight,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 240.0,
                  color: MyColors.accentsColors.withOpacity(0.5),
                  child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder(
                            valueListenable:
                            flickVideoManager.videoPlayerController,
                            builder: (context, VideoPlayerValue value, child) {
                              //Do Something with the value.
                              String a = value.position.toString().substring(0, 7);
                              Duration position =
                                  flickVideoManager.videoPlayerValue.position;
                              String positionInSeconds = position != null
                                  ? (position -
                                  Duration(minutes: position.inMinutes))
                                  .inSeconds
                                  .toString()
                                  .padLeft(2, '0')
                                  : null;
                              String textPosition = position != null
                                  ? '${position.inMinutes}.$positionInSeconds'
                                  : '0.00';
                              var format = DateFormat("HH:mm:ss");
                              var one = format.parse(a);
                              var two = format.parse(widget.yetToWatch);
                              print(one.toString() +
                                  " " +
                                  two.difference(one).toString());
                              String tempYetToWatch =
                              (two.difference(one).toString()).split('.').first.padLeft(8, "0");
                              return Text(
                                tempYetToWatch,
                                style: MyStyles.robotoLight60.copyWith(
                                  letterSpacing: 1.0,
                                  color: MyColors.white,
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              MyStrings.yearned,
                              style: MyStyles.robotoLight12.copyWith(
                                  letterSpacing: 1.0,
                                  color: MyColors.colorLight,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 30.0, top: 310.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    controlManager.exitFullscreen();
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new WebViewScreen(
                          url: this.widget.productUrl,
                          title: "Google",
                        )));
                    print(this.widget.productUrl);
                  },
                  child: Image.asset(MyImages.group2)),
              SizedBox(width: 50,),
              InkWell(
                  onTap: () {
                    _watchPortraitProvider.listener = this;
                    _watchPortraitProvider.performUpdateReaction(
                        "1", widget.videoId);
                    Fluttertoast.showToast(
                        msg: "Smile Reaction added ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Image.asset(MyImages.group1)),
              SizedBox(width: 50,),
              InkWell(
                  onTap: () {
                    _watchPortraitProvider.listener = this;
                    _watchPortraitProvider.performUpdateReaction(
                        "0", widget.videoId);
                    Fluttertoast.showToast(
                        msg: "Sad Reaction added ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Image.asset(MyImages.group3)),
              SizedBox(width: 50,),
              InkWell(
                  onTap: () {
                    if(this.widget.surveyId != null)
                    {
                      controlManager.exitFullscreen();
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new SurveyScreen(videoId: this.widget.videoId)));
                    }else{
                      Fluttertoast.showToast(
                          msg: "The survey for this Ads is not Available, pls try again later.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: MyColors.primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Image.asset(MyImages.group4)),
            ],
          ),
        ),
      ],
    );
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
                            'Hi ${widget.username}',
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


class FlickFullScreenToggleCheck extends StatelessWidget {
  const FlickFullScreenToggleCheck(
      {Key key,
        this.enterFullScreenChild,
        this.exitFullScreenChild,
        this.toggleFullscreen,
        this.size,
        this.color,
        this.padding,
        this.decoration})
      : super(key: key);

  /// Widget shown when player is not in full-screen.
  ///
  /// Default - [Icon(Icons.fullscreen)]
  final Widget enterFullScreenChild;

  /// Widget shown when player is in full-screen.
  ///
  ///  Default - [Icon(Icons.fullscreen_exit)]
  final Widget exitFullScreenChild;

  /// Function called onTap of the visible child.
  ///
  /// Default action -
  /// ```dart
  ///     controlManager.toggleFullscreen();
  /// ```
  final Function toggleFullscreen;

  /// Size for the default icons.
  final double size;

  /// Color for the default icons.
  final Color color;

  /// Padding around the visible child.
  final EdgeInsetsGeometry padding;

  /// Decoration around the visible child.
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
    Provider.of<FlickControlManager>(context);
    Widget enterFullScreenWidget = enterFullScreenChild ??
        Icon(
          Icons.fullscreen,
          size: size,
          color: color,
        );
    Widget exitFullScreenWidget = exitFullScreenChild ??
        Icon(
          Icons.fullscreen_exit,
          size: size,
          color: color,
        );

    Widget child = controlManager.isFullscreen
        ? exitFullScreenWidget
        : enterFullScreenWidget;

    return GestureDetector(
      key: key,
      onTap: () {
        print("hello");
        if (toggleFullscreen != null) {
          // toggleFullscreen();
          print("if hello");

        } else {
          print("else hello");
          controlManager.toggleFullscreen();
          controlManager.play();
        }
      },
      child: Container(
        padding: padding,
        decoration: decoration,
        child: child,
      ),
    );
  }
}