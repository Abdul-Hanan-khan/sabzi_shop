import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/services/http_service.dart';

class RegisterScreenController extends GetxController{
  RxBool fetchingAddress = true.obs;
  LatLng latlng ;
  Colony selectedColony;
  RegisterScreenController(){
    loadColonies();
  }
  RxList<Colony> colonies =<Colony>[].obs;

  loadColonies() async{
    colonies.value = await HttpService.get_colonies();
  }
  Future<void> loadCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    latlng= LatLng(locationData.latitude, locationData.longitude);
  }
  bool validate(TextEditingController name, TextEditingController phone ){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }
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