import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/interests/getInterestsResponse.dart';
import 'package:myads_app/model/response/interests/updateInterestResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class InterestProvider extends BaseProvider {
  List<Interests> interests;
  String ageGroup;
  performGetInterest() async {
    Map<String, String> qParams = {
      'type': 'interests',
      'u': await SharedPrefManager.instance.getString(Constants.userId)
    };
    await ApiManager.instance
        .getDio(isJsonType: false)
        .post(
          Endpoints.getInterest,
          queryParameters: qParams,
          options: Options(
            contentType: 'application/json',
          ),
        )
        .then((response) {
      successResponse(response);
    }).catchError(
      (e) {
        listener.onFailure(DioErrorUtil.handleErrors(e));
      },
    );
  }

  successResponse(Response response) {
    GetInterestsResponse _response =
        GetInterestsResponse.fromJson(response.data);
    listener.onSuccess(_response, reqId: ResponseIds.GET_INTEREST);
  }

  // interest list
  void setInterestList(List<Interests> _interests) {
    interests = _interests;
    notifyListeners();
  }

  List<Interests> get getInterestList {
    return interests;
  }

  //update interest
  performUpdateInterest(String interest) async {
    print("1");
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'intr': interest,
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.updateInterest, queryParameters: qParams)
        .then((response) => getUpdateInterest(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getUpdateInterest(Response response) {
    print("2");
    UpdateInterestResponse _response =
        UpdateInterestResponse.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.UPDATE_INTEREST);
    print("4");
  }
}
