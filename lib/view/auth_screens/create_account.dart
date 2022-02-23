import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/my_google_map_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/view/home_screen_and_tabs/product_screen_tab.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/view/my_google_map.dart';
import 'package:sabzishop/widgets/my_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';


class CreateAccount extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController code = TextEditingController(text: "+92");
  User user = User();
  FocusNode phoneFocus = FocusNode();

  MyGoogleMapController _myGoogleMapController = MyGoogleMapController(latlng: LatLng(31.4504, 73.1350).obs);
  RegisterScreenController controller = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchingAddress.value = true;
    controller.loadCurrentLocation().then((value) async  {
      _myGoogleMapController.latlng.value = controller.latlng;
      String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
      address.clear();
      controller.fetchingAddress.value = false;
      address.text = formated_address;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Create Account', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: authController.progressing.value? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 250,
                  child: Image.asset(
                    'assets/image/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                MyTextField(controller: name, label: 'Name',),
                SizedBox(height: 10),
                MyTextField(controller: email, label: 'Email', keyboardType: TextInputType.emailAddress,),
                SizedBox(height: 10),
                Row(
                  children: [
                    MyTextField(
                      label: '',
                      controller: code,
                      width: 75,
                      // height: 65,
                      phoneNumber: true,
                      enabled: false,
                      keyboardType: TextInputType.none,
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: MyTextField(
                        controller: phone,
                        label: 'Phone Number Without Leading 0',
                        keyboardType: TextInputType.number,
                        // height: 65,
                        phoneNumber: true,
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
                SizedBox(height: 10),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    MyTextField(
                      controller: colony,
                      label: "Colony",
                      enabled: false,
                    ),
                    Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        // value: _prefferedDurationOfLesson,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 3.0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: ColorPalette.green,
                          ),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: ColorPalette.green),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (newValue) {
                        colony.text = newValue;
                        controller.selectedColony= controller.colonies.firstWhere((element) => element.name == colony.text);
                        },
                        items: controller.colonies.map((e) => e.name).toList()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                MyTextField(
                  height: 100,
                  maxLines:5,
                  controller: address, label: 'Address',
                  suffixIcon: IconButton(
                    icon: controller.fetchingAddress.value == true?Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2,)):GestureDetector(
                        onLongPress: () async {
                          controller.fetchingAddress.value = true;
                          String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                          address.clear();
                          controller.fetchingAddress.value = false;
                          address.text = formated_address;
                        },
                        child: Icon(Icons.add_location, size: 30,)),
                    color: ColorPalette.green,
                    onPressed: (){
                      controller.loadCurrentLocation().then((value) {
                        // Future<Address> reverseGeocoding({double latitude, double longitude});
                        // address.text = controller.latlng.toString();
                        Get.dialog(Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              child: MyGoogleMap(controller:_myGoogleMapController),
                            ),
                            ElevatedButton(child:Icon(Icons.done),
                              onPressed: () async {
                                Get.back();
                                controller.fetchingAddress.value = true;
                                String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                                address.clear();
                                address.text = formated_address;
                                controller.fetchingAddress.value = false;
                              },),
                          ],
                        ));
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                MyTextField(controller: postcode, label: 'Post Code', keyboardType: TextInputType.number,),
                SizedBox(height: 10),
                MyTextField(controller: city, label: 'City',),
                SizedBox(height: 10),
                MyFilledButton(
                  txt: 'Register',
                  width: double.infinity,
                  color: ColorPalette.green,
                  borderRadius: 10,
                  ontap: () async {
                    final signCode = await SmsAutoFill().getAppSignature;
                    print(signCode);
                    if(registerValidation()) {
                      authController.register(
                        name: name.text,
                        email: email.text,
                        postCode: postcode.text,
                        city: city.text,
                        phone: phone.text,
                        address: address.text,
                        colonyId: controller.selectedColony.id,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool registerValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (!GetUtils.isEmail(email.text)){
      Fluttertoast.showToast(msg: 'Email format is not correct');
      return false;
    }
    else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (phone.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    } else if
    (phone.text.trim().length <= 9){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }else if
    (address.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Address is required');
      return false;
    }else if
    (postcode.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Post Code is required');
      return false;
    }else if
    (city.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
}
