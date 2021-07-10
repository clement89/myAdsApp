// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:myads_app/Constants/response_ids.dart';
// import 'package:myads_app/UI/dashboardScreen/dashboardProvider.dart';
// import 'package:myads_app/UI/dashboardScreen/videoPlayer.dart';
// import 'package:myads_app/UI/portraitScreen/watchPortraitScreen.dart';
// import 'package:myads_app/base/base_state.dart';
// import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
// import 'package:myads_app/utils/code_snippet.dart';
// import 'package:provider/provider.dart';
//
// class PrefetchImageDemo extends StatefulWidget {
//   VideoResponse local;
//   PrefetchImageDemo(this.local);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PrefetchImageDemoState();
//   }
// }
//
// class _PrefetchImageDemoState extends BaseState<PrefetchImageDemo> {
//   List<VideoResponse> videoResponseList = new List<VideoResponse>();
//   List<String> images = [];
//   CarouselController buttonCarouselController = CarouselController();
//   DashboardProvider _dashboardProvider;
//   String imageUrl, videoUrl, watchTime = '0.0';
//   String daysLeft = '0.0', Videoid, per, producturl;
//
//   @override
//   void initState() {
//     videoResponseList.add(widget.local);
//     print("PrefetchDemo");
//     print(videoResponseList);
//     images.add(widget.local.videoImage);
//     images.add(((widget.local.nextVideos)[0]).videoImage);
//     _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
//     _dashboardProvider.listener = this;
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   images.forEach((imageUrl) {
//     //     precacheImage(NetworkImage(imageUrl), context);
//     //   });
//     // });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> imageSliders = images.map((item) => Container(
//       child: Container(
//         margin: EdgeInsets.all(5.0),
//         child: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//             child: Stack(
//               children: <Widget>[
//                 Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     width: 50,
//                     height: 70,
//                     color: Color.fromRGBO(112, 174, 222, 90),
//                     child: IconButton(
//                       icon: Icon(
//                         CupertinoIcons.chevron_compact_right,
//                         size: 50,
//                         color: Colors.white,
//                       ),
//                       onPressed: () async {
//
//                         buttonCarouselController.nextPage();
//                         // _dashboardProvider.performGetVideos(
//                         //     ((videoResponseList[index].nextVideos)[0]).videoId);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             )
//         ),
//       ),
//     )).toList();
//     return  CarouselSlider(
//       items: imageSliders,
//       options: CarouselOptions(enlargeCenterPage: true, height: 200),
//       carouselController: buttonCarouselController,
//     );
//     //   Container(
//     //     child: CarouselSlider.builder(
//     //   itemCount: videoResponseList.length,
//     //   carouselController: buttonCarouselController,
//     //   options: CarouselOptions(
//     //     enableInfiniteScroll: false,
//     //     enlargeCenterPage: true,
//     //     autoPlay: false,
//     //   ),
//     //   itemBuilder: (context, index, realIdx) {
//     //     return Stack(
//     //       children: [
//     //         Container(
//     //           child: GestureDetector(
//     //               child: DashboardVideo(
//     //                 videoUrl: videoResponseList[index].videoLink,
//     //                 id: videoResponseList[index].videoId,
//     //                 watchTime: getYetToWatchTime(
//     //                     videoResponseList[index].toWatchtime,
//     //                     videoResponseList[index].watchedtime),
//     //                 productUrl: videoResponseList[index].productURL,
//     //               ),
//     //               onTap: () {
//     //                 print("prefetchimageDemo " + watchTime.toString());
//     //                 Navigator.of(context).push(PageRouteBuilder(
//     //                     pageBuilder: (_, __, ___) => new WatchPortrait(
//     //                         videoUrl: videoResponseList[index].videoLink,
//     //                         VideoId: videoResponseList[index].videoId,
//     //                         watchtime: getYetToWatchTime(
//     //                             videoResponseList[index].toWatchtime,
//     //                             videoResponseList[index].watchedtime),
//     //                         productUrl: videoResponseList[index].productURL)));
//     //               }),
//     //         ),
//     //         Align(
//     //           alignment: Alignment.centerRight,
//     //           child: Container(
//     //             width: 50,
//     //             height: 70,
//     //             color: Color.fromRGBO(112, 174, 222, 90),
//     //             child: IconButton(
//     //               icon: Icon(
//     //                 CupertinoIcons.chevron_compact_right,
//     //                 size: 50,
//     //                 color: Colors.white,
//     //               ),
//     //               onPressed: () async {
//     //                 _dashboardProvider.performGetVideos(
//     //                     ((videoResponseList[index].nextVideos)[0]).videoId);
//     //               },
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     );
//     //   },
//     // ));
//   }
//
//   void onSuccess(any, {int reqId}) {
//     super.onSuccess(any);
//     print("in on sucess For Next Video pull");
//     switch (reqId) {
//       case ResponseIds.GET_VIDEO:
//         VideoResponse _response = any as VideoResponse;
//         print("ResponseDAWINnextImage getter" + _response.toString());
//         if (_response.userId.isNotEmpty) {
//           print("success ${_response.videoLink}");
//           setState(() {
//             if ((!(videoResponseList.contains(_response))) &&
//                 (!(images.contains((_response.nextVideos)[0].videoImage)))) {
//               videoResponseList.add(_response);
//               images.add((_response.nextVideos)[0].videoImage);
//               String s1 = _response.watchedtime;
//               String s2 = _response.toWatchtime;
//               var format = DateFormat("HH:mm:ss");
//               var one = format.parse(s2);
//               var two = format.parse(s1);
//               print(one.toString() +
//                   "In videoGetter " +
//                   one.difference(two).toString());
//               videoUrl = _response.videoLink;
//               watchTime = one.difference(two).toString().substring(0, 7);
//               Videoid = _response.videoId;
//               producturl = _response.productURL;
//               buttonCarouselController.nextPage(
//                   duration: Duration(milliseconds: 300), curve: Curves.linear);
//             }
//           });
//
//           // print("Signup res username ${SharedPrefManager.instance.getString(Constants.userName)}");
//         } else {
//           print("failure");
//           CodeSnippet.instance.showMsg(_response.userId);
//         }
//         break;
//     }
//   }
//
//   getYetToWatchTime(String toWatchtime, String watchedtime) {
//     var format = DateFormat("HH:mm:ss");
//     var one = format.parse(toWatchtime);
//     var two = format.parse(watchedtime);
//     print(one.toString() + "In videoGetter " + one.difference(two).toString());
//     watchTime = one.difference(two).toString().substring(0, 7);
//     return watchTime;
//   }
//   //getCurrentVideoParams
// }
