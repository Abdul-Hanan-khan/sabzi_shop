//import 'dart:convert';
//import 'dart:io';
//
//import 'package:file_picker/file_picker.dart';
//import 'package:flutter/cupertino.dart';
//
//class MyFilePicker   {
//
//String _identityFileExtension;
//File _identityFile;
//// String base64Encode;
//
//
//  static Future<String>  pickfileinbase64() async {
//    String _identityFileExtension;
//    File _identityFile;
//
//    FilePickerResult result = await FilePicker.platform.pickFiles(
//      allowMultiple: false,
//      type: FileType.custom,
//      allowedExtensions: [
//        'jpg',
//        'pdf',
//        // 'doc',
//
//        'png'
//      ],
//    );
//
//
//
//
//    _identityFileExtension = result.files.first.extension;
//
//    _identityFile = File(result.files.first.path);
//
//   return  base64Encode(_identityFile.readAsBytesSync());
//
//  }
//
//}
//
//
//
