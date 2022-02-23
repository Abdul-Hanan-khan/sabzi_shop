import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/update_prompt/ClickType.dart';
import 'package:sabzishop/update_prompt/utills.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'button_click_contracts.dart';

class UpdatePromptScreen extends StatefulWidget {
  @override
  _UpdatePromptScreenState createState() => _UpdatePromptScreenState();
}

class _UpdatePromptScreenState extends State<UpdatePromptScreen> implements IFilledButtonClicked{
  String storeName;
  String storeUrl;
  @override
  void initState() {
    // TODO: implement initState
    storeName=Platform.isAndroid?"Play Store":"App Store";
    storeUrl=_getStoreURL();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        // targetObject: null,
        title: const Text('Upgrade Available'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  child: Image.asset("assets/image/logo.png",width: 250,height: 250,)),
              SizedBox(height: 20,),
              Text( "An updated version is available on the $storeName, Please click the button below to update your App.",
                style: TextStyle(
                  fontSize: 18,
                ),),
              SizedBox(height: 20,),
              Utills.getFilledButton(context, "Update", this, ClickType.UPDATE_APP,ColorPalette.green)
            ],
          ),
        ),
      ),
    );
  }

  _getStoreURL(){
    if(Platform.isAndroid)
      return "https://play.google.com/store/apps/details?id=com.sbs.sabzishop";
    else
      return "https://apps.apple.com/gb/app/lsuk/id1545528069";
  }
  @override
  void onFilledButtonClick(ClickType clickType) {
    _openStoreUrl(context);
    SharedPreferences.getInstance().then((pref) {
      pref.setString("latestVersion", null);
    });
    // TODO: implement onFilledButtonClick
  }
  void _openStoreUrl(BuildContext context) async {
    if (storeUrl == null) {
      return null;
    }

    try {
      if (await canLaunch(storeUrl)) {
        await launch(storeUrl, forceSafariVC: false);
        // Utils.pushReplacement(context, HomeScreen());
        Get.off(HomePage());
      }
    } on PlatformException {
      Fluttertoast.showToast(msg: "There is some problem with your App, Kindly update manually from $storeName");
    }
  }
}
