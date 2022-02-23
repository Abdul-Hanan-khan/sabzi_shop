import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/modal/time_slot.dart';
import 'package:sabzishop/services/http_service.dart';

class TimeSlotsController extends GetxController {
  RxBool loading = true.obs;
  TimeSlotModal timeSlot = TimeSlotModal();
  bool showDatePicker = false;
  RxInt timeSlotIndex = 0.obs;
  TimeSlotModal timeSlotCopy = TimeSlotModal();
  RxString selectedTimeSlot = ''.obs;
  TextEditingController slotFieldController = TextEditingController();

  String showPhoto;
  TextEditingController date = TextEditingController(text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");


  TimeSlotsController(){
    loadSlots().then((value) {
     if(timeSlot.timelsots.length!=0)
       loading.value = false;
       int tempIndex  = timeSlot.timelsots.indexWhere((slot) => slot.status.toUpperCase() == 'Enabled'.toUpperCase());
       if(tempIndex+1 != timeSlot.timelsots.length){
         timeSlotIndex.value = tempIndex;
       }else{
         timeSlotIndex.value = tempIndex+1;
       }
     // slotFieldController.text = "${timeSlots[tempIndex].timeFrom} - ${timeSlots[tempIndex].timeTo}";
     // selectedTimeSlot.value = "${timeSlots[tempIndex].timeFrom} - ${timeSlots[tempIndex].timeTo}";
    });
  }


  onInit(){
    loadSlots().then((value) {
      if(timeSlot.timelsots.length!=0)
        loading.value = false;
    });
    super.onInit();
  }

  Future<void> loadSlots() async {
    timeSlot =  await  HttpService.getTimeSlots();
    timeSlotCopy = timeSlot;
    showDatePicker  = await HttpService.getShowDatePickerStatus();
  }

}