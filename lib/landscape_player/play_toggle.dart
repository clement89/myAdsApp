import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/portraitScreen/watchPortraitProvider.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/balance/creditBalance.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';

class LandscapePlayToggle extends StatefulWidget {
   LandscapePlayToggle({Key key, this.VideoId, this.YetToWatch,this.flickManager,this.multiplyId,
     this.badgeId})
      : super(key: key);
  final String VideoId;
  final String YetToWatch;
  final FlickManager flickManager;
   final String multiplyId;
   final String badgeId;
  @override
  _LandscapePlayToggleState createState() => _LandscapePlayToggleState();
}

class _LandscapePlayToggleState extends BaseState<LandscapePlayToggle> {
  WatchPortraitProvider _watchPortraitProvider;
  @override
  void initState() {
    super.initState();
    _watchPortraitProvider =
        Provider.of<WatchPortraitProvider>(context, listen: false);
  }

  String balance;
  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.CREDIT_BALANCE:
        CreditBalance _response = any as CreditBalance;
        if (_response.insId.toString().isEmpty) {
          print("success");
          print("success ${_response.balance}");
          setState(() {
            balance = _response.balance.toString();
          });
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
    FlickControlManager controlManager =
        Provider.of<FlickControlManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);

    double size = 50;
    Color color = Colors.white;

    Widget playWidget = Icon(
      Icons.play_arrow,
      size: size,
      color: color,
    );
    Widget pauseWidget = Icon(
      Icons.pause,
      size: size,
      color: color,
    );
    Widget replayWidget = Icon(
      Icons.replay,
      size: size,
      color: color,
    );

    Widget child = videoManager.isVideoEnded
        ? replayWidget
        : videoManager.isPlaying
            ? pauseWidget
            : playWidget;

    return Consumer<WatchPortraitProvider>(builder: (context, provider, _) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: Color.fromRGBO(108, 165, 242, 0.5),
          onTap: () async {
            Duration position = videoManager.videoPlayerValue.position;
            String positionInSeconds = position != null
                ? (position - Duration(minutes: position.inMinutes))
                    .inSeconds
                    .toString()
                    .padLeft(2, '0')
                : null;
            String textPosition = position != null
                ? '${position.inMinutes}.$positionInSeconds'
                : '0.00';
            print(textPosition);
            if (videoManager.isVideoEnded) {
              //_watchPortraitProvider.listener = this;
              //await SharedPrefManager.instance.setString("performedUpdatebalance", "1");
              print("Call Update balance");
              _watchPortraitProvider.performUpdateBalance(
                  textPosition, widget.YetToWatch, widget.VideoId,widget.multiplyId,widget.badgeId);
              await SharedPrefManager.instance.setString("videoEnded", "1");
              controlManager.replay();
            } else if (videoManager.isPlaying) {
              controlManager.togglePlay();
              // total duration
              print("Playing the video");
              // current position
              _watchPortraitProvider.listener = this;

              _watchPortraitProvider.performUpdateBalance(
                  textPosition, widget.YetToWatch, widget.VideoId,widget.multiplyId,widget.badgeId);

              // return _showAlertPopup1Transparent();
            } else {
              controlManager.togglePlay();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: EdgeInsets.all(10),
            child: child,
          ),
        ),
      );
    });
  }

  void _showAlertPopup1Transparent() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        width: 450.0,
        height: 280.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20,),
            // Image(image: AssetImage(MyImages.check),
            // color: MyColors.white,
            // height: 110,),
            SizedBox(
              height: 30,
            ),
            Text(
              "Hi Jerald,",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Thanks for watching the AD, you just need to watch 20 mins more to get a Gift Card.",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAlertPopup2Transparent();
                  },
                  child: _submitButton('OK')),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "* You will be notified on mail, once you ‘are eligible for Gift",
                style: MyStyles.robotoLight10.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.only(left: 25.0, right: 25.0),
      backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  void _showAlertPopup2Transparent() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        width: 450.0,
        height: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            // Image(image: AssetImage(MyImages.check),
            // color: MyColors.white,
            // height: 110,),
            // SizedBox(height: 40,),
            Text(
              "Hi Jerald,",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Congratulations!",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Thanks for watching the AD, you are now Eligible to receive the Gift Card. Please click the button below to Get it Now.",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAlertPopup3Transparent();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                  },
                  child: _submitButton('Get Gift Card')),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "* You will be notified on mail, once your Gift Card gets approved",
                style: MyStyles.robotoLight10.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.only(left: 25.0, right: 25.0),
      backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  void _showAlertPopup3Transparent() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        width: 450.0,
        height: 320.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            // Image(image: AssetImage(MyImages.check),
            // color: MyColors.white,
            // height: 110,),
            // SizedBox(height: 40,),
            Text(
              "Hi Jerald,",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Congratulations!",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Gift Card request has been raised\nsuccessfully.\nRequest ID: XXXXXXXXXX\nGenerated on : DD-MMM-2021",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAlertPopup4Transparent();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                  },
                  child: _submitButton('OK')),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "* You will be notified on Email, once your request gets approved.",
                style: MyStyles.robotoLight10.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.only(left: 25.0, right: 25.0),
      backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  void _showAlertPopup4Transparent() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        width: 450.0,
        height: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            // Image(image: AssetImage(MyImages.check),
            // color: MyColors.white,
            // height: 110,),
            // SizedBox(height: 40,),
            Text(
              "Hi Jerald,",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Congratulations!",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Gift Card has been dispatched to your registered Email ID. Please go the following URL <url link> and use the activation code: XXXX to use your Gift Card.",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Gift Card ID is XXXXXXXXXXXXXX.",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _showAlertPopup5Transparent();
                  },
                  child: _submitButton('OK')),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "*Your need to watch 208 mins, to avail more Exciting Gifts.",
                style: MyStyles.robotoLight10.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.only(left: 25.0, right: 25.0),
      backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }

  void _showAlertPopup5Transparent() {
    AlertDialog dialog = new AlertDialog(
      content: Container(
        width: 450.0,
        height: 320.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            // Image(image: AssetImage(MyImages.check),
            // color: MyColors.white,
            // height: 110,),
            // SizedBox(height: 40,),
            Text(
              "Hi Jerald,",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Congratulations!",
              style: MyStyles.robotoMedium26
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You have just activated your Gift Card successfully. Please click following link <URL link> to find easy steps to avail the benefit from your Gift Card. ",
              style: MyStyles.robotoLight16
                  .copyWith(color: MyColors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();

                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                  },
                  child: _submitButton('Easy Benefit Process')),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "*Don’t miss any exciting chances to win more Benefit with My Ads",
                style: MyStyles.robotoLight10.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      insetPadding: EdgeInsets.only(left: 25.0, right: 25.0),
      backgroundColor: MyColors.accentsColors.withOpacity(0.8),
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
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
