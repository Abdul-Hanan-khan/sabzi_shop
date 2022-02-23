import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PlaceOrderGuestController extends GetxController{

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController code = TextEditingController(text: "+92");
  TextEditingController colony = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController phone = TextEditingController();


  bool checkOutValidation(){
    if(name.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Name is Required');
      return false;
    }else if
    (email.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Email is required');
      return false;
    }else if
    (phone.text.trim().length==0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
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
    else if
    (message.text.trim().length==0){
      Fluttertoast.showToast(msg: 'City is required');
      return false;
    }
    else
      return true;
  }
}