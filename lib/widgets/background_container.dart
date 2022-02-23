import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  Widget child;
  BackgroundContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: child,
      margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
          colors: <Color>[
            Color(0xFF1E2026).withOpacity(0.1),
            Color(0xFF1E2026).withOpacity(0.1),
            Color(0xFF1E2026).withOpacity(0.3),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),

      /// Set component layout
    );
  }
}
