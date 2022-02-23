import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/controller/stepper_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/view/cart_screen.dart';
import 'package:sabzishop/view/order_screen/place_order_login.dart';

import '../confirmation_screen.dart';

class StepperBar extends StatelessWidget {
  StepperController controller =Get.put(StepperController());
  TimeSlotsController slotsController = Get.find();
  PlaceOrderLoginController placeOrderLoginController = Get.put(PlaceOrderLoginController());
  List<String> stepNames = ["1. Your Bill","2. Place Order","3. Completed"];
  List<String> appBarTitle = ["My Cart","Checkout","Confirmation"];
  List<Widget> stepScreens = [CartScreen(), OrderScreen(), Container()];

  @override
 Widget build(BuildContext context){
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(appBarTitle[controller.currentIndex.value]),),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Obx(
              ()=> Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                   decoration: new BoxDecoration(
                     color: Colors.black12,
                   ),
                   height: 72,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     if(controller.currentIndex.value == 1){
                                        controller.currentIndex.value =0;
                                      }
                                      },
                                   child: Stack(
                                     alignment: Alignment.center,
                                     children: [
                                       Icon(
                                         Icons.circle, color: controller.currentIndex.value == 0 ? ColorPalette.green : ColorPalette.green,
                                       ),
                                       Icon(Icons.done,color: Colors.white,size: 14,)
                                     ],
                                   ),
                                 ),
                                 Container(width: (Get.width-123)/2, height: 2, color:controller.currentIndex.value==1?ColorPalette.green: Colors.grey,),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Icon(Icons.circle, color: controller.currentIndex.value == 1 ? ColorPalette.green : Colors.grey,),
                                     controller.currentIndex.value == 1 ? Icon(Icons.done,color: Colors.white,size: 14,):Container()
                                   ],
                                 ),
                                 Container(width: (Get.width-123)/2, height: 2, color: Colors.grey,),
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Icon(Icons.circle, color: controller.currentIndex.value == 2 ? ColorPalette.green : Colors.grey,),
                               ],
                             ),
                           ],
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text('1. Your Bill', style: TextStyle(fontSize: 14,color: controller.currentIndex.value >= 0 ? ColorPalette.green : Colors.black ),),
                             Text('2. Place Order', style: TextStyle(fontSize: 14, color: controller.currentIndex.value >= 1 ? ColorPalette.green : Colors.black),),
                             Text('3. Completed', style: TextStyle(fontSize: 14),)
                           ],
                         ),
                       ),
                       // Divider(thickness: 2, color: Colors.grey,),
                       Container(height: 1,width: Get.width,color: Colors.black12,)
                     ],
                   ),
                   // Expanded(
                   //   child: ListView.separated(
                   //      itemBuilder: (context,index)=>myStep(index==controller.currentIndex.value,index),
                   //      separatorBuilder: (context,index)=>sapeator(),
                   //      itemCount: stepNames.length,
                   //      scrollDirection: Axis.horizontal
                   //     ),
                   // ),
                 ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: Get.height-170,
                      width: double.infinity,
                      child:  stepScreens[controller.currentIndex.value],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Widget myStep(bool active,int index){
  //   return GestureDetector(
  //     onTap: (){
  //      if(index != 0 && index >2)
  //        {
  //          controller.currentIndex.value = index;
  //        }
  //      else if(index==0 && controller.currentIndex.value ==1){
  //        controller.currentIndex.value = index;
  //      }
  //     },
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Icon(Icons.circle,color: active?ColorPalette.green:Colors.grey, size: 25,),
  //
  //         SizedBox(height:5),
  //         Text(stepNames[index], style: TextStyle(fontSize: 15),),
  //       ],
  //     ),
  //   );
  // }

}
