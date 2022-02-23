import 'package:flutter/material.dart';
import 'package:sabzishop/Settings/color_palates.dart';

class Styles{

  static TextStyle textFieldlabelTextStyle(){
   return TextStyle(
     fontSize: 15,
        fontWeight: FontWeight.normal,
        color: ColorPalette.orange
    );
  }
  static TextStyle textFieldTextStyle(){
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: ColorPalette.dark
    );
  }
  static TextStyle labelTextStyle(){
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: ColorPalette.orange
    );
  }
  static TextStyle homeScreenListItemTextStyle(){
    return TextStyle(
        color: Colors.blue[700],
      fontSize: 15,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle phoneNumberTextStyle(){
    return TextStyle(
        fontSize: 20,
        letterSpacing: 3
      // fontWeight: FontWeight.bold
    );
  }

}