import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/charts/BarChart.dart';
import 'package:myads_app/UI/CheckMyCoupons.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/UI/settings/SettingScreen.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:myads_app/UI/activity/activityScreen.dart';

class GiftCardPage extends StatefulWidget {
  @override
  _GiftCardPageState createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  BuildContext subcontext;

  _appBar(height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height+20 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Center(
            child: Text("",),),
          color: MyColors.colorLight,
          height: height+40,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 50.0,
          left: 20.0,
          right: 20.0,
          child: Image.asset(MyImages.appBarLogo,height: 60,),
        ),
        Positioned(    // To take AppBar Size only
          top: 40.0,
          left:320.0,
          right: 20.0,
          child: _DividerPopMenu(),
        )

      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Center(
                  child: Text(MyStrings.giftCard,
                    style: MyStyles.robotoMedium22.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              SizedBox(height: 5.0,),
              Center(
                child: Text(MyStrings.requestTransaction,
                  style: MyStyles.robotoMedium22.copyWith(letterSpacing: 1.0, color: MyColors.accentsColors, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(height:40.0,),
              Divider(
                height: 10.0,
                color: MyColors.accentsColors,
                thickness: 2.0,
              ),
              MyHomePage()
            ],
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
  //         subcontext=context;
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
  //                 onTap: () async {await SharedPrefManager.instance.clearAll().whenComplete(() => print("All set to null"));
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
  //         }
  //         else if (value == 'value05') {
  //           await SharedPrefManager.instance
  //               .clearAll()
  //               .whenComplete(
  //                   () => print("All set to null"));
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
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int height = 450;
  double value = 5.0;
  String _lowerValue,_upperValue;
  int valueHolder = 20;
  var _controller = PageController();
  double _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page;
      });
    });
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text("Mar' 2021",
                  style: MyStyles.robotoLight14.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 15),
              leading:   FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:4.0),
                          child: Text(
                            height.toString(),
                            style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: StepProgressIndicator(
                            totalSteps: 500,
                            currentStep: 450,
                            size: 6,
                            padding: 0,
                            selectedColor: MyColors.accentsColors,
                            unselectedColor: MyColors.Gray,
                            roundedEdges: Radius.circular(10),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:4.0),
                          child: Text(
                            "500",
                            style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("15 %",
                          style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),

                        ),
                        Icon(Icons.star,color: MyColors.accentsColors
                          ,size: 20 ,)
                      ],

                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("625",
                          style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.thumb_up,color: MyColors.accentsColors,size: 20,)
                      ],

                    ),
                    SizedBox(width: 15),
                    Container(
                        height: 45,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: MyColors.accentsColors,
                        ),
                        child: Center(child: new  FaIcon(FontAwesomeIcons.eye,size: 15,color: MyColors.white,)),

                    ),
                    SizedBox(width: 10,),
                    Container(
                        height: 45,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: MyColors.boxGreen,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:9.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: new  FaIcon(FontAwesomeIcons.gift,size: 15,color: MyColors.white,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:3.0),
                                    child: Text("Generated",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w200),),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                right: 3.0,
                                top: 2.0,
                                child: FaIcon(FontAwesomeIcons.checkDouble,size: 10,color: MyColors.white,)),
                          ],
                        )
                    ),
                  ],
                ),
              ),

              ),
            ],
          ),
          Divider(thickness: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text("Feb' 2021",
                  style: MyStyles.robotoLight14.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 15),
                leading:   FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:4.0),
                            child: Text(
                              height.toString(),
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: StepProgressIndicator(
                              totalSteps: 500,
                              currentStep: 450,
                              size: 6,
                              padding: 0,
                              selectedColor: MyColors.accentsColors,
                              unselectedColor: MyColors.Gray,
                              roundedEdges: Radius.circular(10),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: Text(
                              "500",
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("15 %",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),

                          ),
                          Icon(Icons.star,color: MyColors.accentsColors
                            ,size: 20 ,)
                        ],

                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("625",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.thumb_up,color: MyColors.accentsColors,size: 20,)
                        ],

                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 45,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: MyColors.accentsColors,
                        ),
                        child: Center(child:

                        GestureDetector(
                          onTap: (){

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top:9.0),
                            child: Column(
                              children: [
                                new  FaIcon(FontAwesomeIcons.eye,size: 15,color: MyColors.white,),
                                Padding(
                                  padding: const EdgeInsets.only(top:3.0),
                                  child: Text("In-Progress",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ),

                      ),
                      SizedBox(width: 10,),
                      Container(
                          height: 45,
                          width: 50,
                          decoration: new BoxDecoration(
                            color: MyColors.yellow,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:9.0),
                                child: Column(
                                  children: [
                                    Center(
                                      child: new  FaIcon(FontAwesomeIcons.gift,size: 15,color: MyColors.white,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:3.0),
                                      child: Text("Applied",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w200),),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 3.0,
                                  top: 2.0,
                                  child: FaIcon(FontAwesomeIcons.check,size: 10,color: MyColors.white,)),
                            ],
                          )
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
          Divider(thickness: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text("Jan' 2021",
                  style: MyStyles.robotoLight14.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 15),
                leading:   FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:4.0),
                            child: Text(
                              height.toString(),
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: StepProgressIndicator(
                              totalSteps: 500,
                              currentStep: 450,
                              size: 6,
                              padding: 0,
                              selectedColor: MyColors.accentsColors,
                              unselectedColor: MyColors.Gray,
                              roundedEdges: Radius.circular(10),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: Text(
                              "500",
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("15 %",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),

                          ),
                          Icon(Icons.star,color: MyColors.accentsColors
                            ,size: 20 ,)
                        ],

                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("625",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.thumb_up,color: MyColors.accentsColors,size: 20,)
                        ],

                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 45,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: MyColors.accentsColors,
                        ),
                        child: Center(child:

                        Padding(
                          padding: const EdgeInsets.only(top:9.0),
                          child: Column(
                            children: [
                              new  FaIcon(FontAwesomeIcons.eye,size: 15,color: MyColors.white,),
                              Padding(
                                padding: const EdgeInsets.only(top:3.0),
                                child: Text("ELigible",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w400),),
                              ),
                            ],
                          ),
                        ),
                        ),

                      ),
                      SizedBox(width: 10,),
                      Container(
                          height: 45,
                          width: 50,
                          decoration: new BoxDecoration(
                            color: MyColors.boxOrange,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:9.0),
                            child: Column(
                              children: [
                                Center(
                                  child: new  FaIcon(FontAwesomeIcons.gift,size: 15,color: MyColors.white,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:3.0),
                                  child: Text("Apply",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w200),),
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
          Divider(thickness: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15.0),
                child: Text("Dec' 2021",
                  style: MyStyles.robotoLight14.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 15),
                leading:   FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:4.0),
                            child: Text(
                              height.toString(),
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: StepProgressIndicator(
                              totalSteps: 500,
                              currentStep: 450,
                              size: 6,
                              padding: 0,
                              selectedColor: MyColors.accentsColors,
                              unselectedColor: MyColors.Gray,
                              roundedEdges: Radius.circular(10),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: Text(
                              "500",
                              style: MyStyles.robotoLight10.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("15 %",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),

                          ),
                          Icon(Icons.star,color: MyColors.accentsColors
                            ,size: 20 ,)
                        ],

                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("625",
                            style: MyStyles.robotoLight16.copyWith( color: MyColors.textColor1b1c20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.thumb_up,color: MyColors.accentsColors,size: 20,)
                        ],

                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 45,
                        width: 50,
                        decoration: new BoxDecoration(
                          color: MyColors.accentsColors,
                        ),
                        child: Center(child:

                        Padding(
                          padding: const EdgeInsets.only(top:9.0),
                          child: Column(
                            children: [
                              new  FaIcon(FontAwesomeIcons.eye,size: 15,color: MyColors.white,),
                              Padding(
                                padding: const EdgeInsets.only(top:3.0),
                                child: Text("N/A",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w400),),
                              ),
                            ],
                          ),
                        ),
                        ),

                      ),
                      SizedBox(width: 10,),
                      Container(
                          height: 45,
                          width: 50,
                          decoration: new BoxDecoration(
                            color: MyColors.Gray,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:9.0),
                            child: Column(
                              children: [
                                Center(
                                  child: new  FaIcon(FontAwesomeIcons.gift,size: 15,color: MyColors.white,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:3.0),
                                  child: Text("N/A",style: MyStyles.robotoMedium8.copyWith(color: MyColors.white, fontWeight: FontWeight.w200),),
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),

              ),
            ],
          ),
          Divider(thickness: 2),
          SizedBox(height: 50.0,),
          Center(
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                },
                child: _submitButton('RETURN TO SETTINGS')),
          ),
        ],
      ),
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
      style: MyStyles.robotoMedium14.copyWith(letterSpacing: 3.0, color: MyColors.white, fontWeight: FontWeight.w500),

    ),
  );
}

