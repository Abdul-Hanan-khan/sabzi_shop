import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/modal/time_slot.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/confirmation_screen.dart';
import 'package:sabzishop/view/order_screen/place_order_login.dart';
import 'package:sabzishop/widgets/AlertDialogeWidget.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class MyTimeSlots extends StatelessWidget {
  String deliveryCharge;
  String packingCharge;
  MyTimeSlots({this.deliveryCharge, this.packingCharge});
  TimeSlotsController slotsController = Get.find();

  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    if(slotsController.timeSlot.timelsots.length==0)
      slotsController.loadSlots();
    return Obx(
          ()=> slotsController.loading.value?
      Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                constraints: BoxConstraints(
                  minHeight: Get.height * 0.15,
                  maxHeight: Get.height * 0.75,
                ),
                // height: Get.height*0.75-62,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      slotsController.showDatePicker? myDateTimePicker(context):Container(),
                      SizedBox(
                          height: 21,
                          child: Text(
                            'Select Time Slot',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                      Divider(),
                      ListView.builder(
                          itemCount: slotsController.timeSlot.timelsots.length,
                          itemBuilder: (context, index) {
                            return timeSlotItem(slotsController.timeSlot.timelsots[index],index);
                          }
                      ),
//                       ...slotsController.timeSlot.timelsots.map((slot) => GestureDetector(
//                         onTap: (){
//                           return Get.dialog(Scaffold(
//                             backgroundColor: Colors.transparent,
//                             body: Center(
//                               child: Stack(
//                                 children: [
//                                   GestureDetector(
//                                     onTap:(){
//                                       Get.back();
//                                     },
//                                     child: Container(
//                                       color: Colors.transparent,
//                                       width: Get.width,
//                                       height: Get.height,
//                                     ),
//                                   ), Center(
//                                     child: Stack(
//                                       children: [
//                                         Container(
//                                           height: 350,
//                                           width: 350,
//                                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(12.0),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Center(
//                                                   child: IconButton(icon: Icon(Icons.check_circle_outlined, size: 60, color: ColorPalette.green),),
//                                                 ),
//                                                 SizedBox(height: 25,),
//                                                 Center(child: Text('Order Confirmation!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),)),
//                                                 SizedBox(height: 10,),
//                                                 Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Text('Delivery Date', style: TextStyle(fontSize: 16),),
//                                                     Text('${slotsController.date.text}', style: TextStyle(fontSize: 16),)
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 10,),
//                                                 Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Text('Time Slot', style: TextStyle(fontSize: 16),),
//                                                     Text('${slotsController.} - ${slot.timeTo}', style: TextStyle(fontSize: 16),)
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 10,),
//                                                 Row(
//                                                   children: [
//                                                     Text('Sub Total', style: TextStyle(fontSize: 16)),
//                                                     Spacer(),
//                                                     Text(cartController.calculateTotalAmmout().toStringAsFixed(0), style: TextStyle(fontSize: 16)),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 5,),
//                                                 Row(
//                                                   children: [
//                                                     Text('Product Delivery', style: TextStyle(fontSize: 16)),
//                                                     Spacer(),
//                                                     deliveryCharge =='0'
//                                                         ? Text('Free', style: TextStyle(fontSize: 16))
//                                                         : Text(deliveryCharge??"", style: TextStyle(fontSize: 16)),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 5,),
//                                                 Row(
//                                                   children: [
//                                                     Text('Packaging', style: TextStyle(fontSize: 16)),
//                                                     Spacer(),
//                                                     packingCharge =='0'
//                                                         ? Text('Free', style: TextStyle(fontSize: 16))
//                                                         : Text(packingCharge??"", style: TextStyle(fontSize: 16)),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 5,),
//                                                 Row(
//                                                   children: [
//                                                     Text('Total', style: TextStyle(fontSize: 16)),
//                                                     Spacer(),
//                                                     Text((cartController.calculateTotalAmmout()+double.parse(packingCharge)+double.parse(deliveryCharge)).toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16)),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 15,),
//                                                 MyFilledButton(
//                                                   height: 40,
//                                                   width: double.infinity,
//                                                   borderRadius: 10,
//                                                   color: ColorPalette.green,
//                                                   txt: 'Confirm',
//                                                   ontap: (){
//                                                     OrderScreen().placeOrder(slot,slotsController.date.text);
// //                                                    Get.to(ConfirmationScreen());
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                           );
// //                                return AlertDialogWidget(
// //                                  title: '',
// //                                  subTitle: "Do You Want to Place Order on\nDate: ${slotsController.date.text}\nTime: ${slot.timeFrom} - ${slot.timeTo}",
// //                                  onPositiveClick: () {
// //                                    OrderScreen().placeOrder(slot,slotsController.date.text);
// //                                    Get.back(); Get.back();
// //                                  },
// //                                );
//
//                           cartController.checkout(slot:slot,);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Container(
//                             color: ColorPalette.green.shade100,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 15.0),
//                                   child: Text(
//                                     "${slot.timeFrom} - ${slot.timeTo}",
//                                     style: TextStyle(fontSize: 18),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ))
//                           .toList()
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget myDateTimePicker(BuildContext context) {
    DateTime date = DateTime.now();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () async {
          date = await showDatePicker(context: context, initialDate: date, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 30)));
          slotsController.date.text =  "${date.year}-${date.month}-${date.day}";
        },
        child: MyTextField(
            controller: slotsController.date, label: "Date of Delivery",enabled: false,),
      ),
    );
  }


  timeSlotItem(TimeSlot slot, int index){
    return  GestureDetector(
      onTap: (){
        return Get.dialog(Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap:(){
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: Get.width,
                    height: Get.height,
                  ),
                ), Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: IconButton(icon: Icon(Icons.check_circle_outlined, size: 60, color: ColorPalette.green),),
                              ),
                              SizedBox(height: 25,),
                              Center(child: Text('Order Confirmation!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),)),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Delivery Date', style: TextStyle(fontSize: 16),),
                                  Text('${slotsController.date.text}', style: TextStyle(fontSize: 16),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Time Slot', style: TextStyle(fontSize: 16),),
                                  Text('${slot.timeFrom} - ${slot.timeTo}', style: TextStyle(fontSize: 16),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text('Sub Total', style: TextStyle(fontSize: 16)),
                                  Spacer(),
                                  Text(cartController.calculateTotalAmmout().toStringAsFixed(0), style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Product Delivery', style: TextStyle(fontSize: 16)),
                                  Spacer(),
                                  deliveryCharge =='0'
                                      ? Text('Free', style: TextStyle(fontSize: 16))
                                      : Text(deliveryCharge??"", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Packaging', style: TextStyle(fontSize: 16)),
                                  Spacer(),
                                  packingCharge =='0'
                                      ? Text('Free', style: TextStyle(fontSize: 16))
                                      : Text(packingCharge??"", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Total', style: TextStyle(fontSize: 16)),
                                  Spacer(),
                                  Text((cartController.calculateTotalAmmout()+double.parse(packingCharge)+double.parse(deliveryCharge)).toStringAsFixed(0), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 15,),
                              MyFilledButton(
                                height: 40,
                                width: double.infinity,
                                borderRadius: 10,
                                color: ColorPalette.green,
                                txt: 'Confirm',
                                ontap: (){
                                  OrderScreen().placeOrder(slot,slotsController.date.text);
//                                                    Get.to(ConfirmationScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        );
//
//                                return AlertDialogWidget(
//                                  title: '',
//                                  subTitle: "Do You Want to Place Order on\nDate: ${slotsController.date.text}\nTime: ${slot.timeFrom} - ${slot.timeTo}",
//                                  onPositiveClick: () {
//                                    OrderScreen().placeOrder(slot,slotsController.date.text);
//                                    Get.back(); Get.back();
//                                  },
//                                );

        // cartController.checkout(slot:slot,);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: ColorPalette.green.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "${slot.timeFrom} - ${slot.timeTo}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}