import 'dart:io';

import 'package:file_picker/file_picker.dart';

class AppService {


  Future<File> getFile({FileType fileType,}) {
    return FilePicker.getFile(type: fileType);
  }

  Future<String> getFilePath({FileType fileType}) {
    return FilePicker.getFilePath(type: fileType);
  }

//  Future<List<String>> getMultipleFilePath({FileType fileType}) {
//    return FilePicker.get(type: fileType);
//  }
}