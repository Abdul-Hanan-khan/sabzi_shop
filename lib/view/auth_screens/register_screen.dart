import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/my_google_map_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  MyGoogleMapController mapController = Get.find();
  RegisterScreenController controller = RegisterScreenController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
      ),
      body: Obx(
        ()=> ModalProgressHUD(
          inAsyncCall: authController.progressing.value,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 25,),
                MyTextField(controller: name, label: "Name", fontSize: 18,),
                SizedBox(height: 12,),
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextField(controller: TextEditingController(text: "+92"), label: "", width: 65,),
                    SizedBox(width: 2,),
                    Expanded(
                      child: MyTextField(
                        height: 65,
                        fontSize: 18,
                        maxLength: 10,
                        controller: phone,
                        label: "Phone",
                        keyboardType: TextInputType.phone,
                        onChanged: (txt) {
                          if(txt.length==1 && txt=="0")
                          {
                            phone.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                MyFilledButton(txt: "Register",borderRadius: 0,color: ColorPalette.green,
                ontap: (){
                  if(controller.validate(name, phone)){
                    authController.register(name: name.text,email: "",phone: phone.text,colonyId: mapController.selectedColony.id,address: mapController.getFullAddress(),manualAddress: mapController.manualAddress.text,postCode: "",city: "");
                  }
                },
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
