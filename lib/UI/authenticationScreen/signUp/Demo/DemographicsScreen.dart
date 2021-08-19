import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:menu_button/menu_button.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/Widgets/custom_textformfield.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/charts/BarChart.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/authentication/demographics_response.dart';
import 'package:myads_app/model/response/authentication/signup2Response.dart';
import 'package:myads_app/model/response/interests/getUserDetails.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../CheckMyCoupons.dart';
import '../../../interest/Interest.dart';
import '../../../settings/SettingScreen.dart';
import 'DemographicsProvider.dart';

class DemographicsScreen extends StatefulWidget {
  @override
  _DemographicsScreenState createState() => _DemographicsScreenState();
}

class _DemographicsScreenState extends BaseState<DemographicsScreen> {
  bool isChecked = true;

  String radioButtonItem = 'Female';
  int id = 1;
  CountryList _chosenValue;
  SharedPreferences sharedPrefs;
  DemographicsProvider _demographicsProvider;
  BuildContext subcontext;
  int pin = 0;
  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      // Put your code here which you want to execute on CheckBox Checked event.
      setState(() {
        isChecked = true;
      });
    } else {
      // Put your code here which you want to execute on CheckBox Un-Checked event.
      setState(() {
        isChecked = false;
      });
    }
  }

  Widget _checkboxDemo(String title, covariant) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            toggleCheckbox(value);
          },
          activeColor: MyColors.accentsColors,
          checkColor: Colors.white,
          tristate: false,
        ),
        Text(
          title,
          style: MyStyles.robotoMedium24.copyWith(
              letterSpacing: Dimens.letterSpacing_14,
              color: MyColors.accentsColors,
              fontWeight: FontWeight.w100),
        ),
      ],
    );
  }

  List<String> _checked = [];
  List<String> _ichecked = [];
  List<String> _ageList = [];
  List<String> _incomeList = [];
  List _countryList = [];

  String selectedKey = '';
  String initialValue, EmailID, MobileNum;

  List<CountryList> keys = [];

  List<String> country = [];
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
            //             pageBuilder: (_, __, ___) => ActivityScreen()));
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
                )),
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String SettingsIntent;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });

    _demographicsProvider =
        Provider.of<DemographicsProvider>(context, listen: false);
    _demographicsProvider.listener = this;
    _demographicsProvider.performDemoGraphics();
    _demographicsProvider.initialProvider();
    initialValue = "Select Country";
    selectedKey = "Select Country";
    _demographicsProvider.performGetUserDetails();
    SharedPrefManager.instance
        .setString('signUp_staging', 'DemographicsScreen'); //cj
    super.initState();
  }

  // initSfData() async {
  //   SettingsIntent = await sharedPrefs.getString("settingsIntent");
  //   if ((SettingsIntent != null) && (int.parse(SettingsIntent) != 0)){
  //     SharedPrefManager.instance
  //         .setString('signUp_staging', 'completed');
  //   }else{
  //     SharedPrefManager.instance
  //         .setString('signUp_staging', 'DemographicsScreen'); //cjc staging..
  //   }
  // }
  void _performSubmit() {
    print('submitting...');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("DemographicsScreen.dart:PerformSubmit");
      _performSignup2();
    } else {
      _demographicsProvider.setAutoValidate(true);
    }
  }

  void _performSignup2() {
    print("DemographicsScreen.dart:PerformSignup2");
    _demographicsProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _demographicsProvider.performSignUp2();
  }

  int c = 0, d = 0, e = 0;
  @override
  Future<void> onSuccess(any, {int reqId}) async {
    print('reached on success..');

    ProgressBar.instance.hideProgressBar();
    String SettingsIntent = await sharedPrefs.getString("settingsIntent");
    print("Demographics Success $SettingsIntent");
    super.onSuccess(any);
    switch (reqId) {
      case ResponseIds.DEMO_SCREEN:
        DemoGraphicsResponse _response = any as DemoGraphicsResponse;
        if (_response.interests.isNotEmpty) {
          // print("success ${_response.interests}");
          setState(() {
            _demographicsProvider.setAgeList(_response.ageGroups);
            _demographicsProvider.setIncomeList(_response.incomeGroups);
            _demographicsProvider.setCountryList(_response.countryList);

            for (var i in _demographicsProvider.getAgeList) {
              _ageList.add(_demographicsProvider.getAgeList[c].value);
              c++;
            }

            for (var i in _demographicsProvider.getIncomeList) {
              _incomeList.add(_demographicsProvider.getIncomeList[d].value);
              d++;
            }

            for (var i in _demographicsProvider.getCountryList) {
              _countryList.add(_demographicsProvider.getCountryList[e]);
              e++;
            }
          });
        } else {
          print("failure:Getting ResponseIds.DEMO_SCREEN:");
          CodeSnippet.instance.showMsg("Failed");
        }
        break;
      case ResponseIds.SIGN_UP2:
        SignUp2Response _response = any as SignUp2Response;
        if (_response.mobile != null) {
          await SharedPrefManager.instance
              .setString(Constants.userEmail, _response.email);
          await SharedPrefManager.instance
              .setString(Constants.firstName, _response.name);
          await SharedPrefManager.instance
              .setString(Constants.lastName, _response.lastName);
          if ((SettingsIntent != null) && (int.parse(SettingsIntent) != 0)) {
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
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new InterestScreen()));
          }
          // print("success ${_response.interests}");
          SharedPrefManager.instance.setString('signUp_staging', 'completed');
        } else {
          print("failure:getting ResponseIds.SIGN_UP2:");
          CodeSnippet.instance.showMsg("Failed");
        }
        break;
      case ResponseIds.GET_USER_DETAILS:
        GetUserDetailsResponse _response = any as GetUserDetailsResponse;
        if (_response.name != '') {
          setState(() {
            _demographicsProvider.setUserData(_response);
            _checked.add(_response.ageGroup);
            if (_response.incomeGroup.isNotEmpty) {
              _ichecked.add(_response.incomeGroup);
            }
            id = int.parse(_response.gender);
            selectedKey = _response.country;
            _demographicsProvider.selectedCountry = selectedKey;
            print("selected key $selectedKey");
          });
          print("success");
        } else {
          print('no data');
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
            // Positioned(    // To take AppBar Size only
            //   top: 10.0,
            //   left:320.0,
            //   right: 20.0,
            //   child: _DividerPopMenu(),
            // )
          ],
        ),
      );
//keytool -genkey -v -keystore D:\key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
  @override
  Widget build(BuildContext context) {
    final Widget childButtonWithoutSameItem = Container(
      padding: const EdgeInsets.only(left: 16, right: 11),
      height: 50.0,
      width: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.accentsColors),
        color: MyColors.blueShade,
        borderRadius: const BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              selectedKey,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 12,
            height: 17,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
    int _value = 42;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: SingleChildScrollView(
          child: Consumer<DemographicsProvider>(builder: (context, provider, _) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        MyStrings.tellUs,
                        style: MyStyles.robotoLight29.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      MyStrings.theBasic,
                      style: MyStyles.robotoLight22.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.accentsColors,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    color: MyColors.accentsColors,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextFormField(
                    labelText: 'First Name',
                    controller: provider.firstnameController,
                    validator: ValidateInput.validateName,
                    onSave: (value) {
                      provider.firstnameController.text = value;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Last Name',
                    controller: provider.lastnameController,
                    validator: ValidateInput.validateName,
                    onSave: (value) {
                      provider.lastnameController.text = value;
                    },
                  ),
                  CustomTextFormField(
                    isEnabled: false,
                    labelText: 'Email',
                    controller: provider.emailController,
                    validator: ValidateInput.validateEmail,
                    onSave: (value) {
                      provider.emailController.text = EmailID;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Phone Number',
                    controller: provider.mobileController,
                    validator: ValidateInput.validateMobile,
                    onSave: (value) {
                      provider.mobileController.text = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text(
                        MyStrings.littleHelp,
                        style: MyStyles.robotoLight24.copyWith(
                            letterSpacing: 1.0,
                            color: MyColors.accentsColors,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Divider(
                      height: 5.0,
                      color: MyColors.accentsColors,
                      thickness: 1.3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 250, top: 20.0),
                    child: Text(
                      'Gender',
                      style: MyStyles.robotoMedium18.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryLightColor,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Male';
                              id = 1;
                              print(id);
                              provider.type = radioButtonItem;
                            });
                          },
                        ),
                        Text(
                          'Male',
                          style: MyStyles.robotoLight24.copyWith(
                              letterSpacing: Dimens.letterSpacing_14,
                              color: MyColors.accentsColors,
                              fontWeight: FontWeight.w100),
                        ),
                        Radio(
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Female';
                              id = 2;
                              print(id);
                              provider.type = radioButtonItem;
                            });
                          },
                        ),
                        Text(
                          'Female',
                          style: MyStyles.robotoLight24.copyWith(
                              letterSpacing: Dimens.letterSpacing_14,
                              color: MyColors.accentsColors,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 220, top: 20.0),
                    child: Text(
                      'Age Group',
                      style: MyStyles.robotoMedium18.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryLightColor,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 10.0),
                    child: CheckboxGroup(
                      labels: _ageList,
                      checked: _checked,
                      labelStyle: MyStyles.robotoLight24.copyWith(
                          letterSpacing: Dimens.letterSpacing_14,
                          color: MyColors.accentsColors,
                          fontWeight: FontWeight.w100),
                      onChange: (bool isChecked, String label, int index) =>
                          provider.agroup = label,
                      onSelected: (List selected) => setState(() {
                        if (selected.length > 1) {
                          selected.removeAt(0);
                          print('selected length  ${selected.length}');
                        } else {
                          print("only one $_checked");
                        }
                        _checked = selected;
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, top: 20.0),
                    child: Text(
                      'Income in the last 12 months',
                      style: MyStyles.robotoMedium18.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.primaryLightColor,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 20.0, bottom: 20),
                    child: CheckboxGroup(
                      labels: _incomeList,
                      checked: _ichecked,
                      labelStyle: MyStyles.robotoLight24.copyWith(
                          letterSpacing: Dimens.letterSpacing_14,
                          color: MyColors.accentsColors,
                          fontWeight: FontWeight.w100),
                      onChange: (bool isChecked, String label, int index) =>
                          // print("isChecked: $isChecked   label: $label  index: $index"),
                          provider.igroup = label,
                      onSelected: (List selected) => setState(() {
                        if (selected.length > 1) {
                          selected.removeAt(0);
                          print('selected length  ${selected.length}');
                        } else {
                          print("only one");
                        }
                        _ichecked = selected;
                      }),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Country',
                          style: MyStyles.robotoMedium16.copyWith(
                              letterSpacing: Dimens.letterSpacing_14,
                              color: MyColors.primaryLightColor,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                      _demographicsProvider.getCountryList != null
                          ? MenuButton<CountryList>(
                              child: childButtonWithoutSameItem,
                              items: _demographicsProvider.getCountryList != null
                                  ? _demographicsProvider.getCountryList
                                      .map((map) {
                                      // FocusScope.of(context).unfocus();
                                      // Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
                                      return map;
                                    }).toList()
                                  : keys,
                              // label: Text('Select Country'),
                              topDivider: true,
                              showSelectedItemOnList: true, //cjc country
                              selectedItem:
                                  _demographicsProvider.getCountryList.first,
                              itemBackgroundColor: MyColors.blueShade,
                              edgeMargin: 5.0,
                              itemBuilder: (CountryList value) => Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16),
                                child: Text(value.value),
                              ),
                              toggledChild: Container(
                                child: childButtonWithoutSameItem,
                              ),
                              divider: Container(
                                height: 1,
                                color: MyColors.accentsColors,
                              ),
                              onItemSelected: (CountryList value) {
                                setState(() {
                                  selectedKey = value.value;
                                  provider.selectedCountry = selectedKey;
                                  // pin = int.parse(value.pinlength);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  print(selectedKey);
                                  print(value.pinlength);

                                  // print(selectedKey);
                                });
                              },
                              decoration: BoxDecoration(
                                border: Border.all(color: MyColors.accentsColors),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                              ),
                              onMenuButtonToggle: (bool isToggle) {
                                // print(isToggle);
                              },
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    labelText: 'Postcode / ZIP Code',
                    controller: provider.pcController,
                    validator: (value) {
                      //cjc commented

                      print('post code value - $value');

                      if (value == null) {
                        return "Postcode is required";
                      }
                      if (value.isEmpty) {
                        return "Postcode is required";
                      }
                      if (value.length < pin) {
                        return "Enter valid Postcode";
                      } else {
                        return null;
                      }
                      return null;
                    },
                    onSave: (value) {
                      provider.pcController.text = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                      onTap: () async {
                        print('tapped');
                        print('_checked - $_checked');
                        String emailid = await SharedPrefManager.instance
                            .getString(Constants.userEmail);
                        String pass = await SharedPrefManager.instance
                            .getString(Constants.password);
                        String uid = await SharedPrefManager.instance
                            .getString(Constants.userId);
                        print("jhfjhfhuj----------${emailid}");
                        print("jhfjhfhuj----------${pass}");
                        print("jhfjhfhuj----------${uid}");
                        print("jhfjhfhuj----------${selectedKey}");
                        if (_checked.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Atleast 1 Age Group",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.redAccent,
                            textColor: MyColors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        if (_ichecked.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please Select Atleast 1 Income Group",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }

                        if (selectedKey == "Select Country" ||
                            selectedKey == "" ||
                            selectedKey.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please Select Country",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        _performSubmit();
                      },
                      child: _submitButton(MyStrings.thatSMe)),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
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
      style: MyStyles.robotoMedium12.copyWith(
          letterSpacing: 3.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}

class CustomOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
