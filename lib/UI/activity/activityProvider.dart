import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/activity/benefit_response.dart';
import 'package:myads_app/model/response/activity/performance_response.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class ActivityProvider extends BaseProvider {
  List<DailyReport> dailyReport;
  //performance
  performGetPerformance(String month, int year, String tab) async {
    print("1");
    Map<String, dynamic> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'month': month,
      'year': year,
      'tab': tab,
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.activity, queryParameters: qParams)
        .then((response) => getSuccessResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getSuccessResponse(Response response) {
    print("2");
    PerformanceResponse _response = PerformanceResponse.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.GET_PERFORMANCE);
    print("4");
  }

  //benefit
  performGetBenefit(String month, int year, String tab) async {
    print("1");
    Map<String, dynamic> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'month': month,
      'year': year,
      'tab': tab,
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.activity, queryParameters: qParams)
        .then((response) => getBenefitSuccessResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getBenefitSuccessResponse(Response response) {
    print("2");
    BenefitResponse _response = BenefitResponse.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.GET_BENEFIT);
    print("4");
  }

  void setDailyReportList(List<DailyReport> _dailyReport){
    dailyReport = _dailyReport;
    notifyListeners();
  }

  List<DailyReport> get getDailyReportList => dailyReport;
}
