import 'package:dio/dio.dart';
import 'package:myads_app/Constants/constants.dart';
import 'package:myads_app/Constants/response_ids.dart';
import 'package:myads_app/base/base_provider.dart';
import 'package:myads_app/model/response/streams/getStreamsResponse.dart';
import 'package:myads_app/model/response/streams/updateStreamResponse.dart';
import 'package:myads_app/service/api_manager.dart';
import 'package:myads_app/service/dio_error_util.dart';
import 'package:myads_app/service/endpoints.dart';
import 'package:myads_app/utils/shared_pref_manager.dart';

class StreamsProvider extends BaseProvider {
  List<StreamList> streamList;
  performGetStream() async {
    Map<String, String> qParams = {
      'type': 'stream',
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
    GetStreamResponse _response = GetStreamResponse.fromJson(response.data);
    listener.onSuccess(_response, reqId: ResponseIds.GET_STREAM);
  }

  // set stream list
  void setStreamList(List<StreamList> _streams) {
    streamList = _streams;
    notifyListeners();
  }

  // get stream list
  List<StreamList> get getStreamList => streamList;

  //update streams
  performUpdateStream(String interest) async {
    print("1");
    Map<String, String> qParams = {
      'u': await SharedPrefManager.instance.getString(Constants.userId),
      'stream': interest,
      'formNo': '4'
    };
    await ApiManager()
        .getDio(isJsonType: false)
        .post(Endpoints.updateStream, queryParameters: qParams)
        .then((response) => getUpdateStream(response))
        .catchError((onError) {
      print("5");
      listener.onFailure(DioErrorUtil.handleErrors(onError));
      print("6");
    });
  }

  getUpdateStream(Response response) {
    print("2");
    UpdateStreamResponse _response =
        UpdateStreamResponse.fromJson(response.data);
    print("3");
    listener.onSuccess(_response, reqId: ResponseIds.UPDATE_STREAM);
    print("4");
  }
}
