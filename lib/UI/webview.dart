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
              child: Image.asset(MyImages.appBarLogo),
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
