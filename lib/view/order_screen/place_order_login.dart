import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/controller/stepper_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/modal/place_order_detail_modal.dart';
import 'package:sabzishop/modal/time_slot.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/auth_screens/add_address.dart';
import 'package:sabzishop/view/auth_screens/edit_address.dart';
import 'package:sabzishop/view/auth_screens/pick_address.dart';
import 'package:sabzishop/view/order_screen/order_history.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_label.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

import '../confirmation_screen.dart';
import '../my_google_map.dart';


class OrderScreen extends StatelessWidget {
  RxBool expanded = true.obs;


  Icon disabledIcon = Icon(Icons.circle,color:Colors.grey);
  Icon selectedIcon = Icon(Icons.circle,color:Colors.green);
  Icon enableIcon = Icon(Icons.circle_outlined,color:Colors.green);

  PlaceOrderLoginController controller = Get.find();
  TimeSlotsController slotsController = Get.find();
  RegisterScreenController registerController = RegisterScreenController();
  ScrollController addressListController = ScrollController();
  CartController cartController = Get.find();
  AuthController authController = Get.find();
  StepperController stepperController = Get.find();


  double total;

  User user = User();
  TextEditingController message = TextEditingController();


  @override
  Widget build(BuildContext context) {
    stepperController.billingAddress = authController.user.value.addresses.first.address;
    controller.currentAddress.value = authController.user.value.addresses.first;
    return  Obx(
      () => controller.progressing.value
          ? Center(child: CircularProgressIndicator(),)
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 20,),
                                  SizedBox(width: 10,),
                                  Text('Your Delivery Address', style: TextStyle(fontSize: 20),),
                                ],
                              ),
                              IconButton(
                                color: ColorPalette.green,
                                iconSize: 25,
                                icon: Icon(Icons.add, color: Colors.black,),
                                onPressed: () {
                                  Get.to(MyGoogleMap(customerID: authController.user.value.id,goBackToPlaceORderScreen: true,));
                                },
                              )
                            ],
                          ),
                          Obx(
                            () =>
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:
                                      Text(
                                        controller.currentAddress.value.address,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          controller.currentAddress.value.colonyName,
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          controller.currentAddress.value.city,
                                          style: TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.edit, color: Colors.black,),
                                onPressed: () {
                                  Get.to(() => PickAddress());
                                },
                              ),
                            )
                          ),
                          SizedBox(height: 7,),
                          Divider(color: Colors.grey,),
                          SizedBox(height: 7,),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 20,),
                                  SizedBox(width: 7),
                                  Text('Delivery Day', style: TextStyle(color: Colors.black, fontSize: 16)),
                                ],
                              ),
                              SizedBox(width: 14,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorPalette.green,),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        stepperController.dateOption == '0' ? '' : controller.selectDate(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(slotsController.timeSlot.tomorrow==1 ? 'Tomorrow' : stepperController.dateOption == '0' ? 'Today' : controller.deliveryDate.value, style: TextStyle(fontSize: 16, color: slotsController.timeSlot.tomorrow==1 ? Colors.red : Colors.black),),
                                          IconButton(
                                            icon: Icon(
                                              Icons.reorder_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined, size: 20,),
                                  SizedBox(width: 7),
                                  Text('Delivery Time', style: TextStyle(color: Colors.black, fontSize: 16)),
                                ],
                              ),
                              SizedBox(width: 7,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorPalette.green,),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: GestureDetector(
                                      onTap: (){renderDialogBox();},
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() => Text(slotsController.selectedTimeSlot.value??"", style: TextStyle(fontSize: 14),)),
                                          IconButton(
                                            icon: Icon(
                                              Icons.reorder_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7,),
                          Divider(color: Colors.grey,),
                          SizedBox(height: 7,),
                          Text('Additional Information', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 5,),
                          Container(
                            width: double.infinity,
                            height: Get.height*0.10,
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorPalette.green)
                            ),
                            child: TextField(
                              controller: message,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Order Notes',
                                hintStyle: TextStyle(color: ColorPalette.green),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorPalette.green),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Sub Total ', style: TextStyle(fontSize: 16)),
                                          Spacer(),
                                          Text(cartController.calculateTotalAmmout().toStringAsFixed(0), style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text('Product Delivery ', style: TextStyle(fontSize: 16)),
                                          Spacer(),
                                          stepperController.deliveryCharges == 0
                                              ? Text('Free', style: TextStyle(fontSize: 16))
                                              : Text(stepperController.deliveryCharges.toStringAsFixed(0), style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text('Packaging ', style: TextStyle(fontSize: 16)),
                                          Spacer(),
                                          stepperController.packagingCharges == 0
                                              ? Text('Free', style: TextStyle(fontSize: 16))
                                              : Text(stepperController.packagingCharges.toStringAsFixed(0), style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text('Total ', style: TextStyle(fontSize: 16)),

                                          Spacer(),
                                          Text((cartController.calculateTotalAmmout()+double.parse(stepperController.packagingCharges.toString())+double.parse(stepperController.deliveryCharges.toString())).toStringAsFixed(0)
                                              , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                      onTap: (){
                        if(deliverTimeValidation()){
                          placeOrder(slotsController.timeSlot.timelsots[slotsController.timeSlotIndex.value], controller.dateController.text);
                        }
                      },
                      child: Container(
                        height: 45,
                        color: ColorPalette.green,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text('PLACE ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
                            ),
                            Row(
                              children: [
                                Text("Rs ", style: TextStyle(color: Colors.white, fontSize: 20),),
                                Text("${(cartController.calculateTotalAmmout()+stepperController.packagingCharges+stepperController.deliveryCharges).toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                SizedBox(width: 7,),
                                Container(width: 2, color: Colors.black54,),
                                SizedBox(width: 7,),
                                Center(
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_forward_outlined,
                                        color: Colors.white,
                                      ), iconSize: 30,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),

                        // MyFilledButton(
                        //   borderRadius: 10,
                        //   color: ColorPalette.green,
                        //   height: 45,
                        //   width: double.infinity,
                        //   txt: "Confirm Order",
                        //   ontap: () async
                        //     {
                        //       controller.progressing.value = true;
                        //       var response = await HttpService.getPackagingandServiceDelivery();
                        //       String packagingCharges = response['packaging_charges'];
                        //       String deliveryCharges = response['product_delivery'];
                        //       controller.progressing.value = false;
                        //       Get.to(() => authController.isLogedIn.value
                        //           ? OrderScreen(deliveryCharges: deliveryCharges, packingCharges: packagingCharges,)
                        //           : PlaceOrderGuest(deliveryCharges: deliveryCharges, packingCharges: packagingCharges,)
                        //       );
                        //     },
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  placeOrder(TimeSlot slot,String date) async {
    List<PlaceOrderDetailModal> orderDetails = [];

    if(cartController.cart.products.length>0)
    {
      cartController.cart.products.forEach((product) {orderDetails.add(PlaceOrderDetailModal(productId: product.id,quantity: product.quantity.toString(),type: "product"));});
    }

    if(cartController.cart.deals.length>0)
    {
      cartController.cart.deals.forEach((deal) {orderDetails.add(PlaceOrderDetailModal(productId: deal.id,quantity: deal.quantity.toString(),type: "deal"));});
    }

    controller.progressing.value = true;
    var response = await HttpService.placeOrderForLoginCustomer(
       customerID: authController.user.value.id,
       addressID: authController.user.value.addresses[controller.addressSelectedIndex.value].id,
       deliveryDate: controller.deliveryDate.value,
       slotId: slot.id,
       orderNotes: message.text,
       amount: (cartController.calculateTotalAmmout()).toStringAsFixed(0),
       orderDetails: orderDetails,
    );
    controller.progressing.value = false;
    if(response["order_status"].toUpperCase() == "Success".toUpperCase())
      {
        Get.to(() => ConfirmationScreen());
        controller.orderID = response["order_id"].toString();
      }
}

  addressItem(Address address, int index){
    return GestureDetector(
      onTap: (){
      controller.currentAddress.value = authController.user.value.addresses[index];
      stepperController.billingAddress = '${authController.user.value.addresses[index].address??""}\t${authController.user.value.addresses[index].colonyName??""}\t${authController.user.value.addresses[index].city??""}';
      expanded.value = false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
            Text(
              address.address,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              Text(
                address.colonyName,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(width: 10,),
              Text(
                address.city,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Divider(color: Colors.grey,),
        ],
      ),
    );
  }

  renderDialogBoxItem(TimeSlot slot, int index){
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: (){

          if(slot.status.value != 'Disabled') {
            slotsController.timeSlotIndex.value = index;
            slotsController.slotFieldController.text = "${slot.timeFrom} - ${slot.timeTo}";
            slotsController.selectedTimeSlot.value = "${slot.timeFrom} - ${slot.timeTo}";
          }
          if(slotsController.timeSlot.tomorrow == 1) { controller.deliveryDate.value = "Tomorrow";}
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Obx(
                    () =>
                    slot.status.value == 'Disabled' ?  disabledIcon : slotsController.timeSlotIndex.value==index?selectedIcon:enableIcon,),
                  SizedBox(width: 15,),
                  Text("${slot.timeFrom} - ${slot.timeTo}", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Divider(color: Colors.grey[700],),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }

  renderDialogBox(){
    slotsController.loadSlots();
    if(slotsController.timeSlot.tomorrow == 1){
      if(controller.isChecked.value){
        for(int i=0; i<slotsController.timeSlot.timelsots.length; i++){
          slotsController.timeSlot.timelsots[i].status.value = "Enabled";
        }
      }else if(!controller.isChecked.value) {
        for(int i=0; i<slotsController.timeSlot.timelsots.length; i++){
          slotsController.timeSlot.timelsots[i].status.value = "Disabled";
        }
        slotsController.selectedTimeSlot.value = '';
        controller.deliveryDate.value = controller.dateController.text;
      }else{
        slotsController.timeSlot.timelsots = slotsController.timeSlotCopy.timelsots;
      }
    }
    // controller.isChecked.value = false;
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
                // height: Get.height,
              ),
            ), Center(
              child: Stack(
                children: [
                  Container(
                    height: slotsController.timeSlot.tomorrow == 1 ? 500 : 440,
                    width: 350,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.schedule_outlined, color: ColorPalette.green, size: 75,),
                                SizedBox(width: 7,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Select Estimated Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 7,),
                                    Container(width: 200, child: Text('SELECT FROM THE OPTION BELOW', style: TextStyle(fontSize: 16))),
                                    SizedBox(height: 7,),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Divider(color: Colors.grey[700],),
                            SizedBox(height: 5,),
                            Container(
                              height: slotsController.timeSlot.tomorrow == 1 ? 240 : 240,
                              child: ListView.builder(
                                  itemCount: slotsController.timeSlot.timelsots.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => renderDialogBoxItem(slotsController.timeSlot.timelsots[index], index)
                              ),
                            ),
                            SizedBox(height: 7,),
                            slotsController.timeSlot.tomorrow == 1 ? Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(height: 18, width: 18, color: ColorPalette.green,),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(Icons.done, color: Colors.white,size: 20,),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 15,),
                                  GestureDetector(
                                    // onTap: (){
                                    //   controller.isChecked.value = !controller.isChecked.value;
                                    //   if(controller.isChecked.value){
                                    //     for(int i=0; i<slotsController.timeSlot.timelsots.length; i++){
                                    //       slotsController.timeSlot.timelsots[i].status.value = "Enabled";
                                    //     }
                                    //     controller.deliveryDate.value = "Tomorrow";
                                    //   }else{
                                    //     for(int i=0; i<slotsController.timeSlot.timelsots.length; i++){
                                    //       slotsController.timeSlot.timelsots[i].status.value = "Disabled";
                                    //     }
                                    //   }
                                    //
                                    // },
                                    child: Text('Place order for tomorrow',style: TextStyle(fontSize: 16, color: Colors.red),)
                                  ),
                                ],
                              ),
                            ) : Container(),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyFilledButton(
                                  width: 100,
                                  txtColor: Colors.grey ,
                                  color: Colors.white,
                                  txt: 'CANCEL',
                                  borderRadius: 5,
                                  ontap: (){
                                    Get.back();
                                  },
                                ),
                                SizedBox(width: 7,),
                                MyFilledButton(
                                  width: 80,
                                  color: ColorPalette.orange,
                                  txt: 'DONE',
                                  borderRadius: 5,
                                  ontap: (){
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  bool deliverTimeValidation(){
    if(slotsController.selectedTimeSlot.value.length==0){
      Fluttertoast.showToast(msg: 'Please Select a TimeSlot');
      return false;
    }
    else
      return true;
  }

}

// class SelectableContainer extends StatelessWidget {
//   SelectableContainer({
//      this.controller,
//      this.index,
//     this.isSelected,
//   });
//
//   AuthController controller;
//   int index;
//   bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: isSelected ? ColorPalette.green : Colors.transparent),
//             color:  isSelected ? ColorPalette.green.shade300 : Colors.black12,
//             borderRadius: BorderRadius.circular(6),
//           ),
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: Get.width-33,
//                       child: Text('${controller.user.value.addresses[index].address}\t\t\t', style: TextStyle(fontSize: 16,),),
//                     ),
//                     SizedBox(height: 3,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('${controller.user.value.addresses[index].colonyName}, ', style: TextStyle(fontSize: 16,),),
//                         Text('${controller.user.value.addresses[index].postcode},\t\t\t', style: TextStyle(fontSize: 16,), ),
//                         Text(controller.user.value.addresses[index].city, style: TextStyle(fontSize: 16,),),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 7,),
//       ],
//     );
//   }
// }





