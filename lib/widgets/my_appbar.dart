import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/view/cart_screen.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/view/stepper/stpper_bar.dart';

class MyAppBarWidgets {
  String appTitle;
  MyAppBarWidgets(this.appTitle);
  CartController cartController = Get.find();
  PreferredSizeWidget getMyAppBar(){
    return  AppBar(
      leading: appTitle == '' ? Container() : IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
      leadingWidth: appTitle == '' ? 0 : 30,
      title: appTitle == '' ? Container(
        height: 20,
        width: 140,
        child: GestureDetector(
          onTap: (){
            Get.off(()=>HomePage());
          },
          child: Image.asset(
            'assets/image/sabzishopicon.png',
            fit: BoxFit.contain,
          ),
        ),
      ) : Text(appTitle, style: TextStyle(color: Colors.black),),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(StepperBar());
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: (){Get.to(StepperBar());},
              color: Colors.black
            ),
            Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                cartController.cart.deals.length == 0 && cartController.cart.products.length == 0
                  ? Container()
                  : Icon(
                  Icons.circle,
                  color: ColorPalette.green,
                  ),
                  Text(
                    (cartController.cart.products.length + cartController.cart.deals.length).toString(),
                  style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ]
          ),
        )
      ],
    );
  }
}