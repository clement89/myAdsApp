import 'package:flutter/material.dart';
import 'package:myads_app/UI/Widgets/progressbar.dart';

import 'code_snippet.dart';

class ErrorHandling {
  static void errorValidation(BuildContext context,dynamic response) {
    ProgressBar.instance.hideProgressBar();
    CodeSnippet.instance.showAlertMsg(response.message);
  }
}
