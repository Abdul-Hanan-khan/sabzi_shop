import 'dart:convert';
import 'dart:io';
import 'package:package_info/package_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/FCM/configure_fcm.dart';
import 'package:sabzishop/Utils/httpHelper.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/deal_screen_controller.dart';
import 'package:sabzishop/controller/home_screen_controller.dart';
import 'package:sabzishop/controller/product_screen_controller.dart';
import 'package:sabzishop/widgets/url_launcher_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sabzishop/update_prompt/update_prompt_screen.dart';
import 'package:sabzishop/view/dummy/dummy_order_history.dart';
import 'package:sabzishop/view/home_screen_and_tabs/account_screen_tab.dart';
import 'package:sabzishop/view/home_screen_and_tabs/deal_screen_tab.dart';
import 'package:sabzishop/view/home_screen_and_tabs/home_screen_tab.dart';
import 'package:sabzishop/view/home_screen_and_tabs/product_screen_tab.dart';
import 'package:sabzishop/widgets/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomBarController bottomController = Get.put(BottomBarController());
  DealScreenController dealScreenController = Get.put(DealScreenController());
  ProductScreenController productScreenController = Get.put(ProductScreenController());
List _tabs = [
    HomeScreenTab(),
    ProductScreenTab(),
    DealScreenTab(),
    AccountScreenTab(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _checkUpdates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FCM.configureFCM();
    getToken();
    return Scaffold(
      body:Obx(
        ()=>_tabs[bottomController.currentBNBIndex.value]
      ),
      bottomNavigationBar: BottomNavigateBar(),
    );
  }

  getToken(){
    FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });
  }


  _checkUpdates() async{
    var latestVersion;
    int appVersion = await _getVersion();
    SharedPreferences pref = await SharedPreferences.getInstance();

    var response;
    try{
      response = await HttpHelper.post(body: {
        "app_update" : '1',
      });
      latestVersion = Platform.isAndroid? jsonDecode(response.body)["android_update"]
          :jsonDecode(response.body)["ios_update"];
      print("latest version: $latestVersion");
      pref.setString("latestVersion", latestVersion);
    }

    catch(e){}
    latestVersion = pref.getString("latestVersion");
    if(latestVersion!=null)
    {
      latestVersion = latestVersion.split(".")[0]+latestVersion.split(".")[1]+latestVersion.split(".")[2];
    }
    print("latest pref version: $latestVersion");
    if (latestVersion != null && appVersion != null && int.parse(latestVersion) > appVersion) // todo change the bool statement to >
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> UpdatePromptScreen()));

  }


  ///getting current version of the App
  Future<int> _getVersion() async {
    int version;
    List versions;
    final packageInfo = await PackageInfo.fromPlatform();
    print("Current version:"+packageInfo.version);
    versions= packageInfo.version.split(".");
    return int.parse(versions[0]+versions[1]+versions[2]);
  }

}