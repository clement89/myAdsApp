import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/activity/benefit_response.dart';
import 'package:myads_app/model/response/activity/performance_response.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../Constants/colors.dart';
import '../../Constants/constants.dart';
import '../../Constants/images.dart';
import '../../Constants/strings.dart';
import '../../Constants/styles.dart';
import '../CheckMyCoupons.dart';
import '../charts/BarChart.dart';
import '../settings/SettingScreen.dart';
import '../welcomeScreen/welcomeScreen.dart';
import 'activityProvider.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends BaseState<ActivityScreen>
    with SingleTickerProviderStateMixin {
  BuildContext subcontext;
  DateTime selectedDate =
      dateTimeToZone(zone: "AEST", datetime: DateTime.now());
  String month;
  int year;
  ActivityProvider _activityProvider;
  TabController _tabController;
  String tab = 'performance';
  int _selectedTab = 0;
  List<DailyReport> employees = [];
  EmployeeDataSource employeeDataSource;
  @override
  void initState() {
    super.initState();
    // String formatDate = new DateFormat("MMMM yyyy").format(selectedDate);
    // month = new DateFormat("MMMM").format(selectedDate);
    month = new DateFormat("MMMM").format(selectedDate);
    year = selectedDate.year;
    _tabController = TabController(vsync: this, length: 2);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
          if (_selectedTab == 0) {
            tab = 'performance';
            _activityProvider.listener = this;
            _activityProvider.performGetPerformance(month, year, 'performance');
          } else if (_selectedTab == 1) {
            tab = 'benefit';
            _activityProvider.listener = this;
            _activityProvider.performGetBenefit(month, year, 'benefit');
          } else {
            tab = 'feedback';
            _activityProvider.listener = this;
            _activityProvider.performGetPerformance(month, year, 'feedback');
          }
          print("_selectedTab");
          print(_selectedTab);
          print("_selectedTab");
        });
      }
    });
    _activityProvider = Provider.of<ActivityProvider>(context, listen: false);
    _activityProvider.listener = this;
    _activityProvider.performGetPerformance(month, year, 'performance');
    employees = _activityProvider.getDailyReportList;
  }

  String ronValue = "0.0";
  String status = "";
  String cardNo = "";
  String cardStatus = "";
  String emailId = "";
  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    print("in on sucess");
    switch (reqId) {
      case ResponseIds.GET_PERFORMANCE:
        PerformanceResponse _response = any as PerformanceResponse;
        print("ResponseDAW" + _response.toString());
        if (_response.ron != null) {
          setState(() {
            ronValue = _response.ron;
            status = _response.status;
            cardNo = _response.cardNo;
            cardStatus = _response.cardStatus;
            emailId = _response.emailId;
            _activityProvider.setDailyReportList(_response.dailyReport);
            employees = _activityProvider.getDailyReportList;
            employeeDataSource = EmployeeDataSource(employeeData: employees);
          });
        } else {
          CodeSnippet.instance.showMsg("No Data");
        }
        break;
      case ResponseIds.GET_BENEFIT:
        BenefitResponse _response = any as BenefitResponse;
        print("ResponseDAW" + _response.toString());
        if (_response.ron != null) {
          setState(() {
            ronValue = _response.ron;
            status = _response.status;
            cardNo = _response.cardNo;
            cardStatus = _response.cardStatus;
            emailId = _response.emailId;
          });
        } else {
          CodeSnippet.instance.showMsg("No Data");
        }
        break;
    }
  }

  final List<PopulationData> data = [
    PopulationData(
        month: 'Mar 1',
        population: 0,
        barColor: charts.ColorUtil.fromDartColor(MyColors.barBlue)),
  ];

  _getSeriesData() {
    List<charts.Series<PopulationData, String>> series = [
      charts.Series(
          id: "Population",
          data: _activityProvider.getDailyReportList != null
              ? List.generate(_activityProvider.getDailyReportList.length,
                  (index) {
                  return PopulationData(
                      month: _activityProvider.getDailyReportList[index].date,
                      population: double.parse(
                          _activityProvider.getDailyReportList[index].ron),
                      barColor:
                          charts.ColorUtil.fromDartColor(MyColors.barBlue));
                })
              : List.generate(0, (index) {
                  return PopulationData(
                      population: 0.0,
                      barColor:
                          charts.ColorUtil.fromDartColor(MyColors.barBlue),
                      month: month);
                }),
          domainFn: (PopulationData series, _) => series.month,
          measureFn: (PopulationData series, _) => series.population,
          colorFn: (PopulationData series, _) => series.barColor)
    ];
    return series;
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
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: Consumer<ActivityProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "My Activity",
              style: MyStyles.robotoBold20.copyWith(
                  letterSpacing: 1.0,
                  color: MyColors.blue,
                  fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select Month/Year",
                  style: MyStyles.robotoMedium16.copyWith(
                      letterSpacing: 1.0,
                      color: MyColors.black,
                      fontWeight: FontWeight.w100),
                ),
                InkWell(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: selectedDate ?? DateTime.now(),
                        // locale: Locale("es"),
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            selectedDate = date;
                            String formatDate = new DateFormat("MMMM yyyy")
                                .format(selectedDate);
                            month = new DateFormat("MMMM").format(selectedDate);
                            year = selectedDate.year;
                            _activityProvider.performGetPerformance(
                                month, year, tab);
                            _activityProvider.listener = this;
                          });
                        }
                      });
                    },
                    child: Container(
                      width: 110,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: MyColors.primaryColor)),
                      child: Row(
                        children: [
                          Text(
                            DateFormat("MMM yyyy").format(selectedDate),
                            // month,
                            style: MyStyles.robotoMedium16.copyWith(
                                color: MyColors.primaryColor,
                                fontWeight: FontWeight.w100),
                          ),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    )),
                Container(
                  color: MyColors.primaryColor,
                  height: 35,
                  width: 105,
                  child: Center(
                    child: Text(
                      'Rons: $ronValue',
                      style: MyStyles.robotoMedium14.copyWith(
                          letterSpacing: 1.0,
                          color: MyColors.white,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Material(
                        // color: Colors.grey.shade300,
                        child: TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorColor: Colors.white,
                          controller: _tabController,
                          labelPadding: const EdgeInsets.all(0.0),
                          tabs: [
                            _getTab(0, 'Performance'),
                            _getTab(1, 'Benefit Status'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Container(
                                      height: 190,
                                      width: 400,
                                      child: charts.BarChart(
                                        _getSeriesData(),
                                        animate: true,
                                        domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec:
                                                charts.SmallTickRendererSpec(
                                          labelRotation: 80,
                                          labelAnchor:
                                              charts.TickLabelAnchor.after,
                                        )),
                                      ),
                                    ),
                                  ),
                                  // _activityProvider.getDailyReportList != null
                                  //     ? Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(
                                  //     // color: Colors.green,jkhuy
                                  //     height: 250, // cjc not commented
                                  //     child: SingleChildScrollView(
                                  //       physics: ScrollPhysics(),
                                  //       scrollDirection: Axis.vertical,
                                  //       child: DataTable(
                                  //           headingRowHeight: 40,
                                  //           dataRowHeight: 40,
                                  //
                                  //           headingRowColor:
                                  //           MaterialStateProperty
                                  //               .resolveWith<
                                  //               Color>((Set<
                                  //               MaterialState>
                                  //           states) {
                                  //             return MyColors
                                  //                 .primaryColor;
                                  //           }),
                                  //           columns: <DataColumn>[
                                  //             DataColumn(
                                  //               label: Text(
                                  //                 'Date',
                                  //                 style: MyStyles
                                  //                     .robotoMedium16
                                  //                     .copyWith(
                                  //                     letterSpacing:
                                  //                     1.0,
                                  //                     color: MyColors
                                  //                         .white,
                                  //                     fontWeight:
                                  //                     FontWeight
                                  //                         .w100),
                                  //               ),
                                  //             ),
                                  //             DataColumn(
                                  //               label: Text(
                                  //                 'Batch',
                                  //                 style: MyStyles
                                  //                     .robotoMedium16
                                  //                     .copyWith(
                                  //                     letterSpacing:
                                  //                     1.0,
                                  //                     color: MyColors
                                  //                         .white,
                                  //                     fontWeight:
                                  //                     FontWeight
                                  //                         .w100),
                                  //               ),
                                  //             ),
                                  //             DataColumn(
                                  //               label: Text(
                                  //                 'Watchtime',
                                  //                 style: MyStyles
                                  //                     .robotoMedium16
                                  //                     .copyWith(
                                  //                     letterSpacing:
                                  //                     1.0,
                                  //                     color: MyColors
                                  //                         .white,
                                  //                     fontWeight:
                                  //                     FontWeight
                                  //                         .w100),
                                  //               ),
                                  //             ),
                                  //             DataColumn(
                                  //               label: Text(
                                  //                 'Survey',
                                  //                 style: MyStyles
                                  //                     .robotoMedium16
                                  //                     .copyWith(
                                  //                     letterSpacing:
                                  //                     1.0,
                                  //                     color: MyColors
                                  //                         .white,
                                  //                     fontWeight:
                                  //                     FontWeight
                                  //                         .w100),
                                  //               ),
                                  //             ),
                                  //             DataColumn(
                                  //               label: Text(
                                  //                 'Rons',
                                  //                 style: MyStyles
                                  //                     .robotoMedium16
                                  //                     .copyWith(
                                  //                     letterSpacing:
                                  //                     1.0,
                                  //                     color: MyColors
                                  //                         .white,
                                  //                     fontWeight:
                                  //                     FontWeight
                                  //                         .w100),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //
                                  //           columnSpacing: 10.0,
                                  //           rows: List.generate(
                                  //             _activityProvider
                                  //                 .getDailyReportList
                                  //                 .length,
                                  //                 (index) {
                                  //               return DataRow(cells: [
                                  //                 DataCell(
                                  //                   Text(_activityProvider
                                  //                       .getDailyReportList[
                                  //                   index]
                                  //                       .date),
                                  //                   showEditIcon: false,
                                  //                   placeholder: false,
                                  //                 ),
                                  //                 DataCell(
                                  //                   Text(_activityProvider
                                  //                       .getDailyReportList[
                                  //                   index]
                                  //                       .badge),
                                  //                   showEditIcon: false,
                                  //                   placeholder: false,
                                  //                 ),
                                  //                 DataCell(
                                  //                   Text(_activityProvider
                                  //                       .getDailyReportList[
                                  //                   index]
                                  //                       .watchSeconds),
                                  //                   showEditIcon: false,
                                  //                   placeholder: false,
                                  //                 ),
                                  //                 DataCell(
                                  //                   Text(_activityProvider
                                  //                       .getDailyReportList[
                                  //                   index]
                                  //                       .surveys),
                                  //                   showEditIcon: false,
                                  //                   placeholder: false,
                                  //                 ),
                                  //                 DataCell(
                                  //                   Text(_activityProvider
                                  //                       .getDailyReportList[
                                  //                   index]
                                  //                       .ron),
                                  //                   showEditIcon: false,
                                  //                   placeholder: false,
                                  //                 ),
                                  //               ]);
                                  //             },
                                  //           )
                                  //       ),
                                  //     ),
                                  //   ),
                                  // )
                                  //     : SizedBox(),
                                  _activityProvider.getDailyReportList != null
                                      ? Container(
                                          height: 300,
                                          child: SfDataGrid(
                                            source: employeeDataSource,
                                            columnWidthMode:
                                                ColumnWidthMode.fill,
                                            columns: <GridColumn>[
                                              GridColumn(
                                                  columnName: 'id',
                                                  label: Container(
                                                      // padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Date',
                                                        style: MyStyles
                                                            .robotoMedium16
                                                            .copyWith(
                                                                color: MyColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                      ))),
                                              // GridColumn(
                                              //     columnName: 'name',
                                              //     label: Container(
                                              //       // padding: EdgeInsets.all(8.0),
                                              //         alignment: Alignment.center,
                                              //         child: Text('Batch',                     style: MyStyles
                                              //             .robotoMedium16
                                              //             .copyWith(
                                              //             color: MyColors
                                              //                 .white,
                                              //             fontWeight:
                                              //             FontWeight
                                              //                 .w100),))),
                                              GridColumn(
                                                  columnName: 'designation',
                                                  label: Container(
                                                      // padding: EdgeInsets.all(8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Watchtime',
                                                        style: MyStyles
                                                            .robotoMedium16
                                                            .copyWith(
                                                                color: MyColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                      ))),
                                              GridColumn(
                                                  columnName: 'salary',
                                                  label: Container(
                                                      // padding: EdgeInsets.all(8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Survey',
                                                        style: MyStyles
                                                            .robotoMedium16
                                                            .copyWith(
                                                                color: MyColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                      ))),
                                              GridColumn(
                                                  columnName: 'rons',
                                                  label: Container(
                                                      // padding: EdgeInsets.all(8.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Rons',
                                                        style: MyStyles
                                                            .robotoMedium16
                                                            .copyWith(
                                                                color: MyColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                      ))),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  Center(
                                    child: InkWell(
                                        onTap: () {
                                          // Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DashBoardScreen(),
                                            ),
                                          );
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
                                        },
                                        child:
                                            _submitButton(MyStrings.returnTo)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        MyImages.cardBack,
                                        height: 100,
                                        width: 180,
                                      ),
                                      Image.asset(
                                        MyImages.cardFront,
                                        height: 100,
                                        width: 180,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 30.0, left: 10.0, right: 10.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      width: MediaQuery.of(context).size.width /
                                          0.5,
                                      color: MyColors.lightBlueShade,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Earning: $ronValue Rons',
                                              style: MyStyles.robotoMedium16
                                                  .copyWith(
                                                      letterSpacing: 1.0,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                            Text(
                                              'Status: $status',
                                              style: MyStyles.robotoMedium16
                                                  .copyWith(
                                                      letterSpacing: 1.0,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                            Text(
                                              'Unique Card No: $cardNo',
                                              style: MyStyles.robotoMedium16
                                                  .copyWith(
                                                      letterSpacing: 1.0,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                            Text(
                                              'Card Status: $cardStatus',
                                              style: MyStyles.robotoMedium16
                                                  .copyWith(
                                                      letterSpacing: 1.0,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                            Text(
                                              'email ID: $emailId',
                                              style: MyStyles.robotoMedium16
                                                  .copyWith(
                                                      letterSpacing: 1.0,
                                                      color: MyColors.black,
                                                      fontWeight:
                                                          FontWeight.w100),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  // Center(
                                  //   child: InkWell(
                                  //       onTap: () {
                                  //         Navigator.of(context).pop();
                                  //         // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                                  //       },
                                  //       child: _submitButton(
                                  //           MyStrings.requestBalance)),
                                  // ),
                                  // SizedBox(
                                  //   height: 20.0,
                                  // ),
                                  Center(
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
                                        },
                                        child:
                                            _submitButton(MyStrings.returnTo)),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        );
      }),
    );
  }

  _getTab(index, text) {
    return Tab(
      child: SizedBox(
        width: 175,
        height: 40,
        child: Container(
          child: Center(
              child: Text(
            text,
            style: MyStyles.robotoMedium16.copyWith(
                letterSpacing: 1.0,
                color: _selectedTab == index ? MyColors.white : MyColors.black,
                fontWeight: FontWeight.w100),
          )),
          decoration: BoxDecoration(
            color: (_selectedTab == index
                ? MyColors.primaryColor
                : MyColors.white),
            border: Border.all(color: MyColors.black),
            borderRadius: BorderRadius.circular(15),
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
    width: 280.0,
    height: 45.0,
    padding: EdgeInsets.symmetric(vertical: 5),
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

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class PopulationData {
  int year;
  String month;
  double population;
  charts.Color barColor;
  PopulationData(
      {this.year,
      @required this.population,
      @required this.barColor,
      @required this.month});
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
// class Employee {
//   /// Creates the employee class with required details.
//   Employee(this.id, this.name, this.designation, this.salary,this.rons);
//
//   /// Id of an employee.
//   final int id;
//
//   /// Name of an employee.
//   final String name;
//
//   /// Designation of an employee.
//   final String designation;
//
//   /// Salary of an employee.
//   final int salary;
//   final int rons;
// }

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({@required List<DailyReport> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'data', value: e.date),
              // DataGridCell<String>(columnName: 'badge', value: e.badge),
              DataGridCell<String>(columnName: 'watch', value: e.watchSeconds),
              DataGridCell<String>(columnName: 'survey', value: e.surveys),
              DataGridCell<String>(columnName: 'rons', value: e.ron),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: .0),

        alignment: Alignment.center,
        // padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
