import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as Io;

import 'package:sabzishop/Utils/styles.dart';


class Utils{
  static push(BuildContext context,Widget secondRoute){

    // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.rotate, child: secondRoute));
    //
    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: secondRoute));
    //
    // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: secondRoute));

  }

  // static Future<String> encodeImageTObase64(PickedFile pickedFile) async{
  //   // Image image= Image();
  //
  //   // final bytes = await Io.File(image).readAsBytesSync();
  //   final bytes = await Io.File(pickedFile.path).readAsBytes();
  //   return  base64.encode(bytes);
  // }

  // static decodeBase64toImageFile(){
  //
  //
  // }
  static Future<Image> decodeBase64ToImage(String base64String) async {
    var bytes = base64.decode(base64String);
  Image image = Image.memory(bytes) ;
  return image;
  }

  static void showInfoDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
    @required String positiveButtonLabel,
    String negativeButtonLabel,
    @required bool isInfo,
    @required  GestureTapCallback onPositiveClicked,
     GestureTapCallback onNegativeClicked,

  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            onPressed:onNegativeClicked,
            child: Text(
              negativeButtonLabel == null ? 'Cancel' : negativeButtonLabel,
              style:Styles.labelTextStyle().copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          isInfo != null && !isInfo
              ? FlatButton(
            onPressed: onPositiveClicked,
            child: Text(
              positiveButtonLabel == null
                  ? 'Confirm'
                  : positiveButtonLabel,
                style:Styles.labelTextStyle().copyWith(fontWeight: FontWeight.normal)
            ),
          )
              : null,
        ],
      ),
    );
  }
  static pushReplacement(BuildContext context,Widget secondRoute){
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => secondRoute),
    );
  }
  static Widget showToast(String msg){
    Fluttertoast.showToast(msg: msg,
    timeInSecForIosWeb: 5,
    );
  }
  // static screenWidth(){
  //   SharedPreferences.getInstance().then((pref) {
  //    return  pref.getDouble("screen width");
  //   });
  // }
  // static screenHeight(){
  //   SharedPreferences.getInstance().then((pref) {
  //     return  pref.getDouble("screen height");
  //   });
  // }
  // static setScreenDimentions(BuildContext context){
  //   SharedPreferences.getInstance().then((preferences) {
  //     preferences.setDouble("screen width", MediaQuery.of(context).size.width);
  //     preferences.setDouble("screen height", MediaQuery.of(context).size.height);
  //   });
  // }
}

