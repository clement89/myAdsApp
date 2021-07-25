import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/balance/creditBalance.dart';
import 'package:myads_app/model/balance/updateBalance.dart';
import 'package:myads_app/model/balance/updateReaction.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class WatchPortraitProvider extends BaseProvider {
  performAddBalance(String a, vid, time) async {
    print("1");
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'm': "2",
      'a': a,
      'vid': vid,
      'v': "0",
      "ad": time,
      "ba": "1"
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.creditAmount, queryParameters: qParams)
        .then((response) => getSuccessResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getSuccessResponse(Response response) {
    print("2");
    CreditBalance _response = CreditBalance.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.CREDIT_BALANCE);
    print("4");
  }

// void setMemberList(List<Members> memberList){
//   _members = memberList;
//   notifyListeners();
// }
//
// List<Members> get getMemberList => _members;

  performUpdateBalance(String time, balance, videoId,multiplyId,badgeId) async {
    print("Updating balance time " + time + " " + balance + " " + videoId);

    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      't': time,
      'b': balance,
      'v': videoId,
      'badge': badgeId,
      'multiply': multiplyId,
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.updateTimeBlns, queryParameters: qParams)
        .then((response) => getUpdateBalanceResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  performUpdateReaction(String reaction, videoId) async {
    print("entered reaction");
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'v': videoId,
      'r': reaction
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.updatereaction, queryParameters: qParams)
        .then((response) => getReaction(response))
        .catchError((onError) {
      print("reaction error");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
    });
  }

  getUpdateBalanceResponse(Response response) {
    print("2");
    UpdateBalanceTimeResponse _response =
        UpdateBalanceTimeResponse.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.UPDATE_BALANCE);
    print("4");
  }

  getReaction(Response response) {
    UpdateReaction res = UpdateReaction.fromJson(response.data);
    print("getreaction");
    listener.onSuccess(res, reqId: ResponseIds.UPDATE_REACTION);
  }
}
