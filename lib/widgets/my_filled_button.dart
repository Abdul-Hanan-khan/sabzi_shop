import 'package:sabzishop/Settings/color_palates.dart';
import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  @override
  String txt="button";
  GestureTapCallback ontap;
  Color color;
  Color gradient1=ColorPalette.green;
  Color gradient2=ColorPalette.orange;
  Color borderColor=ColorPalette.border;
  double leftRightpadding;
  double borderRadius;
  double width;
  double height;
  Color txtColor;

  MyFilledButton({this.txt, this.ontap,this.leftRightpadding,this.borderRadius, this.width,this.color, this.height, this.txtColor});

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
          padding:  EdgeInsets.only(left: leftRightpadding??0,  right:leftRightpadding?? 0),
          child: InkWell(
            splashColor: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius??80.0),
            onTap: ontap,
            child: Ink(
              height: height??40,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: color??borderColor,
                ),
                borderRadius: BorderRadius.circular(borderRadius??80.0),
                gradient: LinearGradient(colors: [
                 color?? gradient1,
                  color?? gradient2,
                ]),
              ),
              child: Center(
                  child: Text(
                    txt,
                    style: TextStyle(
                        color: txtColor?? Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
//                        fontFamily: "Sofia",
                        letterSpacing: 0.9),
                  )),
            ),
          ),
        ),
    );
  }
}
