import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/my_google_map_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/auth_screens/profile.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';
import 'package:sabzishop/view/my_google_map.dart';

class EditAddress extends StatelessWidget {

  Address address;
  AuthController authController = Get.find();
  TextEditingController addressController;
  TextEditingController city;
  TextEditingController postcode;
  TextEditingController colony;
  RegisterScreenController registerScreenController = Get.find();
  MyGoogleMapController _myGoogleMapController = MyGoogleMapController(latlng: LatLng(31.4504, 73.1350).obs);
  @override

  EditAddress({this.address}) {
   int index = authController.user.value.addresses.indexWhere((element) => element.id == address.id);
   city = TextEditingController(text: authController.user.value.addresses[index].city);
   addressController = TextEditingController(text: authController.user.value.addresses[index].address);
   postcode = TextEditingController(text: authController.user.value.addresses[index].postcode);
   colony = TextEditingController(text: authController.user.value.addresses[index].colonyName);
  }
  Widget build(BuildContext context) {
    registerScreenController.fetchingAddress.value = true;
//    registerScreenController.loadCurrentLocation().then((value) async  {
//      _myGoogleMapController.latlng.value = registerScreenController.latlng;
//      String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
//      addressController.clear();
//      registerScreenController.fetchingAddress.value = false;
//      addressController.text = formated_address;
//    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Edit Address', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
          child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10,),
          MyTextField(
            height: 100,
            maxLines:5,
            controller: addressController, label: 'Address',
            suffixIcon: IconButton(
              icon: GestureDetector(
                onLongPress: () async {
                  registerScreenController.fetchingAddress.value = true;
                  String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                  addressController.clear();
                  registerScreenController.fetchingAddress.value = false;
                  addressController.text = formated_address;
                },
                child: Icon(Icons.add_location, size: 35,)
              ),
              color: ColorPalette.green,
              onPressed: (){
              registerScreenController.loadCurrentLocation().then((value) {
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
                          registerScreenController.fetchingAddress.value = true;
                          String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                          addressController.clear();
                          addressController.text = formated_address;
                          registerScreenController.fetchingAddress.value = false;
                        },
                      ),
                    ],
                  ));
                });
              },
            ),
          ),
          SizedBox(height: 10,),
          MyTextField(controller: city, label: 'City',),
          SizedBox(height: 10,),
          MyTextField(controller: postcode, label: 'Post Code', keyboardType: TextInputType.number,),
          SizedBox(height: 10,),
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
                    registerScreenController.selectedColony= registerScreenController.colonies.firstWhere((element) => element.name == colony.text);
                  },
                  items: registerScreenController.colonies.map((e) => e.name).toList()
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
          Divider(),
          SizedBox(height: 10,),
          MyFilledButton(
            txt: 'Submit',
            width: double.infinity,
            color: ColorPalette.green,
            borderRadius: 0,
            ontap: () async {
              if(editAddressValidation()){
                authController.progressing.value = true;
                var response = await HttpService.editAddress(
                  postCode: postcode.text,
                  city: city.text,
                  addressId: address.id,
                  address: addressController.text,
                  colonyId: address.colonyId
                );
                authController.progressing.value = false;
                Utils.showToast(response['msg']);
                if(response['status']=="success")
                {
                  if (response != null) {
                    int index = authController.user.value.addresses.indexWhere((element) => element.id == address.id);
                    authController.user.value.addresses[index].address = addressController.text;
                    authController.user.value.addresses[index].colonyName = colony.text;
                    authController.user.value.addresses[index].postcode = postcode.text;
                    authController.user.value.addresses[index].city = city.text;
                  }
                  User.saveUserToCache(authController.user.value);
                }
                Get.off(Profile());
              }
            },
          ),
        ],
      ),
          ),
        ),
    );
  }

  bool editAddressValidation(){
    if(addressController.text.trim().length==0){
      Utils.showToast('Address is Required');
      return false;
    }else if
    (city.text.trim().length==0){
      Utils.showToast('City is Required');
      return false;
    }
    else
      return true;
  }
}
