import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/CheckMyCoupons.dart';
import 'package:myads_app/UI/Widgets/custom_textformfield.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/authenticationScreen/signUp/Demo/DemographicsScreen.dart';
import 'package:myads_app/UI/settings/settingsProvider.dart';
import 'package:myads_app/UI/streams/StreamingGoal.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/interests/getUserDetails.dart';
import 'package:myads_app/model/response/settings/updatePasswordResponse.dart';
import 'package:myads_app/model/response/settings/updatePlaybackResponse.dart';
import 'package:myads_app/model/response/settings/updateProfileResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';

import '../charts/BarChart.dart';
import '../dashboardScreen/DashBoard.dart';
import '../interest/Interest.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {
  String radioButtonItem = 'ONE';
  SettingsProvider _settingsProvider;
  BuildContext subcontext;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Group Value for Radio Button.
  int id;

  @override
  void initState() {
    super.initState();
    _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _settingsProvider.initialProvider();
    _settingsProvider.listener = this;
    _settingsProvider.performGetUserDetails();
  }

  String videoUrl;

  void _performSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performProfileUpdate();
    } else {
      _settingsProvider.setAutoValidate(true);
    }
  }

  void _performProfileUpdate() {
    _settingsProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _settingsProvider.performProfileUpdate();
  }

//update password
  void _performPasswordSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performPasswordUpdate();
    } else {
      _settingsProvider.setAutoValidate(true);
    }
  }

  void _performPasswordUpdate() {
    _settingsProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _settingsProvider.performPasswordUpdate();
  }

  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.UPDATE_PROFILE:
        UpdateProfileResponse _response = any as UpdateProfileResponse;
        if (_response.username.isNotEmpty) {
          // print("success");
          print("success ${_response.username}");
          CodeSnippet.instance.showMsg("Successfully Updated");
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.username);
        }
        break;
      case ResponseIds.UPDATE_PASSWORD:
        UpdatePasswordResponse _response = any as UpdatePasswordResponse;
        if (_response.error == "") {
          // print("success");
          print("success ${_response.success}");
          CodeSnippet.instance.showMsg(_response.success);
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.error);
        }
        break;
      case ResponseIds.UPDATE_PLAYBACK:
        UpdatePlayBackResponse _response = any as UpdatePlayBackResponse;
        if (_response.playbackOption != "") {
          // print("success");
          print("success ${_response.playbackOption}");
          CodeSnippet.instance.showMsg("Successfully Updated");
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.playbackOption);
        }
        break;
      case ResponseIds.GET_USER_DETAILS:
        GetUserDetailsResponse _response = any as GetUserDetailsResponse;
        if (_response.email != '') {
          setState(() {
            id = int.parse(_response.playbackOption);
          });
          print("success user details");
        } else {
          print('no data  user details');
        }
        break;
    }

  }

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
            Positioned(
              // To take AppBar Size only
              top: 10.0,
              left: 320.0,
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
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: MyColors.colorLight,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(''),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 26.0),
        //         child: Image.asset(MyImages.appBarLogo,height: 60,),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(top:8.0),
        //         child: _DividerPopMenu(),
        //       ),
        //     ],
        //   ),
        // ),
        appBar: _appBar(AppBar().preferredSize.height),
        body: SingleChildScrollView(
            child: Consumer<SettingsProvider>(builder: (context, provider, _) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: media.padding.top + 20,
                      bottom: media.padding.top + 20),
                  child: Center(
                    child: Text(
                      MyStrings.yourSettings,
                      style: MyStyles.robotoMedium28.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.accentsColors,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: InkWell(
                      onTap: () async {
                        await SharedPrefManager.instance
                            .setString("settingsInterestIntent", (1).toString())
                            .whenComplete(
                                () => print("SetInterestIntentToggler True"));
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new InterestScreen()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => InterestScreen()));
                      },
                      child: Container(
                        width: 330.0,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            MyStrings.updateInterest,
                            style: MyStyles.robotoMedium10.copyWith(
                                letterSpacing: 3.0,
                                color: MyColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: InkWell(
                      onTap: () async {
                        await SharedPrefManager.instance
                            .setString("settingsInterestIntent", (1).toString())
                            .whenComplete(
                                () => print("SetInterestIntentToggler True"));
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new StreamingGoals()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => StreamingGoals()));
                      },
                      child: Container(
                        width: 330.0,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            MyStrings.updateStreaming,
                            style: MyStyles.robotoMedium10.copyWith(
                                letterSpacing: 3.0,
                                color: MyColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // update password
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: _expansionTileButton(MyStrings.updatePassword),
                    children: <Widget>[
                      new Container(
                        child: CustomTextFormField(
                          labelText: MyStrings.oldPass,
                          controller: provider.oldController,
                          isPwdType: true,
                          validator: ValidateInput.validatePassword,
                          onSave: (value) {
                            provider.oldController.text = value;
                          },
                        ),
                      ),
                      new Container(
                        child: CustomTextFormField(
                          labelText: MyStrings.newPass,
                          controller: provider.newController,
                          isPwdType: true,
                          validator: ValidateInput.validatePassword,
                          onSave: (value) {
                            provider.newController.text = value;
                          },
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            _performPasswordSubmit();
                            // print(provider.usernameController.text);
                            // print(provider.passwordController.text);
                          },
                          child: _submitButton(MyStrings.saveNewPass)),
                      new SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => new MyCouponScreen()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MyCouponScreen()));
                      },
                      child: Container(
                        width: 330.0,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            MyStrings.checkMy,
                            style: MyStyles.robotoMedium10.copyWith(
                                letterSpacing: 3.0,
                                color: MyColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // update playback
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: _expansionTileButton(MyStrings.playBack),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = '1';
                                id = 1;
                                print(id);
                                provider.type = radioButtonItem;
                                _settingsProvider.listener = this;
                                _settingsProvider.performPlayBackUpdate();
                              });
                            },
                          ),
                          Text(
                            'SD Playback',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = '2';
                                id = 2;
                                print(id);
                                provider.type = radioButtonItem;
                                _settingsProvider.listener = this;
                                _settingsProvider.performPlayBackUpdate();
                              });
                            },
                          ),
                          Text(
                            'HD Playback',
                            style: new TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // update profile, TODO:Edits here
                ListTileTheme(
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    // childrenPadding: EdgeInsets.only(left: 28.0),
                    backgroundColor: MyColors.blueShade,
                    trailing: SizedBox(),
                    tilePadding: EdgeInsets.only(left: 40.0),
                    // title: _expansionTileButton(MyStrings.updatePassword),
                    title: InkWell(
                      onTap: () async {
                        await SharedPrefManager.instance
                            .setString("settingsIntent", (1).toString())
                            .whenComplete(() => print("SetIntentToggler True"));
                        Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                new DemographicsScreen()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => InterestScreen()));
                      },
                      child: Container(
                        width: 330.0,
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
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            MyStrings.updateProfiles,
                            style: MyStyles.robotoMedium10.copyWith(
                                letterSpacing: 3.0,
                                color: MyColors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 140.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new DashBoardScreen()));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DashBoardScreen()),
                    // );
                  },
                  child: _submitButton1(MyStrings.returnTo),
                ),
              ],
            ),
          );
        })),
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
}

Widget _submitButton(String buttonName) {
  return Container(
    width: 300.0,
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
    child: Align(
      alignment: Alignment.center,
      child: Text(
        buttonName,
        style: MyStyles.robotoMedium10.copyWith(
            letterSpacing: 3.0,
            color: MyColors.white,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget _expansionTileButton(String buttonName) {
  return Container(
    // width: 280.0,
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
    child: Align(
      alignment: Alignment.center,
      child: Text(
        buttonName,
        style: MyStyles.robotoMedium10.copyWith(
            letterSpacing: 3.0,
            color: MyColors.white,
            fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget _submitButton1(String buttonName) {
  return Container(
    width: 250.0,
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
      style: MyStyles.robotoMedium12.copyWith(
          letterSpacing: 3.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}
