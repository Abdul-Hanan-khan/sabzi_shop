import 'package:cached_map/cached_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/view/intro/slider_screen.dart';
import 'auth_screens/login screen.dart';


class SplashScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    navigate();
    return Scaffold(
      body: Center(
        child: Container(
          width: 180,
          height: 180,
          child: Image.asset("assets/image/logo.png",)
        ),
      ),
    );
  }


  navigate() async {
    await Future.delayed(Duration(seconds: 1));
    Mapped.loadFileDirectly(cachedFileName: "slider").then((file) {
      if(file==null){
          Get.off(SliderScreen());
      }
      else
      {
        Get.off(()=> HomePage());
      }
    });
  }
}
