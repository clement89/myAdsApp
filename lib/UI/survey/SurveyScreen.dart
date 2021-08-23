import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/Constants/validate_input.dart';
import 'package:myads_app/UI/activity/activityScreen.dart';
import 'package:myads_app/UI/settings/SettingScreen.dart';
import 'package:myads_app/UI/survey/surveyProvider.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/dashboard/getVideosResponse.dart';
import 'package:myads_app/model/response/survey/surveyResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';

import '../CheckMyCoupons.dart';
import '../Widgets/custom_textformfield.dart';
import '../Widgets/progressbar.dart';
import '../charts/BarChart.dart';
import '../dashboardScreen/dashboardProvider.dart';

class SurveyScreen extends StatefulWidget {
  String videoId;
  SurveyScreen({this.videoId});
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends BaseState<SurveyScreen> {
  DashboardProvider _dashboardProvider;
  SurveyProvider _surveyProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext subcontext;
  @override
  void initState() {
    super.initState();
    _dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    _surveyProvider = Provider.of<SurveyProvider>(context, listen: false);
    _surveyProvider.initialProvider("");
    _dashboardProvider.listener = this;
    _surveyProvider.listener = this;
    _dashboardProvider.performGetVideos(widget.videoId);
  }

  double _rating = 3;
  var rating = 2;
  double _initialRating = 2.0;

  SurveyDetails surveyDetails;
  String checkboxItem;
  String starRating;
  double _ratingSmile = 0;
  int id;
  bool valYes = false;
  bool valNo = false;
  bool isLike = false;
  bool isDislike = false;
  bool isLoved = false;
  bool isUnlikely = false;
  bool isFairly = false;
  bool isVeryLikely = false;
  String lld, ufv;
  String yesNo;
  void _performSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _performSurvey();
    } else {
      _surveyProvider.setAutoValidate(true);
    }
  }

  void _performSurvey() {
    _surveyProvider.listener = this;
    ProgressBar.instance.showProgressbar(context);
    _surveyProvider.performSurvey(widget.videoId, surveyid);
  }

  String surveyid;
  List<String> _checked = [];
  double r1 = 0.0;
  // String r2 = '0';
  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    print("in on success $reqId");
    switch (reqId) {
      case ResponseIds.GET_VIDEO:
        VideoResponse _response = any as VideoResponse;
        print("SURVEY RESPONSE" + _response.toString());
        if (_response.userId.toString().isNotEmpty) {
          print("success ${_response.videoLink}");
          setState(() {
            _dashboardProvider.setSurveyVideo(_response.surveyDetails);
            surveyDetails = _response.surveyDetails;
            _surveyProvider.setSurveyData(_response.surveyDetails);
            surveyid = _response.surveyDetails.id.toString();
            if (_surveyProvider.getSurveyData.question[0].answer != '') {
              int count = 0;
              for (var i in surveyDetails.question) {
                if (surveyDetails.question[count].type == 'Star Rating') {
                  r1 = double.parse(surveyDetails.question[count].answer);
                  print("yes star");
                } else if (surveyDetails.question[count].type ==
                    'Boolean (True / False)') {
                  if (surveyDetails.question[count].answer == 'True') {
                    id = 1;
                    checkboxItem = 'True';
                  } else {
                    id = 2;
                    checkboxItem = 'False';
                  }
                } else if (surveyDetails.question[count].type == 'Yes / No') {
                  //cjc commented
                  if (surveyDetails.question[count].answer == 'Yes') {
                    valYes = true;
                    yesNo = 'Yes';
                  } else if (surveyDetails.question[count].answer == 'No') {
                    valNo = true;
                    yesNo = 'No';
                  }
                } else if (surveyDetails.question[count].type ==
                    'Dislike / Liked / Loved') {
                  print("print 1");
                  if (surveyDetails.question[count].answer == 'Dislike') {
                    print("print 1");
                    isLike = false;
                    isDislike = true;
                    isLoved = false;
                    lld = 'Dislike';
                  } else if (surveyDetails.question[count].answer == 'Like') {
                    isLike = true;
                    isDislike = false;
                    isLoved = false;
                    lld = 'Like';
                  } else if (surveyDetails.question[count].answer == 'Loved') {
                    isLike = false;
                    isDislike = false;
                    isLoved = true;
                    lld = 'Loved';
                  }
                } else if (surveyDetails.question[count].type ==
                    'Unlikely / Fairly likely / Very Likely') {
                  print("print 1");
                  if (surveyDetails.question[count].answer == 'Unlikely') {
                    print("print 1");
                    isUnlikely = true;
                    isFairly = false;
                    isVeryLikely = false;
                    ufv = 'Unlikely';
                  } else if (surveyDetails.question[count].answer ==
                      'Fairly likely') {
                    isUnlikely = false;
                    isFairly = true;
                    isVeryLikely = false;
                    ufv = 'Fairly likely';
                  } else if (surveyDetails.question[count].answer ==
                      'Very Likely') {
                    isUnlikely = false;
                    isFairly = false;
                    isVeryLikely = true;
                    ufv = 'Very Likely';
                  }
                } else if (surveyDetails.question[count].type == 'Text Box') {
                  print("yes like");
                  _surveyProvider.commentController.text =
                      surveyDetails.question[count].answer;
                }
                count++;
              }
            }
          });
        } else {
          print("failure");
          CodeSnippet.instance.showMsg(_response.userId.toString());
        }
        break;
      case ResponseIds.ADD_SURVEY:
        SurveyResponse _response = any as SurveyResponse;
        print("SURVEY RESPONSE" + _response.toString());
        if (_response.id != null) {
          setState(() {
            CodeSnippet.instance.showMsg("Successfully Updated");
            Navigator.of(context).pop();
          });
        } else {
          print("failure");
          CodeSnippet.instance.showMsg("failed");
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
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: SingleChildScrollView(
          child: Consumer<SurveyProvider>(
            builder: (context, provider, _) {
              return surveyDetails != null
                  ? surveyDetails.question.isNotEmpty
                      ? Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Center(
                                  child: Text(
                                    surveyDetails.name,
                                    style: MyStyles.robotoLight28.copyWith(
                                        letterSpacing: 1.0,
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: surveyDetails.question.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${index + 1}. ${surveyDetails.question[index].question}",
                                            style: MyStyles.robotoLight24
                                                .copyWith(
                                                    letterSpacing: 1.0,
                                                    color: MyColors.primaryColor,
                                                    fontWeight: FontWeight.w100),
                                          ),
                                          surveyDetails.question[index].type ==
                                                  'Text Box'
                                              ? Center(
                                                  child: CustomTextFormField(
                                                    labelText: "",
                                                    controller: provider
                                                        .commentController,
                                                    validator: ValidateInput
                                                        .requiredFields,
                                                    onSave: (value) {
                                                      provider.commentController
                                                          .text = value;
                                                    },
                                                  ),
                                                )
                                              : surveyDetails
                                                          .question[index].type ==
                                                      'Star Rating'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0,
                                                                  top: 10.0,
                                                                  right: 10),
                                                          child:
                                                              RatingBar.builder(
                                                            initialRating: r1,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color: MyColors
                                                                  .primaryColor,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              r1 = rating;
                                                              provider.rating =
                                                                  r1.toString();
                                                              print(r1);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : surveyDetails.question[index]
                                                              .type ==
                                                          'Yes / No'
                                                      ? Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Checkbox(
                                                                    value: valYes,
                                                                    onChanged: (bool
                                                                        value) {
                                                                      setState(
                                                                          () {
                                                                        valYes =
                                                                            value;
                                                                        valNo =
                                                                            !value;
                                                                        provider.yesNo =
                                                                            'Yes';
                                                                        yesNo =
                                                                            'Yes';
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text("Yes"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Checkbox(
                                                                    value: valNo,
                                                                    onChanged: (bool
                                                                        value) {
                                                                      setState(
                                                                          () {
                                                                        valNo =
                                                                            value;
                                                                        valYes =
                                                                            !value;
                                                                        provider.yesNo =
                                                                            'No';
                                                                        yesNo =
                                                                            'No';
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text("No"),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : surveyDetails
                                                                  .question[index]
                                                                  .type ==
                                                              'Boolean (True / False)'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 35,
                                                                      top: 20.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Radio(
                                                                    value: 1,
                                                                    groupValue:
                                                                        id,
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        checkboxItem =
                                                                            'True';
                                                                        id = 1;
                                                                        print(id);
                                                                        provider.truefalse =
                                                                            checkboxItem;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    'True',
                                                                    style: MyStyles
                                                                        .robotoMedium20
                                                                        .copyWith(
                                                                            letterSpacing: Dimens
                                                                                .letterSpacing_14,
                                                                            // color: MyColors.accentsColors,
                                                                            fontWeight:
                                                                                FontWeight.w100),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 80,
                                                                  ),
                                                                  Radio(
                                                                    value: 2,
                                                                    groupValue:
                                                                        id,
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        checkboxItem =
                                                                            'False';
                                                                        id = 2;
                                                                        print(id);
                                                                        provider.truefalse =
                                                                            checkboxItem;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    'False',
                                                                    style: MyStyles
                                                                        .robotoMedium20
                                                                        .copyWith(
                                                                            letterSpacing: Dimens
                                                                                .letterSpacing_14,
                                                                            // color: MyColors.accentsColors,
                                                                            fontWeight:
                                                                                FontWeight.w100),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : surveyDetails
                                                                      .question[
                                                                          index]
                                                                      .type ==
                                                                  'Unlikely / Fairly likely / Very Likely'
                                                              ? Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_very_dissatisfied,
                                                                              color: isUnlikely == true
                                                                                  ? Colors.red
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isUnlikely = true;
                                                                                isFairly = false;
                                                                                isVeryLikely = false;
                                                                                ufv = 'Unlikely';
                                                                                print(ufv);
                                                                                provider.unlikely = ufv;
                                                                              });
                                                                            }),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_neutral,
                                                                              color: isFairly == true
                                                                                  ? Colors.amber
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isUnlikely = false;
                                                                                isFairly = true;
                                                                                isVeryLikely = false;
                                                                                ufv = 'Fairly likely';
                                                                                print(ufv);
                                                                                provider.unlikely = ufv;
                                                                              });
                                                                            }),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_very_satisfied,
                                                                              color: isVeryLikely
                                                                                  ? Colors.green
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isUnlikely = false;
                                                                                isFairly = false;
                                                                                isVeryLikely = true;
                                                                                ufv = 'Very Likely';
                                                                                print(ufv);
                                                                                provider.unlikely = ufv;
                                                                              });
                                                                            })
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_very_dissatisfied,
                                                                              color: isDislike == true
                                                                                  ? Colors.red
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isDislike = true;
                                                                                isLike = false;
                                                                                isLoved = false;
                                                                                lld = 'Dislike';
                                                                                print(lld);
                                                                                provider.likedislike = lld;
                                                                              });
                                                                            }),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_neutral,
                                                                              color: isLike == true
                                                                                  ? Colors.amber
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isDislike = false;
                                                                                isLike = true;
                                                                                isLoved = false;
                                                                                lld = 'Like';
                                                                                print(lld);
                                                                                provider.likedislike = lld;
                                                                              });
                                                                            }),
                                                                        IconButton(
                                                                            icon:
                                                                                Icon(
                                                                              Icons.sentiment_very_satisfied,
                                                                              color: isLoved
                                                                                  ? Colors.green
                                                                                  : Colors.grey,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                isDislike = false;
                                                                                isLike = false;
                                                                                isLoved = true;
                                                                                lld = 'Loved';
                                                                                print(lld);
                                                                                provider.likedislike = lld;
                                                                              });
                                                                            })
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 30.0,
                              ),
                              InkWell(
                                  onTap: () {
                                    int count = 0;
                                    for (var i in surveyDetails.question) {
                                      if (surveyDetails.question[count].type ==
                                          'Star Rating') {
                                        print("yes star");
                                        _surveyProvider.addQuestions(
                                            "answer:${r1.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      } else if (surveyDetails
                                              .question[count].type ==
                                          'Boolean (True / False)') {
                                        print("yes true");
                                        _surveyProvider.addQuestions(
                                            "answer:${checkboxItem.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      } else if (surveyDetails
                                              .question[count].type ==
                                          'Yes / No') {
                                        print("yes no");
                                        _surveyProvider.addQuestions(
                                            "answer:${yesNo.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      } else if (surveyDetails
                                              .question[count].type ==
                                          'Dislike / Liked / Loved') {
                                        print("yes like");
                                        _surveyProvider.addQuestions(
                                            "answer:${lld.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      } else if (surveyDetails
                                              .question[count].type ==
                                          'Unlikely / Fairly likely / Very Likely') {
                                        print("yes like");
                                        _surveyProvider.addQuestions(
                                            "answer:${ufv.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      } else if (surveyDetails
                                              .question[count].type ==
                                          'Text Box') {
                                        print("yes like");
                                        _surveyProvider.addQuestions(
                                            "answer:${provider.commentController.text.toString()}&&question:${surveyDetails.question[count].question}&&type:${surveyDetails.question[count].type}");
                                      }
                                      count++;
                                    }
                                    _surveyProvider.performSurvey(
                                        widget.videoId, surveyid);
                                  },
                                  child: _submitButton('RETURN TO MYADS')),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2),
                          child: Center(child: Text('No Survey')),
                        )
                  : Center(child: CircularProgressIndicator());
            },
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

Widget _submitButton(String buttonName) {
  return Container(
    width: 250.0,
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
        style: MyStyles.robotoMedium12.copyWith(
            letterSpacing: 4.0,
            color: MyColors.white,
            fontWeight: FontWeight.w500),
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
//       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//         new PopupMenuItem<String>(
//             value: 'value01',
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Dashboard                  ',
//                   style: MyStyles.robotoMedium16.copyWith(
//                       letterSpacing: 1.0,
//                       color: MyColors.lightGray,
//                       fontWeight: FontWeight.w100),
//                 ),
//                 Icon(
//                   Icons.keyboard_arrow_down,
//                   color: MyColors.darkGray,
//                 )
//               ],
//             )),
//         new PopupMenuDivider(height: 3.0),
//         new PopupMenuItem<String>(
//             value: 'value02',
//             child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(PageRouteBuilder(
//                       pageBuilder: (_, __, ___) => new SettingScreen()));
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => SettingScreen()));
//                 },
//                 child: new Text(
//                   'Settings',
//                   style: MyStyles.robotoMedium16.copyWith(
//                       letterSpacing: 1.0,
//                       color: MyColors.black,
//                       fontWeight: FontWeight.w100),
//                 ))),
//         new PopupMenuDivider(height: 3.0),
//         new PopupMenuItem<String>(
//             value: 'value03',
//             child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(PageRouteBuilder(
//                       pageBuilder: (_, __, ___) => new MyCouponScreen()));
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => MyCouponScreen()));
//                 },
//                 child: new Text(
//                   'Gift Card',
//                   style: MyStyles.robotoMedium16.copyWith(
//                       letterSpacing: 1.0,
//                       color: MyColors.black,
//                       fontWeight: FontWeight.w100),
//                 ))),
//         new PopupMenuDivider(height: 3.0),
//         new PopupMenuItem<String>(
//             value: 'value04',
//             child: InkWell(
//               onTap: () {
//                 Navigator.of(context).push(PageRouteBuilder(
//                     pageBuilder: (_, __, ___) => new ChartsDemo()));
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (context) => ChartsDemo()));
//               },
//               child: new Text(
//                 'Graphs',
//                 style: MyStyles.robotoMedium16.copyWith(
//                     letterSpacing: 1.0,
//                     color: MyColors.black,
//                     fontWeight: FontWeight.w100),
//               ),
//             )),
//         new PopupMenuItem<String>(
//             value: 'value05',
//             child: InkWell(
//               onTap: () {
//
//               },
//               child: new Text(
//                 'Rons Report',
//                 style: MyStyles.robotoMedium16.copyWith(
//                     letterSpacing: 1.0,
//                     color: MyColors.black,
//                     fontWeight: FontWeight.w100),
//               ),
//             )),
//         new PopupMenuDivider(height: 3.0),
//       ],
//       onSelected: (String value) {
//         // setState(() { _bodyStr = value; });
//       });
// }
