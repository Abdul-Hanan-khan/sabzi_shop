import 'package:sabzishop/Settings/color_palates.dart';
import 'package:flutter/material.dart';
class MyOutlinedButton extends StatelessWidget {

  @override
  String txt;
  GestureTapCallback ontap;
  Color borderColor = ColorPalette.orange;
  Color txtColor = ColorPalette.orange;
  double leftRightpadding;

  MyOutlinedButton({
    this.txt,
    this.ontap,
    this.leftRightpadding,
    this.borderColor,});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding:  EdgeInsets.only(left: leftRightpadding??0,  right:leftRightpadding?? 0),
        child: InkWell(
          borderRadius:  BorderRadius.circular(80.0),
          onTap: ontap,
          splashColor: Colors.white,
          child: LayoutBuilder(builder: (context, constraint) {
            return Container(
              height: 45.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor??ColorPalette.orange,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(80.0),
                color: Colors.transparent,
              ),
              child: Center(
                  child: Text(
                    txt,
                    style: TextStyle(
                        color: txtColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Sofia",
                        letterSpacing: 0.9),
                  )),
            );
          }),
        ),
      ),
    );
  }
}
