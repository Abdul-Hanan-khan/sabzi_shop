import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Forgot Password', style: TextStyle(color: Colors.black,),),
      ),
      body: Obx(
          () => controller.progressing.value ? Center(child: CircularProgressIndicator()) : Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              MyTextField(controller: email, label: 'Email', keyboardType: TextInputType.emailAddress,),
              SizedBox(height: 10),
              MyFilledButton(
                txt: 'Send Password',
                width: double.infinity,
                color: ColorPalette.green,
                borderRadius: 10,
                ontap: () {
                  if(forgotPasswordValidation()){
                    controller.forgotPassword(email: email.text);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool forgotPasswordValidation() {
    if(email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }
    else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else
      return true;
  }
}
