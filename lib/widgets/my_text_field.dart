import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/Utils/styles.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String label;
  bool obsecureText =false;
  IconButton suffixIcon;
  IconButton prefixIcon;
  final ValueChanged<String> onChanged;
  Function onEditingComplete;
  GestureTapCallback onTap;
  bool enabled=true;
  int maxLines;
  String hintText;
  TextInputType keyboardType;
  bool autoFocus;
  double height;
  double width;
  int maxLength;
  FocusNode focusNode;
  bool phoneNumber=false;
  double fontSize;
  Color hintColor;
  ///Constructor
  MyTextField({
    @required this.controller,
    @required this.label,
    this.obsecureText,
    this.onChanged,
    this.suffixIcon,
    this.onEditingComplete,
    this.enabled,
    this.onTap,
    this.maxLines,
    this.hintText,
    this.keyboardType,
    this.autoFocus,
    this.height,
    this.width,
    this.maxLength,
    this.focusNode,
    this.phoneNumber,
    this.fontSize,
    this.hintColor,
    this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordVisible = false;
    return Container(
      height: height??45,
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          focusNode: focusNode,
          maxLength: maxLength,
          autofocus: autoFocus??false,
          keyboardType: keyboardType,
          maxLines: maxLines??1,
          enabled: enabled,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onChanged:onChanged,
          controller: controller,
          obscureText: obsecureText??false,
          cursorColor: ColorPalette.green,
          style: phoneNumber??false ? Styles.phoneNumberTextStyle() : Styles.textFieldTextStyle().copyWith(fontSize: fontSize??15),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: ColorPalette.green,
              focusColor: ColorPalette.green,
              hoverColor: ColorPalette.green,
              labelText: label,
              hintStyle:TextStyle(
                color:  Colors.black54,
                fontSize: 12
              ),
              labelStyle: TextStyle(
                color:hintColor ?? ColorPalette.green,
                fontSize: 16
              ),
              disabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.green
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.green
                  )
              ),
              focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorPalette.green
                  )
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.green
                )
              ),
              // hintText: label,
          ),
        ),
      ),
    );
  }
}
