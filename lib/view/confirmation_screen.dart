
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/order_status_screen_controller.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/controller/stepper_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/order_screen/order_history.dart';
import 'package:sabzishop/view/order_screen/order_status_screen.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:intl/intl.dart';

import 'home_screen_and_tabs/homepage.dart';

class ConfirmationScreen extends StatelessWidget {
  StepperController stepperController = Get.find();
  CartController cartController = Get.find();
  TimeSlotsController slotController = Get.find();
  AuthController authController = Get.find();
  PlaceOrderLoginController placeOrderLoginController = Get.find();
  OrderStatusScreenController orderStatusScreenController = OrderStatusScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.black, iconSize: 0,),
        leadingWidth: 0,
        title: Text('Confirmation', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 150,
                        child: Image.asset(
                          'assets/image/sabzishopicon.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text('Thank you for your order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 7,),
                      Text('Read your details below', style: TextStyle(color: Colors.black87, fontSize: 18),),
                      SizedBox(height: 18,),


                      Icon(Icons.credit_card_outlined, size: 35,),
                      Text('Total Cost', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 7,),
                      Text("Rs ${(cartController.calculateTotalAmmout()+stepperController.deliveryCharges+stepperController.packagingCharges).toStringAsFixed(0)}",
                        // stepperController.deliveryCharges == 0 && stepperController.packagingCharges!=0
                        //   ? "${cartController.calculateTotalAmmout().toStringAsFixed(0)} + ${stepperController.packagingCharges.toStringAsFixed(0)} = ${(cartController.calculateTotalAmmout()+stepperController.packagingCharges).toStringAsFixed(0)}"
                        //   : stepperController.deliveryCharges !=0 && stepperController.packagingCharges ==0
                        //     ? "${cartController.calculateTotalAmmout().toStringAsFixed(0)} + ${stepperController.deliveryCharges.toStringAsFixed(0)} = ${(cartController.calculateTotalAmmout()+stepperController.deliveryCharges).toStringAsFixed(0)}"
                        //     : stepperController.deliveryCharges !=0 && stepperController.packagingCharges !=0
                        //       ? "${cartController.calculateTotalAmmout().toStringAsFixed(0)} + ${stepperController.deliveryCharges.toStringAsFixed(0)} + ${stepperController.packagingCharges.toStringAsFixed(0)} = ${(cartController.calculateTotalAmmout()+stepperController.deliveryCharges+stepperController.packagingCharges).toStringAsFixed(0)}"
                        //       : "${(cartController.calculateTotalAmmout()+stepperController.packagingCharges+stepperController.deliveryCharges).toStringAsFixed(0)}",
                        style: TextStyle(
                          color: ColorPalette.orange,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 18,),
                      Icon(Icons.watch_later_outlined, size: 35,),
                      Text('Estimated Delivery Time', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 7,),
                      Text("${slotController.timeSlot.timelsots[slotController.timeSlotIndex.value].timeFrom} - ${slotController.timeSlot.timelsots[slotController.timeSlotIndex.value].timeTo}", style: TextStyle(color: ColorPalette.orange, fontSize: 20,),),
                      SizedBox(height: 18,),




                      Icon(Icons.date_range_outlined, size: 35,),
                      Text('Delivery Date', style: TextStyle( fontSize: 20),),
                      SizedBox(height: 7,),
                      Text(slotController.timeSlot.tomorrow == 1 ? "Tomorrow" : stepperController.dateOption == "1" ? DateFormat("d/M/yyyy").format(DateTime.parse(placeOrderLoginController.deliveryDate.value)) : "Today", style: TextStyle(color: ColorPalette.orange, fontSize: 20,),),
                      SizedBox(height: 18,),


                      Icon(Icons.location_on_outlined, size: 35,),
                      Text('Billing Address', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 7,),
                      Text('${placeOrderLoginController.currentAddress.value.address}\t${placeOrderLoginController.currentAddress.value.city}', style: TextStyle(color: ColorPalette.orange, fontSize: 18,), textAlign: TextAlign.center,),
                      SizedBox(height: 18,),
                      Text('${placeOrderLoginController.currentAddress.value.manualAddress}\t${placeOrderLoginController.currentAddress.value.colonyName}', style: TextStyle(color: Colors.grey[600], fontSize: 18,), textAlign: TextAlign.center,),
                      SizedBox(height: 7,),
                    ],
                  ),
                ),
              ),
            ),
            MyFilledButton(
              height: 45,
              width: double.infinity,
              color: ColorPalette.orange,
              borderRadius: 0,
              ontap: () async {
                orderStatusScreenController.progressing.value = true;
                Order order = await HttpService.getOrderWithID(placeOrderLoginController.orderID);
                orderStatusScreenController.progressing.value = false;
                stepperController.currentIndex.value = 0;
                Get.offAll(HomePage());
                Get.to(OrderStatusScreen(order: order,));
                cartController.clearCart();
              },
              txt: 'DONE',
            ),
          ],
        ),
      ),
    );
  }
}
