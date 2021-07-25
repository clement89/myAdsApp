import 'package:myads_app/utils/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:myads_app/service/callback_listener.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements OnCallBackListener {
  @override
  void onSuccess(any, {int reqId}) {

  }

  @override
  void onFailure(dynamic error) {
    ErrorHandling.errorValidation(context, error);
  }
}
