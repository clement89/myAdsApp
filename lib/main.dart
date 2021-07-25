import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/UI/welcomeScreen/splashScreen.dart';
import 'package:myads_app/service/locator.dart';
import 'package:provider/provider.dart';
import 'Constants/routes.dart';
import 'Constants/strings.dart';
import 'UI/authenticationScreen/forgotPassword/ForgotPasswordProvider.dart';
import 'UI/authenticationScreen/signUp/Demo/DemographicsProvider.dart';
import 'UI/authenticationScreen/signUp/signupProvider.dart';
import 'UI/charts/chartProvider.dart';
import 'UI/dashboardScreen/DashBoard.dart';
import 'UI/authenticationScreen/signIn/loginProvider.dart';
import 'UI/dashboardScreen/dashboardProvider.dart';
import 'UI/interest/interestProvider.dart';
import 'UI/portraitScreen/watchPortraitProvider.dart';
import 'UI/settings/settingsProvider.dart';
import 'UI/streams/streamProvider.dart';
import 'UI/survey/surveyProvider.dart';
import 'UI/welcomeScreen/welcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:myads_app/UI/activity/activityProvider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> LoginProvider()),
        ChangeNotifierProvider(create: (context)=> DashboardProvider()),
        ChangeNotifierProvider(create: (context)=> WatchPortraitProvider()),
        ChangeNotifierProvider(create: (context)=> SettingsProvider()),
        ChangeNotifierProvider(create: (context)=> SignUpProvider()),
        ChangeNotifierProvider(create: (context)=> DemographicsProvider()),
        ChangeNotifierProvider(create: (context)=> InterestProvider()),
        ChangeNotifierProvider(create: (context)=> StreamsProvider()),
        ChangeNotifierProvider(create: (context)=> SurveyProvider()),
        ChangeNotifierProvider(create: (context)=> ForgotProvider()),
        ChangeNotifierProvider(create: (context)=> ChartProvider()),
        ChangeNotifierProvider(create: (context)=> ActivityProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: MyStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor:  MyColors.primaryColor,
            accentColor: MyColors.primaryColor,
            backgroundColor: MyColors.white,
            // fontFamily: MyStrings.poppinsMedium,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: MyColors.white,
            unselectedWidgetColor: MyColors.accentsColors,
            buttonColor: MyColors.accentsColors,

          ),
          home: AnimatedSplashScreen(),
          routes: {
            // MyRoutes.splashScreen: (context) => AnimatedSplashScreen(),
            MyRoutes.welcomeScreen: (context) => WelcomeScreen(),
            MyRoutes.dashboardScreen: (context) => DashBoardScreen(),
            // MyRoutes.profileView : (context) {
            //   String userId = ModalRoute.of(context).settings.arguments;
            //   print(ModalRoute.of(context).settings.arguments);
            //   return ProfileIndividuals(userId);
          },
        ),
      ),
    );
  }
}





