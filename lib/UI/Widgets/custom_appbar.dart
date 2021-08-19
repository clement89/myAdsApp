import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/styles.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          title: Text(
            "Uth Store",
            style: MyStyles.robotoBold18.copyWith(
                letterSpacing: 1.0,
                color: MyColors.white,
                fontWeight: FontWeight.w100),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Stack(
                children: <Widget>[
                  Image.asset(MyImages.appBarLogo,height: 60,),

                ],
              ),
            ),
          ],
          // flexibleSpace: FlexibleSpaceBar(
          //   titlePadding: EdgeInsets.only(top: 90),
          //   title: Container(
          //     height: height / 11.3,
          //     width: MediaQuery.of(context).size.width,
          //     color: MyColors.primaryColor,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(4.0),
          //         color: Colors.white,
          //       ),
          //       margin: EdgeInsets.all(12.0),
          //       width: MediaQuery.of(context).size.width,
          //
          //     ),
          //   ),
          // ),
        ));
  }}

