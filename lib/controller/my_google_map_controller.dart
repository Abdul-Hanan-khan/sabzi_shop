import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/auth_screens/profile.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';

import '../utilities.dart';
import 'auth_controller.dart';

class MyGoogleMapController extends GetxController{
  PlaceOrderLoginController placeOrderLoginController = PlaceOrderLoginController();
  TextEditingController streetHouseNo = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController manualAddress = TextEditingController();
  GoogleMapController _mapController ;
  Rx<LatLng> latlng = LatLng(0.0, 0.0).obs;
  double height;
  double width;
  Colony selectedColony;
  RxString currentAddress = "".obs;
  RxList<Colony> colonies =<Colony>[].obs;
  RxBool progressing = false.obs;
  bool editingAddress= false ;

MyGoogleMapController({
  this.height,
  this.width,
  this.latlng,
}){

  loadCurrentLocation();
  loadColonies();
  addLatlngListener();
}
  void _moveCamera() {
    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
          latlng.value, 14.47),
    );
  }

onTap(position) {
latlng.value = position;
print(latlng);
}


 onMapCreated(controller) {
  _mapController = controller;
  _moveCamera();
 }

addLatlngListener(){
  Future.delayed(Duration(seconds: 1)).then((value){
    latlng.listen((laln) async {
      if(latlng.value == laln)
        {
          currentAddress.value = await HttpService.getAddressFromGoogleMapsAPI(latlng.value.latitude,latlng.value.longitude);
          streetHouseNo.text = "${currentAddress.value.split(",")[0]},${currentAddress.value.split(",")[1]}";
        }
    });
  });
}


Future<void> loadCurrentLocation() async {
  Location location = Location();
  PermissionStatus permissionStatus = await location.hasPermission();
  if (permissionStatus == PermissionStatus.denied) {
    permissionStatus = await location.requestPermission();
    if (permissionStatus == PermissionStatus.denied) {
      Fluttertoast.showToast(msg: "You can not access location services without allowing it");
      permissionStatus = await location.requestPermission();
      return;
    }
  }
  else if( permissionStatus == PermissionStatus.deniedForever )
  {
    Utils.showToast("Permission denied, please open app settings and check location permission");
  }
  LocationData locationData = await location.getLocation();
  latlng.value= LatLng(locationData.latitude, locationData.longitude);
  if(_mapController!=null)
    {
      _moveCamera();
    }
if(!editingAddress)
  {
    currentAddress.value = await HttpService.getAddressFromGoogleMapsAPI(latlng.value.latitude,latlng.value.longitude);
    streetHouseNo.text = "${currentAddress.value.split(",")[0]},${currentAddress.value.split(",")[1]}";
  }
}



  loadColonies() async{
    colonies.value = await HttpService.get_colonies();
  }

  String getFullAddress(){
  List addressArray =
  currentAddress.value.split(",");
  addressArray[0]= streetHouseNo.text.split(",")[0];
  addressArray[1]= streetHouseNo.text.split(",")[1];
  return addressArray.join(",");
  }
  @override
  void onClose() {
  // TODO: implement onClose
    super.onClose();
  }

  addAddress({@required String customerId,@required String colonyId,@required AuthController authController,bool goBackToPlaceORderScreen}) async {
  progressing.value = true;
  var response = await HttpService.addAdress(customerId: customerId, colonyId: colonyId, address: getFullAddress(), manualAddress: manualAddress.text);
  progressing.value = false;
  Utils.showToast(response['msg']);
  if(response['status']=="success")
  {
    if ( response != null) {
      authController.user.value.addresses.clear();
      // placeOrderLoginController.currentAddress = response.
      response['record']['addresses'].forEach((v) {
        authController.user.value.addresses.add(new Address.fromJson(v));
      });
    }
    User.saveUserToCache(authController.user.value);
  }
  if(goBackToPlaceORderScreen)
    {
     Get.back();
    }
  else
  {
    Get.offAll(()=> HomePage());
  }

  }
  editAddress({@required String addressId,@required String address,@required AuthController authController}) async {
  progressing.value = true;
  var response = await HttpService.editAddress(addressId: addressId, colonyId: selectedColony.id, address: address, manualAddress: manualAddress.text);
  progressing.value = false;
  Utils.showToast(response['msg']);
  if(response['status']=="success")
  {
    if (response != null) {
      int index = authController.user.value.addresses.indexWhere((element) => element.id == addressId);
      authController.user.value.addresses[index].address = address;
      authController.user.value.addresses[index].colonyName = selectedColony.name;
      authController.user.value.addresses[index].postcode = "";
      authController.user.value.addresses[index].city = "";
      authController.user.value.addresses[index].manualAddress = manualAddress.text;
    }
    User.saveUserToCache(authController.user.value);
  }
  Get.offAll(()=> HomePage());
  Get.to(()=>Profile());
  }

  skipButtonClicked({bool cancel}){
  if(cancel)
  Get.back();
  else
  Get.offAll(()=> HomePage());

  }
}













