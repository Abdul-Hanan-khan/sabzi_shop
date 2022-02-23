import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/my_google_map_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/auth_screens/create_account.dart';
import 'package:sabzishop/view/auth_screens/register_screen.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_label.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class MyGoogleMap extends StatelessWidget {

  // MyGoogleMapController controller = Get.find();


  String customerID ;
  String  addressID ;
  String address;
  String manualAddress;
  Colony colony;
  bool goBackToPlaceORderScreen;

   MyGoogleMap({var controller,this.customerID,this.addressID,this.address,this.manualAddress,this.colony,this.goBackToPlaceORderScreen}){
   }
  MyGoogleMapController controller = Get.put(MyGoogleMapController(latlng: LatLng(31.4504, 73.1350).obs));
   AuthController authController = Get.find();


  @override
  Widget build(BuildContext context) {
if(address!=null)
  {
    controller.editingAddress = true;
    controller.currentAddress.value = address;
    controller.manualAddress.text = manualAddress;
    controller.streetHouseNo.text = "${address.split(",")[0]},${address.split(",")[1]}";
    controller.colony.text = colony.name;
    controller.selectedColony = colony;
  }

    return Scaffold(
        bottomSheet: BottomSheet(
          onClosing: (){},
          builder: (context){
            return ModalProgressHUD(
              inAsyncCall: controller.progressing.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100)
                ),
                height: 260,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: ColorPalette.green,),
                          SizedBox(width: 10,),
                          Container(
                            width: Get.width*0.855,
                            child:
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                enabled: false,
                                style: TextStyle(
                                    fontSize: 14
                                ) ,
                                controller: controller.streetHouseNo,
                                keyboardType: TextInputType.none,
                              ),



                          ),
                          // MyLabel(
                          //   label: controller.streetHouseNo.text,
                          //   backGroundColor: Colors.white,
                          //   textColor: Colors.black54,
                          // ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          MyTextField(
                            height: 35,
                            controller: controller.colony,
                            label: "Select Colony",
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
                                controller.colony.text = newValue;
                                controller.selectedColony= controller.colonies.firstWhere((element) => element.name == controller.colony.text);
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
                      Text('اپنا ڈیلیوری ایڈریس لکھیں',style: TextStyle(
                        fontSize: 17,
                      ),),
                      MyTextField(
                        hintColor: Colors.grey,
                        height: 35,
                        controller: controller.manualAddress,
                        label: "House No 123, Street # 22, Area/Block",),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: (){
                                controller.skipButtonClicked(cancel: customerID!=null || addressID!=null);
                              },
                              child: Text(customerID!=null || addressID!=null?"Cancel":"Skip for Now",
                                style: TextStyle(
                                    color: ColorPalette.green,
                                  fontSize: 18
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)
                              ),
                              width: 100,
                              child: MyFilledButton(
                                txt: customerID!=null || addressID!=null? "Submit":"Next",
                                borderRadius: 0,
                                color: ColorPalette.green,
                                ontap: (){
                                  if(controller.streetHouseNo.text.length==0 || controller.colony.text.length==0 || controller.manualAddress.text.length==0)
                                  {
                                    Utils.showToast("Colony and Address must be Filled!");
                                  }else{
                                    if(customerID!=null)
                                    {
                                      controller.addAddress(customerId: authController.user.value.id, colonyId: controller.selectedColony.id,authController: authController,goBackToPlaceORderScreen: goBackToPlaceORderScreen??false);
                                    }
                                    else if(addressID!=null) {
                                      controller.editAddress(addressId: addressID, address: controller.getFullAddress(),authController: authController);
                                    }
                                    else
                                    {
                                      Get.to(()=> RegisterScreen());
                                    }
                                  }


                                },
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        body:  Container(
          height: controller.height??double.maxFinite,
          width: controller.width??double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [

              Obx(
                    ()=> GoogleMap(
                  onTap: controller.onTap,
                  initialCameraPosition: CameraPosition(target: controller.latlng.value??LatLng(31.418715, 73.079109), zoom: 30,),
                  markers: controller.latlng == null
                    ? {}
                    : {
                      Marker(
                      draggable: true,
                      onDragEnd:  (laln){
                        controller.latlng.value = laln;
                      },
                      markerId: MarkerId('Current Location'),
                      position: controller.latlng.value,
                    ),
                  },
                  onMapCreated: controller.onMapCreated,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              PermissionStatus permissionStatus = await Location().hasPermission();
                              if (permissionStatus == PermissionStatus.denied ) {
                                await Location().requestPermission();
                                await controller.loadCurrentLocation();
                              }
                              else if( permissionStatus == PermissionStatus.deniedForever )
                                {
                                  Utils.showToast("Permission denied, please open app settings and check location permission");
                                }
                              else
                                await controller.loadCurrentLocation();

                            },
                            child: Icon(Icons.location_searching)),
                      ),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 270,)
                ],
              ),
            ],
          ),
        ),
      );

  }
}
