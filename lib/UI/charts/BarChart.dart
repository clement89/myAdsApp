import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/images.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/Constants/strings.dart';
import 'package:myads_app/Constants/styles.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';
import 'package:myads_app/UI/dashboardScreen/DashBoard.dart';
import 'package:myads_app/UI/dashboardScreen/dashboardProvider.dart';
import 'package:myads_app/UI/welcomeScreen/welcomeScreen.dart';
import 'package:myads_app/base/base_state.dart';
import 'package:myads_app/model/response/Graph/graphResponse.dart';
import 'package:myads_app/utils/code_snippet.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';
import 'package:provider/provider.dart';
import 'package:myads_app/UI/activity/activityScreen.dart';
import '../Chart.dart';
import '../CheckMyCoupons.dart';
import 'chartProvider.dart';
import '../settings/SettingScreen.dart';

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  final String title = "Charts Demo";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends BaseState<ChartsDemo> {
  BuildContext subcontext;
  ChartProvider _chartProvider;
  List<charts.Series> seriesList;
  DateTime selectedDate;
  String month ;
  int year = 2021;
  @override
  void initState() {
    super.initState();
    _chartProvider = Provider.of<ChartProvider>(context, listen: false);
    _chartProvider.listener = this;
    _chartProvider.performGetGraph(month,year);
    selectedDate = DateTime.now();

  }


  @override
  void onSuccess(any, {int reqId}) {
    ProgressBar.instance.hideProgressBar();
    super.onSuccess(any);
    print("in on sucess");
    switch (reqId) {
      case ResponseIds.GRAPH:
        GraphModel _response = any as GraphModel;
        print("ResponseDAW" + _response.toString());
        if (_response.views.isNotEmpty) {
          setState(() {
           _chartProvider.setViewList(_response.views);
           seriesList = _createRandomData();
          });

        } else {
          setState(() {
            _chartProvider.setViewList(_response.views);
            seriesList = _createRandomData();
          });
          CodeSnippet.instance.showMsg("No Data");
        }
        break;
    }
  }

  final List<PopulationData> data = [
  PopulationData(
  month: 'Mar 1',
  population: 0,
  barColor: charts.ColorUtil.fromDartColor(MyColors.barBlue)
  ),
  ];

   List<charts.Series<Sales, String>> _createRandomData() {
    print(_chartProvider.getViewList.length);
    final bonusData = List.generate(_chartProvider.getViewList.length, (index) {
      return Sales(_chartProvider.getViewList[index].date, double.parse(_chartProvider.getViewList[index].bonusMinutesDot));
    });
      // Sales('15-Mar', random.nextInt(100)),


    final minutesData = List.generate(_chartProvider.getViewList.length, (index) {
      return Sales(_chartProvider.getViewList[index].date, double.parse(_chartProvider.getViewList[index].minutesDot));
    });

    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: bonusData,
        fillColorFn: (Sales sales, _) {
          return charts.ColorUtil.fromDartColor(MyColors.orange);
        },
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: minutesData,
        fillColorFn: (Sales sales, _) {
          return charts.ColorUtil.fromDartColor(MyColors.blue);
        },
      )
    ];
  }
  _getSeriesData() {
    List<charts.Series<PopulationData, String>> series = [
      charts.Series(
          id: "Population",
          data:  _chartProvider.getViewList != null ? List.generate(
              _chartProvider.getViewList.length, (index) {
            return PopulationData(month: _chartProvider.getViewList[index].date,population: double.parse(_chartProvider.getViewList[index].cumMinutesDot), barColor: charts.ColorUtil.fromDartColor(MyColors.barBlue));
          }) :
          List.generate(
              0, (index) {
            return  PopulationData(population: 0.0, barColor: charts.ColorUtil.fromDartColor(MyColors.barBlue), month: month);

          }),
          domainFn: (PopulationData series, _) => series.month,
          measureFn: (PopulationData series, _) => series.population,
          colorFn: (PopulationData series, _) => series.barColor
      )
    ];
    return series;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.colorLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(''),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Image.asset(MyImages.appBarLogo),
            ),
            _DividerPopMenu(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<ChartProvider>(builder: (context,provider,_){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Center(
                  child: Text(
                    MyStrings.graphs,
                    style: MyStyles.robotoMedium30.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.accentsColors,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              InkWell(onTap: (){
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
                      String formatDate = new DateFormat("MMMM yyyy").format(selectedDate);
                      month = new DateFormat("MMMM").format(selectedDate);
                      year = selectedDate.year;
                      _chartProvider.performGetGraph(month,year);
                      _chartProvider.listener = this;

                    });
                  }
                });
              },
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.primaryColor)
                    ),
                    child: Row(
                      children: [
                        Text(DateFormat("MMM yyyy").format(selectedDate),style: MyStyles.robotoMedium16.copyWith(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w100),),
                        Icon(Icons.arrow_drop_down_outlined)
                      ],
                    ),
                  )
              ),
              Divider(
                height: 10.0,
                color: MyColors.accentsColors,
                thickness: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    MyStrings.dailyViewingTime,
                    style: MyStyles.robotoMedium26.copyWith(
                        color: MyColors.accentsColors,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              Container(
                  height: 400.0,
                  padding: EdgeInsets.all(10.0),
                  child: seriesList != null ? charts.BarChart(
                    seriesList,
                    // animate: animate,
                    // Configure a stroke width to enable borders on the bars.
                    defaultRenderer: new charts.BarRendererConfig(
                        groupingType: charts.BarGroupingType.stacked, strokeWidthPx: 2.0),
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: -90,
                        labelAnchor: charts.TickLabelAnchor.before,
                      ),
                    ),
                  ): SizedBox()
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: MyColors.blue,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Minutes per day',
                          style: MyStyles.robotoMedium12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.black,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 15.0,
                          width: 15.0,
                          color: MyColors.orange,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Bonus Minutes',
                          style: MyStyles.robotoMedium12.copyWith(
                              letterSpacing: 1.0,
                              color: MyColors.black,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
                color: MyColors.accentsColors,
                thickness: 2.0,
              ),
              Container(
                height: 400.0,
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 900,
                  width: 800,
                  padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          MyStrings.cumulative,
                          style: MyStyles.robotoMedium26.copyWith( color: MyColors.accentsColors, fontWeight: FontWeight.w100),

                        ),
                        SizedBox(height: 20,),
                        Expanded(
                          child: charts.BarChart(
                            _getSeriesData(),
                            animate: true,
                            domainAxis: charts.OrdinalAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(labelRotation: 45,
                                  labelAnchor: charts.TickLabelAnchor.after,)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashBoardScreen()));
                },
                child: _submitButton(MyStrings.returnTo),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          );
        },),
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
                        pageBuilder: (_, __, ___) => new ChartsDemo()));
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
            new PopupMenuItem<String>(
                value: 'value05',
                child: InkWell(
                  onTap: () {
                    Navigator.of(subcontext).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new ActivityScreen()));
                  },
                  child: new Text(
                    'My Activity',
                    style: MyStyles.robotoMedium16.copyWith(
                        letterSpacing: 1.0,
                        color: MyColors.black,
                        fontWeight: FontWeight.w100),
                  ),
                )),
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
                pageBuilder: (_, __, ___) => new ChartsDemo()));
          } else if (value == 'value05') {
            Navigator.of(subcontext).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ActivityScreen()));
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

class Sales {
  final String year;
  final double sales;

  Sales(this.year, this.sales);
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
    child: Text(
      buttonName,
      style: MyStyles.robotoMedium14.copyWith(
          letterSpacing: 3.0,
          color: MyColors.white,
          fontWeight: FontWeight.w500),
    ),
  );
}

/// Example of a stacked bar chart with three series, each rendered with
/// different fill colors.
class StackedFillColorBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedFillColorBarChart(this.seriesList, {this.animate});


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      // Configure a stroke width to enable borders on the bars.
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.stacked, strokeWidthPx: 2.0),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: -90,
          labelAnchor: charts.TickLabelAnchor.before,
        ),
      ),
    );
  }

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
  PopulationData({
    this.year,
    @required this.population,
    @required this.barColor,
    @required this.month
  });
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
//             new PopupMenuItem<String>(
//                 value: 'value01',
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(PageRouteBuilder(
//                         pageBuilder: (_, __, ___) => new DashBoardScreen()));
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Dashboard                  ',
//                         style: MyStyles.robotoMedium16.copyWith(
//                             letterSpacing: 1.0,
//                             color: MyColors.black,
//                             fontWeight: FontWeight.w100),
//                       ),
//                       Icon(
//                         Icons.keyboard_arrow_down,
//                         color: MyColors.darkGray,
//                       )
//                     ],
//                   ),
//                 )),
//             new PopupMenuDivider(height: 3.0),
//             new PopupMenuItem<String>(
//                 value: 'value02',
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(PageRouteBuilder(
//                           pageBuilder: (_, __, ___) => new SettingScreen()));
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => SettingScreen()));
//                     },
//                     child: new Text(
//                       'Settings',
//                       style: MyStyles.robotoMedium16.copyWith(
//                           letterSpacing: 1.0,
//                           color: MyColors.black,
//                           fontWeight: FontWeight.w100),
//                     ))),
//             new PopupMenuDivider(height: 3.0),
//             new PopupMenuItem<String>(
//                 value: 'value03',
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(PageRouteBuilder(
//                           pageBuilder: (_, __, ___) => new MyCouponScreen()));
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => MyCouponScreen()));
//                     },
//                     child: new Text(
//                       'Gift Card',
//                       style: MyStyles.robotoMedium16.copyWith(
//                           letterSpacing: 1.0,
//                           color: MyColors.black,
//                           fontWeight: FontWeight.w100),
//                     ))),
//             new PopupMenuDivider(height: 3.0),
//             new PopupMenuItem<String>(
//                 value: 'value04',
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(PageRouteBuilder(
//                         pageBuilder: (_, __, ___) => new ChartsDemo()));
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => ChartsDemo()));
//                   },
//                   child: new Text(
//                     'Graphs',
//                     style: MyStyles.robotoMedium16.copyWith(
//                         letterSpacing: 1.0,
//                         color: MyColors.black,
//                         fontWeight: FontWeight.w100),
//                   ),
//                 )),
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
//           ],
//       onSelected: (String value) {
//         // setState(() { _bodyStr = value; });
//       });
// }
