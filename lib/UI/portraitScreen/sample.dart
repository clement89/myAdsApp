// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:myads_app/Constants/colors.dart';
// import 'package:myads_app/UI/SettingScreen.dart';
// import 'package:myads_app/landscape_player/landscape_player.dart';
// import 'package:myads_app/landscape_player/play_toggle.dart';
// import 'package:myads_app/utils/mock_data.dart';
// import 'package:video_player/video_player.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// import '../../Constants/styles.dart';
//
// class DefaultPlayer extends StatefulWidget {
//   final String videoUrl;
//
//
//    DefaultPlayer({this.videoUrl});
//
//   @override
//   _DefaultPlayerState createState() => _DefaultPlayerState();
// }
//
// class _DefaultPlayerState extends State<DefaultPlayer> {
//   FlickManager flickManager;
//   VideoPlayerController _controller;
//   FlickManager _activeManager;
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//       // autoPlay: true,
//       videoPlayerController:
//       VideoPlayerController.network(widget.videoUrl),
//     );
//   }
//
//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }
//
//
//   togglePlay(FlickManager flickManager) {
//     if (_activeManager?.flickVideoManager?.isPlaying == true &&
//         flickManager == _activeManager) {
//       pause();
//     } else {
//       play(flickManager);
//     }
//   }
//
//   pause() {
//     _activeManager?.flickControlManager?.pause();
//   }
//
//   play([FlickManager flickManager]) {
//     if (flickManager != null) {
//       _activeManager?.flickControlManager?.pause();
//       _activeManager = flickManager;
//     }
//     _activeManager?.flickControlManager?.play();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return VisibilityDetector(
//       key: ObjectKey(flickManager),
//       onVisibilityChanged: (visibility) {
//         if (visibility.visibleFraction == 0 && this.mounted) {
//           flickManager.flickControlManager.autoPause();
//           // flickManager.flickControlManager.seekTo()
//
//         } else if (visibility.visibleFraction == 1) {
//           flickManager.flickControlManager.autoResume();
//         }
//       },
//       child: Container(
//         child: FlickVideoPlayer(
//           flickManager: flickManager,
//           flickVideoWithControls: FlickVideoWithControls(
//             controls:    FlickShowControlsAction(
//               child: FlickSeekVideoAction(
//                 child: Center(
//                   child: FlickVideoBuffer(
//                     child: FlickAutoHideChild(
//                       showIfVideoNotInitialized: false,
//                       child: Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: LandscapePlayToggle(),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             color: Color.fromRGBO(0, 0, 0, 0.4),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 // FlickPlayToggle(
//                                 //   size: 20,
//                                 //   pauseChild: GestureDetector(
//                                 //     onTap: (){
//                                 //
//                                 //       _showAlertPopup1Transparent();
//                                 //     },
//                                 //     child: SizedBox(),
//                                 //   ),
//                                 //
//                                 // ),
//
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 FlickCurrentPosition(
//                                   fontSize: 13,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: Container(),
//                                 ),
//                                 FlickTotalDuration(
//                                   // fontSize: fontSize,
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 FlickSoundToggle(
//                                   size: 20,
//                                 ),
//                                 FlickFullScreenToggle(
//                                   size: 20,
//                                   toggleFullscreen: (){
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => LandscapePlayer()));
//                                   },
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           flickVideoWithControlsFullscreen: FlickVideoWithControls(
//             controls: FlickLandscapeControls(),
//
//           ),
//         ),
//       ),
//     );
//   }
//   void _showAlertPopup1Transparent() {
//     AlertDialog dialog = new AlertDialog(
//       content: Container(
//         width: 450.0,
//         height: 280.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // SizedBox(height: 20,),
//             // Image(image: AssetImage(MyImages.check),
//             // color: MyColors.white,
//             // height: 110,),
//             SizedBox(height: 30,),
//             Text("Hi Jerald,",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 30,),
//             Text("Thanks for watching the AD, you just need towatch 20 mins more to get a Gift Card.",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 50,),
//             Center(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _showAlertPopup2Transparent();
//                   },
//
//                   child: _submitButton('OK')),
//             ),
//             SizedBox(height: 15,),
//             Center(
//               child: Text("* You will be notified on mail, once you ‘are eligible for Gift",
//                 style: MyStyles.robotoLight10.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//       insetPadding: EdgeInsets.only(left:25.0,right: 25.0),
//       backgroundColor: MyColors.accentsColors.withOpacity(0.8),
//     );
//     showDialog(context: context, builder: (context) => dialog,);
//   }
//   void _showAlertPopup2Transparent() {
//     AlertDialog dialog = new AlertDialog(
//       content: Container(
//         width: 450.0,
//         height: 300.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             // Image(image: AssetImage(MyImages.check),
//             // color: MyColors.white,
//             // height: 110,),
//             // SizedBox(height: 40,),
//             Text("Hi Jerald,",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Congratulations!",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Thanks for watching the AD, you are now Eligible to receive the Gift Card. Please click the button below to Get it Now.",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 50,),
//             Center(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _showAlertPopup3Transparent();
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
//                   },
//                   child: _submitButton('Get Gift Card')),
//             ),
//             SizedBox(height: 15,),
//             Center(
//               child: Text("* You will be notified on mail, once your Gift Card get approved",
//                 style: MyStyles.robotoLight10.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//       insetPadding: EdgeInsets.only(left:25.0,right: 25.0),
//       backgroundColor: MyColors.accentsColors.withOpacity(0.8),
//     );
//     showDialog(context: context, builder: (context) => dialog,);
//   }
//   void _showAlertPopup3Transparent() {
//     AlertDialog dialog = new AlertDialog(
//       content: Container(
//         width: 450.0,
//         height: 320.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             // Image(image: AssetImage(MyImages.check),
//             // color: MyColors.white,
//             // height: 110,),
//             // SizedBox(height: 40,),
//             Text("Hi Jerald,",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Congratulations!",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Your Gift Card request has been raised successfully.\nRequest ID: XXXXXXXXXX\nGenerated on : DD-MMM-2021",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40,),
//             Center(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _showAlertPopup4Transparent();
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
//                   },
//                   child: _submitButton('OK')),
//             ),
//             SizedBox(height: 15,),
//             Center(
//               child: Text("* You will be notified on Email, once your request gets approved.",
//                 style: MyStyles.robotoLight10.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//       insetPadding: EdgeInsets.only(left:25.0,right: 25.0
//       ),
//       backgroundColor: MyColors.accentsColors.withOpacity(0.8),
//     );
//     showDialog(context: context, builder: (context) => dialog,);
//   }
//   void _showAlertPopup4Transparent() {
//     AlertDialog dialog = new AlertDialog(
//       content: Container(
//         width: 450.0,
//         height: 400.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             // Image(image: AssetImage(MyImages.check),
//             // color: MyColors.white,
//             // height: 110,),
//             // SizedBox(height: 40,),
//             Text("Hi Jerald,",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Congratulations!",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Your Gift Card has been dispatched to your registered Email ID. Please check now and use the activation code: XXXX to use your Gift Card.",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10,),
//             Text("Gift Card ID is XXXXXXXXXXXXXX.",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40,),
//             Center(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     _showAlertPopup5Transparent();
//                     },
//                   child: _submitButton('OK')),
//             ),
//             SizedBox(height: 15,),
//             Center(
//               child: Text("*Your need to watch 208 mins, to avail more Exciting Gifts.",
//                 style: MyStyles.robotoLight10.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//       insetPadding: EdgeInsets.only(left:25.0,right: 25.0
//       ),
//       backgroundColor: MyColors.accentsColors.withOpacity(0.8),
//     );
//     showDialog(context: context, builder: (context) => dialog,);
//   }
//   void _showAlertPopup5Transparent() {
//     AlertDialog dialog = new AlertDialog(
//       content: Container(
//         width: 450.0,
//         height: 320.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20,),
//             // Image(image: AssetImage(MyImages.check),
//             // color: MyColors.white,
//             // height: 110,),
//             // SizedBox(height: 40,),
//             Text("Hi Jerald,",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("Congratulations!",
//               style: MyStyles.robotoMedium26.copyWith( color: MyColors.white, fontWeight: FontWeight.w100),
//             ),
//             SizedBox(height: 20,),
//             Text("You have just activated your Gift Card successfully. Please click following link <URL link> to find easy steps to avail the benefit from your Gift Card. ",
//               style: MyStyles.robotoLight16.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40,),
//             Center(
//               child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//
//                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
//                   },
//                   child: _submitButton('Easy Benefit Process')),
//             ),
//             SizedBox(height: 15,),
//             Center(
//               child: Text("*Don’t miss any exciting chances to win more Benefit with My Ads",
//                 style: MyStyles.robotoLight10.copyWith( color: MyColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//       insetPadding: EdgeInsets.only(left:25.0,right: 25.0
//       ),
//       backgroundColor: MyColors.accentsColors.withOpacity(0.8),
//     );
//     showDialog(context: context, builder: (context) => dialog,);
//   }
// }
// Widget _submitButton(String buttonName) {
//   return Container(
//     width: 280.0,
//     height: 45.0,
//     padding: EdgeInsets.symmetric(vertical: 13),
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(5)),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//               color: Colors.blueAccent.withAlpha(100),
//               offset: Offset(2, 4),
//               blurRadius: 8,
//               spreadRadius: 1)
//         ],
//         color: MyColors.primaryColor),
//     child: Text(
//       buttonName,
//       style: MyStyles.robotoMedium14.copyWith(letterSpacing: 3.0, color: MyColors.white, fontWeight: FontWeight.w500),
//
//     ),
//   );
// }