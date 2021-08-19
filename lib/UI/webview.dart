import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:webview_flutter/webview_flutter.dart' as _widget;

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({Key key, this.title, @required this.url})
      : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  _appBar(height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, 80 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Center(
            child: Text("",),),
          color: MyColors.colorLight,
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 10.0,
          left: 20.0,
          right: 20.0,
          child: Image.asset(MyImages.appBarLogo,height: 60,),
        ),


      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.colorLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Image.asset(MyImages.appBarLogo,height: 60,),
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: MyColors.colorLight,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          _widget.WebView(
            initialUrl: widget.url,
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
            javascriptMode: _widget.JavascriptMode.unrestricted,
          ),
          // if (isLoading) kLoadingWidget(context),
        ],
      ),
    );
  }
}
