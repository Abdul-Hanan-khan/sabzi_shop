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
import 'package:sabzishop/view/my_google_map.dart';
import 'package:sabzishop/view/auth_screens/profile.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class AdressInformation extends StatelessWidget {
  MyGoogleMapController _myGoogleMapController = MyGoogleMapController(latlng: LatLng(31.4504, 73.1350).obs);
  RegisterScreenController registerController = Get.put(RegisterScreenController());
  AuthController controller = Get.find();

  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController colony = TextEditingController();

  @override
  Widget build(BuildContext context) {
    registerController.fetchingAddress.value = true;
    registerController.loadCurrentLocation().then((value) async  {
      _myGoogleMapController.latlng.value = registerController.latlng;
      String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
      address.clear();
      registerController.fetchingAddress.value = false;
      address.text = formated_address;
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Address Details', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => controller.progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                MyTextField(
                  height: 100,
                  maxLines:5,
                  controller: address, label: 'Address',
                  suffixIcon: IconButton(
                    icon: registerController.fetchingAddress.value == true?Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2,)):GestureDetector(
                        onLongPress: () async {
                          registerController.fetchingAddress.value = true;
                          String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                          address.clear();
                          registerController.fetchingAddress.value = false;
                          address.text = formated_address;
                        },
                        child: Icon(Icons.add_location, size: 35,)),
                    color: ColorPalette.green,
                    onPressed: (){
                      registerController.loadCurrentLocation().then((value) {
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
                                registerController.fetchingAddress.value = true;
                                String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
                                address.clear();
                                address.text = formated_address;
                                registerController.fetchingAddress.value = false;
                              },),
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
                          registerController.selectedColony= registerController.colonies.firstWhere((element) => element.name == colony.text);
                        },
                        items: registerController.colonies.map((e) => e.name).toList()
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
                    if(addAddressValidation()){
                      controller.progressing.value = true;
                      var response = await HttpService.addAdress(
                        customerId: controller.user.value.id,
                        colonyId: registerController.selectedColony.id,
                        address: address.text,
                        city: city.text,
                        postCode: postcode.text,
                      );
                      controller.progressing.value = false;
                      Utils.showToast(response['msg']);
                      if(response['status']=="success")
                        {
                          if ( response != null) {
                            controller.user.value.addresses.clear();
                            response['record']['addresses'].forEach((v) {
                              controller.user.value.addresses.add(new Address.fromJson(v));
                            });
                          }

                          User.saveUserToCache(controller.user.value);
                        }
                      Get.back();
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

  bool addAddressValidation(){
    if(address.text.trim().length==0){
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
