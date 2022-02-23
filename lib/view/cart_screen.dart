import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/controller/stepper_controller.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/view/my_google_map.dart';
import 'package:sabzishop/view/order_screen/place_order_guest.dart';
import 'package:sabzishop/view/order_screen/place_order_login.dart';
import 'package:sabzishop/view/stepper/stpper_bar.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';

import 'deal_detail_screen.dart';

class CartScreen extends StatelessWidget {

CartController controller = Get.find();
AuthController authController = Get.find();
BottomBarController bottomBarController = Get.find();
StepperController stepperController = Get.find();



  double totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    return  Obx(
      ()=> controller.cart.products.length ==0&& controller.cart.deals.length ==0
        ? Center(child: Text("No items in cart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),)
        : controller.progressing.value
          ? Center(child: CircularProgressIndicator(),)
          :Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            controller.cart.deals.length==0?Container(): Container(
              color: Colors.white70,
               height: 210,
               child:
               ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  itemBuilder: (context,index)=>
                  renderCartDealItem(controller.cart.deals[index],index, context),
                  itemCount: controller.cart.deals.length,
                ),
             ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context,index)=> renderCartItem(controller.cart.products[index],index, context),
                separatorBuilder: (context,ind)=> Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:  Divider(color: Colors.grey,),
                    // Container(
                    //   height: 2,
                    //   decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //           colors: [
                    //             Colors.white,
                    //             ColorPalette.green,
                    //             Colors.white,
                    //           ]
                    //       )
                    //   ),
                    // )
                ),
                itemCount: controller.cart.products.length,
              ),
            ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                authController.isLogedIn.value
                  ? stepperController.currentIndex.value = 1
                  : Get.to(() => MyGoogleMap());
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
                      child: Text('CHECKOUT', style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    Row(
                      children: [
                        Text("Rs ", style: TextStyle(color: Colors.white, fontSize: 20),),
                        Text("${controller.calculateTotalAmmout().toStringAsFixed(0)}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget renderCartItem(Product product, int index, BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Container(
        height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                        width: 150,
                        height: 140,
                        child: Image.network(product.photo)),
//                    Stack(
//                      alignment: Alignment.center,
//                      children: [
//                        Icon(Icons.circle),
//                        Obx(()=> Text("${product.quantity.toString()}x",style: TextStyle(color:Colors.white,fontSize: 8),))
//                      ],
//                    )
                  ],
                ),

                   Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyFilledButton(txt: "-",height:30,width: 30,color: ColorPalette.orange,ontap:(){ controller.removeItem(product, index);},),
                        Obx(()=>
                            Text(product.quantity.toString())),
                        MyFilledButton(txt: "+",height: 30,width: 30,color: ColorPalette.green,ontap: (){controller.addItem(product, index);},)
                      ],
                    ),
                  ),

              ],
            ),
            Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     GestureDetector(
                //         onTap: (){
                //           showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return AlertDialogWidget(
                //                   title: 'Remove Cart Item',
                //                   subTitle: "Are you sure to remove cart item?",
                //                   onPositiveClick: () {
                //                     controller.removeFullItem(product, index);
                //                     Get.back();
                //                   },
                //                 );
                //               }
                //           );
                //         },
                //         child: Icon(Icons.delete,color: Colors.red,)),
                //   ],
                // ),
                Text("${product.title} ${utf8.decode(product.urduTitle.codeUnits)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("(${product.unitName})", style: TextStyle(fontSize: 17),),
                SizedBox(height: 10,),
                Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      product.discountedPrice == null
                          ? Text("${product.quantity.toString()} x ${double.parse(product.salePrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 17),)
                          : Text("${product.quantity.toString()} x ${double.parse(product.discountedPrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 17),),
                      product.discountedPrice == null
                          ? Container()
                          : Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      product.discountedPrice == null
                          ? Container()
                          : Text("${double.parse(product.salePrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
                    ],
                  ),
                ),
                Spacer(),
                Obx(()=> Row(
                  children: [
                    Text("Rs ", style: TextStyle(fontSize: 17,),),
                    product.discountedPrice == null
                        ? Text("${(double.parse(product.salePrice)*product.quantity.value).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        : Text("${(double.parse(product.discountedPrice)*product.quantity.value).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                  ],
                )),
                SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget renderCartDealItem(Deal deal, int index, BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: controller.cart.deals.length == 1 ? Get.width-20 : Get.width-40,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Card(
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(()=>DealDetailScreen(deal));
                    },
                    child: Row(

                      children: [
                        Container(
                          width: 110,
                          height: 120,
                          child: Column(
                            children: [
                              Image.network(deal.squareImage,fit: BoxFit.cover,),
                              SizedBox(height: 8,),
                              Container(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyFilledButton(txt: "-",height:30,width: 30,color: ColorPalette.orange,ontap:(){ controller.removeDeal(deal, index);},),
                                    Obx(()=> Text(deal.quantity.toString())),
                                    MyFilledButton(txt: "+",height: 30,width: 30,color: ColorPalette.green,ontap: (){controller.addDeal(deal, index);},)
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ),
                        SizedBox(width: 30,)
,                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(deal.title,style: TextStyle(fontWeight: FontWeight.w800)),
                            Text(utf8.decode(deal.urduTitle.codeUnits),style: TextStyle(fontWeight: FontWeight.w800)),

                            Container(
                                width: Get.width*0.4,
                                child: Text(deal.shortDetails,style: TextStyle(color: Colors.grey))),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Expires on"),
                                SizedBox(width: 5,),
                                Text(deal.expiryDate,style: TextStyle(color: ColorPalette.orange)),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${deal.quantity} × ${deal.dealAmount} = ",),
                                    Text("${(double.parse(deal.dealAmount)* deal.quantity.value).toStringAsFixed(0)}",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                )
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: ColorPalette.green,
              child: Obx(()=> Text("${deal.quantity.string}X",style: TextStyle(fontSize: 8,color: Colors.black,fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }
}
