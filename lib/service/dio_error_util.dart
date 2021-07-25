import 'package:dio/dio.dart';
import 'package:myads_app/model/response/base_response.dart';

class DioErrorUtil {
  static BaseResponse handleErrors(dynamic error) {
    BaseResponse response = BaseResponse();

    print("iter 0");

    try {
      if (error is DioError) {
        DioError dioError = error;
        if (error.type == DioErrorType.DEFAULT) {
          print("iter 0");
          response.status = "failed";
          response.message = 'network error';
        } else if (dioError.response != null &&
            dioError.response.data != null) {
          print("iter 01");
          response = BaseResponse.fromJson(dioError.response.data);
        } else {
          print("iter 02");
          response.status = "failed";
          response.message = dioError.message;
        }
      } else {
        response.status = "failed";
        response.message = error;
      }
    } catch (exception) {
      print("iter 04");
      response.status = "failed";
      response.message =
          exception.toString() != null ? exception.toString() : 'error';
    }
    print(response.message.toString());
    return response;
  }
}
