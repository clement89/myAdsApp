// import 'dart:ui';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:myads_app/UI/survey/SurveyScreen.dart';
// import 'package:myads_app/landscape_player/play_toggle.dart';
//
// class LandscapePlayerControls extends StatelessWidget {
//   const LandscapePlayerControls(
//       {this.iconSize = 20, this.fontSize = 12});
//   final double iconSize;
//   final double fontSize;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         FlickShowControlsAction(
//           child: FlickSeekVideoAction(
//             child: Center(
//               child: FlickVideoBuffer(
//                 child: FlickAutoHideChild(
//                   showIfVideoNotInitialized: false,
//                   child: LandscapePlayToggle(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: FlickAutoHideChild(
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   child: Container(),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   color: Color.fromRGBO(0, 0, 0, 0.4),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       FlickPlayToggle(
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       FlickCurrentPosition(
//                         fontSize: fontSize,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: FlickVideoProgressBar(
//                             flickProgressBarSettings: FlickProgressBarSettings(
//                               height: 10,
//                               handleRadius: 10,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8.0,
//                                 vertical: 8,
//                               ),
//                               backgroundColor: Colors.white24,
//                               bufferedColor: Colors.white38,
//                               getPlayedPaint: (
//                                   {double handleRadius,
//                                     double height,
//                                     double playedPart,
//                                     double width}) {
//                                 return Paint()
//                                   ..shader = LinearGradient(colors: [
//                                     Color.fromRGBO(108, 165, 242, 1),
//                                     Color.fromRGBO(97, 104, 236, 1)
//                                   ], stops: [
//                                     0.0,
//                                     0.5
//                                   ]).createShader(
//                                     Rect.fromPoints(
//                                       Offset(0, 0),
//                                       Offset(width, 0),
//                                     ),
//                                   );
//                               },
//                               getHandlePaint: (
//                                   {double handleRadius,
//                                     double height,
//                                     double playedPart,
//                                     double width}) {
//                                 return Paint()
//                                   ..shader = RadialGradient(
//                                     colors: [
//                                       Color.fromRGBO(97, 104, 236, 1),
//                                       Color.fromRGBO(97, 104, 236, 1),
//                                       Colors.white,
//                                     ],
//                                     stops: [0.0, 0.4, 0.5],
//                                     radius: 0.4,
//                                   ).createShader(
//                                     Rect.fromCircle(
//                                       center: Offset(playedPart, height / 2),
//                                       radius: handleRadius,
//                                     ),
//                                   );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       FlickTotalDuration(
//                         fontSize: fontSize,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       FlickSoundToggle(
//                         size: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           right: 20,
//           top: 10,
//           child: GestureDetector(
//             onTap: () {
//               SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//               SystemChrome.setPreferredOrientations(
//                   [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => SurveyScreen(),
//               ));
//             },
//             child: Icon(
//               Icons.cancel,
//               size: 30,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/survey/SurveyScreen.dart';
import 'package:myads_app/UI/webview.dart';
import 'package:myads_app/custom_orientation_player/data_manager.dart';
import 'package:myads_app/landscape_player/play_toggle.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


class CustomOrientationControlsCheck extends StatelessWidget {
  const CustomOrientationControlsCheck(
      {Key key, this.iconSize = 20, this.fontSize = 12, this.dataManager, this.videoId, this.yetToWatch,
        this.rons})
      : super(key: key);
  final double iconSize;
  final double fontSize;
  final DataManager dataManager;
  final String videoId;
  final String yetToWatch;
  final String rons;
  @override
  Widget build(BuildContext context) {
    FlickVideoManager flickVideoManager =
    Provider.of<FlickVideoManager>(context);

    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: LandscapePlayToggle(
                    VideoId: this.videoId, YetToWatch: this.yetToWatch,),
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
                        fontSize: fontSize,
                      ),
                      Text('/'),
                      FlickTotalDuration(
                        fontSize: fontSize,
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
                      FlickFullScreenToggle()
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
              child: Text("${this.rons}\nRons",
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
                              var two = format.parse(yetToWatch);
                              print(one.toString() +
                                  " " +
                                  two.difference(one).toString());
                              String tempYetToWatch =
                              (two.difference(one).toString()).substring(0, 8);
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
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 310.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              url: "https://www.google.com/",
                              title: "Google",
                            )));
                  },
                  child: Image.asset(MyImages.group2)),
              SizedBox(
                width: 15,
              ),
              Image.asset(MyImages.group1),
              SizedBox(
                width: 15,
              ),
              Image.asset(MyImages.group3),
              SizedBox(
                width: 15,
              ),
              InkWell(
                  onTap: () {
                    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SurveyScreen()));
                  },
                  child: Image.asset(MyImages.group4)),
            ],
          ),
        ),
      ],
    );
  }
}