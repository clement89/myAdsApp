import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/balance/creditBalance.dart';
import 'package:myads_app/model/balance/updateBalance.dart';
import 'package:myads_app/model/balance/updateReaction.dart';
import 'package:myads_app/model/response/Graph/graphResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class ChartProvider extends BaseProvider {
  List<Views> views;
  performGetGraph(String month, int year) async {
    print("1");
    Map<String, dynamic> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'month': month,
      'year': year
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.graph, queryParameters: qParams)
        .then((response) => getSuccessResponse(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getSuccessResponse(Response response) {
    print("2");
    GraphModel _response = GraphModel.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.GRAPH);
    print("4");
  }

void setViewList(List<Views> _view){
  views = _view;
  notifyListeners();
}

  List<Views> get getViewList => views;
}
