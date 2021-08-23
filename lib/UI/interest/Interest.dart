import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/UI/streams/StreamingGoal.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/interests/getInterestsResponse.dart';
import 'package:myads_app/model/response/interests/updateInterestResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CheckMyCoupons.dart';
import '../charts/BarChart.dart';
import '../settings/SettingScreen.dart';
import 'interestProvider.dart';

class InterestScreen extends StatefulWidget {
  @override
  _InterestScreenState createState() => _InterestScreenState();
}

class _InterestScreenState extends BaseState<InterestScreen> {
  InterestProvider _interestProvider;

  List<Interests> interestList = <Interests>[];
  BuildContext subcontext;
  SharedPreferences sharedPrefs;
  List _selecteCategorys = List();
  int isfirstOf = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    _interestProvider = Provider.of<InterestProvider>(context, listen: false);
    _interestProvider.listener = this;
    _interestProvider.performGetInterest();
    isfirstOf = 1;
    super.initState();

    SharedPrefManager.instance
        .setString('signUp_staging', 'InterestScreen'); //cjc staging..
  }

  int c = 0;
  String statusVar = '1';
  @override
  Future<void> onSuccess(any, {int reqId}) async {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.GET_INTEREST:
        GetInterestsResponse _response = any as GetInterestsResponse;
        if (_response.interests.isNotEmpty) {
          // print("success ${_response.interests}");
          setState(() {
            _interestProvider.setInterestList(_response.interests);
            for (var i in _interestProvider.getInterestList) {
              print(_selecteCategorys);
              if (_interestProvider.getInterestList[c].ischecked == true) {
                _selecteCategorys
                    .add(_interestProvider.getInterestList[c].value.toString());
              }
              interestList.add(_interestProvider.getInterestList[c]);
              c++;
            }
          });
        } else {
          print("failure");
          CodeSnippet.instance.showMsg("Failed");
        }
        break;
      case ResponseIds.UPDATE_INTEREST:
        UpdateInterestResponse _response = any as UpdateInterestResponse;
        if (_response.intrests.isNotEmpty) {
          String SettingsIntent =
              await sharedPrefs.getString("settingsInterestIntent");
          if ((SettingsIntent != null) && (int.parse(SettingsIntent) != 0)) {
            await SharedPrefManager.instance
                .setString("settingsInterestIntent", (0).toString());
            print("success");
            Fluttertoast.showToast(
                msg: "Updated Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: MyColors.primaryColor,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new SettingScreen()));
          } else {
            if(statusVar == "1"){
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new StreamingGoals()));
            }else{
              SystemNavigator.pop();
            }

          }
          SharedPrefManager.instance
              .setString('signUp_staging', 'completed'); //
        } else {
          print("failure");
          CodeSnippet.instance.showMsg("Failed");
        }
        break;
    }
  }

  // ignore: deprecated_member_use

  void _onCategorySelected(bool selected, category_name) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_name);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_name);
      });
    }
  }
  String finalSTr = "";
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
            // Positioned(    // To take AppBar Size only
            //   top: 10.0,
            //   left:320.0,
            //   right: 20.0,
            //   child: _DividerPopMenu(),
            // )
          ],
        ),
      );
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to save this to draft'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                // Navigator.of(context).pop(false);
                SystemNavigator.pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                statusVar = "2";
                _interestProvider.listener = this;
                _interestProvider.performUpdateInterest(finalSTr,statusVar);
                // Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    ) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.white,
          appBar: _appBar(AppBar().preferredSize.height),
          body: SingleChildScrollView(
            child: Consumer<InterestProvider>(builder: (context, provider, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        MyStrings.okWeAre,
                        style: MyStyles.robotoLight28.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        MyStrings.whatSort,
                        style: MyStyles.robotoLight28.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.accentsColors,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        MyStrings.youLike,
                        style: MyStyles.robotoLight28.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.accentsColors,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 221 * ((interestList.length) / 2.1),
                    child: GridView.builder(
                        itemCount: interestList.length,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(1.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Image(
                                image: NetworkImage(interestList[index].image),
                                height: 120,
                              ),
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                value: _selecteCategorys
                                    .contains(interestList[index].value),
                                onChanged: (bool selected) {
                                  _onCategorySelected(
                                      selected, interestList[index].value);
                                  print(
                                      "ISNULl here" + _selecteCategorys.toString());
                                },
                                title: Container(
                                  width: 160,
                                  child: Text(
                                    interestList[index].value,
                                    style: MyStyles.robotoLight16.copyWith(
                                        letterSpacing: Dimens.letterSpacing_14,
                                        color: MyColors.accentsColors,
                                        fontWeight: FontWeight.w100),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  InkWell(
                      onTap: () {

                        print(_selecteCategorys.length);
                        if (_selecteCategorys.length != 0) {
                          for (var Str in _selecteCategorys) {
                            finalSTr += Str + ",";
                          }
                          print(finalSTr.substring(0, finalSTr.length - 1));
                          _interestProvider.listener = this;
                          _interestProvider.performUpdateInterest(finalSTr,'1');
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Select Minimum 1 Interest",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: _submitButton(MyStrings.thatSMe)),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new DashBoardScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dashboard                  ',
                        style: MyStyles.robotoMedium16.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.black,
                            fontWeight: FontWeight.w100),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.darkGray,
                      )
                    ],
                  ),
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
                        .clearAll()
                        .whenComplete(() => print("All set to null"));

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

  int i = 0;
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 170.0,
    height: 40.0,
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
