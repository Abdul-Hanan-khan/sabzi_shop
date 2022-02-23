import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/auth_screens/forgot_password.dart';
import 'package:sabzishop/view/my_google_map.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  AuthController authController = Get.find();
  TextEditingController code = TextEditingController(text: "+92");
  TextEditingController phone = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Sign In', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => ModalProgressHUD(
            inAsyncCall: authController.progressing.value ,
            child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 250,
                  child: Image.asset(
                    'assets/image/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      label: '',
                      controller: code,
                      width: 65,
                      // phoneNumber: true,
                      enabled: false,
                      keyboardType: TextInputType.none,
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      child: MyTextField(
                        height: 64,
                        maxLength: 10,
                        controller: phone,
                        label: 'Phone Number Without Leading 0',
                        keyboardType: TextInputType.number,

                        // phoneNumber: true,
                        onChanged: (val){
                          if(val.length<2 && phone.text==0.toString()){
                            phone.clear();
                          }
                        },
                        // width: 40,
//                     focusNode: phoneFocus,
//                     onChanged: (val){
//                       if(val.length < 4){
//                         phone.text = "+92";
//                         phoneFocus.unfocus();
// //                      phoneFocus.requestFocus();
//                       }
//                     },
//                     autoFocus: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                MyFilledButton(
                  txt: 'Login',
                  width: double.infinity,
                  color: ColorPalette.green,
                  borderRadius: 0,
                  ontap: () {
                    if(loginValidation()){
                      authController.login(number: phone.text);
                    }
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a Member? ', style: TextStyle(fontSize: 18),),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=>MyGoogleMap());
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorPalette.green
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
          ),
      ),
    );
  }

  bool loginValidation(){
    if (phone.text.trim().length == 0){
    Fluttertoast.showToast(msg: 'Phone Number is required');
    return false;
    }
    else if (phone.text.trim().length <= 9){
    Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
    return false;
    }
    else
      return true;
  }
}
