import 'dart:io';

import 'package:cached_map/cached_map.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sabzishop/controller/ForgotPassword.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/auth_screens/otp_screen.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';

class AuthController extends GetxController{
  BottomBarController bottomBarController = Get.find();
  Rx<User> user= User().obs;
  RxBool isLogedIn = false.obs;
  RxBool progressing = false.obs;
  RxBool checkBoxValue = false.obs;
  RxInt selectedRadio= 0.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController colony = TextEditingController();

  @override
  Future<void> onInit() async {
    await loadUser();
    isLogedIn.value = user.value == null ? false : true;
    print(isLogedIn.value);
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> loadUser() async {
   var json = await Mapped.loadFileDirectly(cachedFileName: "user");
   if(json==null)
    user.value = null;
   else
   user.value = User.fromJson(json);
  }
  setSelectedRadio(int value){
    selectedRadio.value = value;
  }

  void login({String number}) async {
    progressing.value = true;
    AuthResponse response = await HttpService.loginUser(number);
    progressing.value = false;
    if(response.user==null){
      Fluttertoast.showToast(msg: response.msg);
    }else
    {
      Get.offAll(OtpScreen(userID:response.user.id));
      //TODO: remove this line after testing
      print('opt:${response.user.otp}');
      Clipboard.setData(ClipboardData(text: response.user.otp));
      Utils.showToast(response.msg);
    }
  }

  void verifyOtp({String otp, String id}) async {
    progressing.value = true;
    AuthResponse response = await HttpService.verifyOtp(
        customerId: id, otp: otp,
    );
    progressing.value = false;
    if(response.status == 'success'){
      user.value = response.user;
      User.saveUserToCache(response.user);
      sendToken(user.value.id);
      isLogedIn.value = true;
      Utils.showToast(response.msg);
      bottomBarController.currentBNBIndex.value = 1;
      Get.off(HomePage());
    }else {
      Utils.showToast(response.msg);
    }
  }

  logOut(){
    deleteToken();
    user.value = null;
    User.deleteCachedUser();
    isLogedIn.value = false;
  }


  void register({String name, String email, String phone, String colonyId, String address, String manualAddress , String postCode, String city})async {
      progressing.value = true;
      AuthResponse response = await HttpService.registerUser(
          name,
          email,
          phone,
          colonyId,
          address,
          manualAddress,
          postCode,
          city,
      );
      progressing.value = false;
      if(response.user==null){
        Utils.showToast(response.msg);
      }
      else
      {
        // this.user.value = response.user;
//        User.saveUserToCache(response.user);
        Clipboard.setData(ClipboardData(text: response.user.otp));
        print("otp:${response.user.otp}");
        Get.offAll(() => OtpScreen(userID: response.user.id,));
        Utils.showToast(response.msg);

      }
  }

  void forgotPassword({String email}) async {
      progressing.value = true;
      ForgotPasswordResponse response = await HttpService.forgotPassword(
        email,
      );
      progressing.value = false;
      if(response!=null){
        Fluttertoast.showToast(msg: response.msg);
      }
      else
      {
        Fluttertoast.showToast(msg: response.msg);
        Get.back();
      }
  }

  updateUser(User updatedUSer){
    this.user.value = updatedUSer;
    User.saveUserToCache(updatedUSer);
  }

  sendToken(String id) async {
    String token = await  FirebaseMessaging.instance.getToken();
    String deviceID = await getDeviceId();
    String status = await HttpService.createToken(id, deviceID, token);
    print("notification status: $status");
  }

  deleteToken() async {
    String deviceID = await getDeviceId();
    HttpService.deleteToken(deviceID);
  }

  static Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }



//  void updateProfile() async {
//    progressing.value = true;
//    String response = await HttpService.updateProfile();
//    progressing.value = false;
//    if(response==null){
//      Fluttertoast.showToast(msg: response.msg);
//    }
//    else
//    {
//      this.name.clear();
//      this.email.clear();
//      User.saveUserToCache(response.user);
//      user.value = response.user;
//      isLogedIn.value = true;
//      Get.off(OrderScreen());
//
//    }
//  }





}