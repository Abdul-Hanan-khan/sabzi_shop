import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/auth_screens/profile.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class UpdateProfile extends StatelessWidget {
  AuthController controller = Get.find();
  TextEditingController name;
  TextEditingController email;
  TextEditingController phone;

  UpdateProfile(){
    name = TextEditingController(text: controller.user.value.name);
    email = TextEditingController(text: controller.user.value.email);
    phone = TextEditingController(text: controller.user.value.phone.replaceAll('+92', ''));
  }

  RxBool progressing = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Personal Details', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              MyTextField(controller: name, label: 'Name',),
              SizedBox(height: 10,),
              MyTextField(controller: email, label: 'Email', keyboardType: TextInputType.emailAddress,),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    label: '',
                    controller: TextEditingController(text: '+92'),
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(color: Colors.grey,),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () async {
                  if(updateProfileValidation()==true){
                    progressing.value = true;
                    var response = await HttpService.updateProfile(name: name.text, email: email.text, phone: phone.text??"", customerID: controller.user.value.id);
                    progressing.value = false;
                    Fluttertoast.showToast(msg: response['msg']);
                    if(response['status']=="success")
                    {
                      if(response!=null){
                        controller.user.value.name = name.text;
                        controller.user.value.email = email.text;
                        controller.user.value.phone = '+92${phone.text}';
                      }
                      User.saveUserToCache(controller.user.value);
                      Get.off(Profile());
                    }
                  }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.green,
                  borderRadius: BorderRadius.circular(0),
                ),
                height: 40,
                width: double.infinity,
                child: Center(child: Text('Save Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
              ),
            ),
              SizedBox(height: 10,),
            ],
          ),
        ),
          ),
      ),
    );
  }


  bool updateProfileValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
    // else if
    // (!GetUtils.isEmail(email.text)){
    //   Fluttertoast.showToast(msg: 'Email format is not correct');
    //   return false;
    // }
    // else if
    // (email.text.trim().length==0){
    //   Fluttertoast.showToast(msg: 'Email is required');
    //   return false;
    // }
   else if
   (phone.text.trim().length == 0){
     Fluttertoast.showToast(msg: 'Phone Number is required');
     return false;
   }
   else if
    (phone.text.trim().length <= 9){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }
    else
      return true;
  }
}
