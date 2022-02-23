

import 'package:flutter/material.dart';

/// Button Custom widget
class ButtonCustom extends StatelessWidget {
  @override
  String txt;
  GestureTapCallback ontap;
  Color gradient1;
  Color gradient2;
  Color border;

  ButtonCustom({this.txt, this.gradient1, this.gradient2, this.border});

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 52.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: border,
                ),
                borderRadius: BorderRadius.circular(80.0),
                // gradient: LinearGradient(colors: [
                //   gradient1,
                //   gradient2,
                // ]),
              ),
              child: Center(
                  child: Text(
                    txt,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Sofia",
                        letterSpacing: 0.9),
                  )),
            ),
          );
        }),
      ),
    );
  }
}