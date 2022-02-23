import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';

class PlaceOrderLoginController extends GetxController{
  AuthController authController = Get.find();
  TimeSlotsController slotsController = Get.find();

  Rx<Address> currentAddress = Address().obs;
  RxBool isSelected = false.obs;
  RxBool expanded = false.obs;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController;
  RxBool progressing = false.obs;
  RxInt addressSelectedIndex = 0.obs;
  String orderID;
  RxBool isChecked = true.obs;
  RxString deliveryDate = ''.obs;


  PlaceOrderLoginController() {
    dateController =  TextEditingController(text: '${DateTime.now()}'.split(' ')[0].toString());
    slotsController.timeSlot.tomorrow == 1 ? deliveryDate.value = "Tomorrow" : deliveryDate.value = dateController.text;
  }


  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      // firstDate: deliveryDate.value == "Tomorrow" ? DateTime.now().add(new Duration(days: 1)) : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    print(deliveryDate.value);
    if (picked != null && picked != selectedDate) {
      dateController.value = TextEditingController(text: '$picked.toLocal()'.split(' ')[0].toString()).value;
      deliveryDate.value = dateController.text;
    }
  }


}