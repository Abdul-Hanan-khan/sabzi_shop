import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/Utils/styles.dart';
import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  bool borderWidth;
  String label;
  Color backGroundColor;
  Color textColor;
  double borderRadius;
  double height;
  double width;

  GestureTapCallback onTap;
  MyLabel({
  @required this.label,
      this.onTap,
      this.borderWidth,
  this.backGroundColor,
  this.textColor,
  this.borderRadius,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 3),
              decoration: BoxDecoration(
            color: backGroundColor??ColorPalette.green,
            borderRadius: BorderRadius.circular(borderRadius??0),
          ),
            child: Center(child: Text(label,style: Styles.labelTextStyle().copyWith(
              color: textColor??Colors.white,
            ))),
          ),
        ),
      ],
    );
  }
}
