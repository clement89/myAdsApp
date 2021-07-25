import 'package:myads_app/model/response/base_response.dart';

abstract class OnCallBackListener{

  void onSuccess(dynamic any , {int reqId});
  // void onsampleSucess(dynamic any);

  void onFailure(BaseResponse baseResponse);
}
abstract class OnCallBackListener1{

  void onsampleSucess(dynamic any);

  
}