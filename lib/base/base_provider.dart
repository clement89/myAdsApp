import 'package:flutter/material.dart';
import 'package:myads_app/base/base_modal.dart';
import 'package:myads_app/service/callback_listener.dart';


abstract class BaseProvider<T extends BaseModal> with ChangeNotifier{

  OnCallBackListener listener;
  OnCallBackListener1 listener1;


}