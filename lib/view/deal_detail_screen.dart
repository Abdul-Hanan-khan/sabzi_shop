import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/widgets/AlertDialogeWidget.dart';
import 'package:sabzishop/widgets/my_appbar.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';

class DealDetailScreen extends StatelessWidget {

  CartController _cartController = Get.find();
  Deal deal;
  RxInt cartIndex = 1.obs;
  DealDetailScreen(this.deal){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidgets('Deal Details').getMyAppBar(),
      backgroundColor: Colors.white,
      body:Column(
        children: [
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Center(child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(deal.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            )),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: deal.dealProducts.length,
              separatorBuilder: (context,ind)=> Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: Colors.grey,),
              ),
              itemBuilder: (BuildContext context , index)=>renderDealProduct(deal.dealProducts[index], index, context)
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
                  (){
                    cartIndex.value =  _cartController.cart.deals.indexWhere((element) => element.id==deal.id);
                    return cartIndex == -1
                  ? Container(
                child: MyFilledButton(borderRadius: 10, txt:  'Add to Cart', ontap: () {
                    _cartController.addDeal(deal, cartIndex.value);
                },
                  height: 45,
                  width: double.infinity,
                  color:ColorPalette.green,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyFilledButton(width: Get.width*0.27, ontap: () {
                    _cartController.removeDeal(deal,cartIndex.value);
                  },height: 45,
                    txt: '-', borderRadius: 10,color: ColorPalette.orange, ),
                  Text(_cartController.cart.deals[cartIndex.value].quantity.value.toString(), style: TextStyle(fontSize: 18),),
                  MyFilledButton(width: Get.width*0.27,ontap: () {
                    _cartController.addDeal(deal,cartIndex.value);
                  },
                    height: 45,
                    txt: '+', borderRadius: 10,color: ColorPalette.green, ),
                ],
              );
  }),
          ),
        ],
      )
    );
  }

  Widget renderDealProduct(DealProduct product, int index, BuildContext context){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
                            width: 150,
                            height: 100,
                            child: Image.network(product.productPhoto)
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            product.discountedPrice == null
                                ? Text("${double.parse(product.saleAmount).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                                : Text("${double.parse(product.discountedPrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            product.discountedPrice == null
                                ? Container()
                                : Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            product.discountedPrice == null
                                ? Container()
                                : Text("${product.saleAmount}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 35,),
                    Text("${product.title} ${utf8.decode(product.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("(${product.unitName})", style: TextStyle(fontSize: 16,color: Colors.black54),),
                    SizedBox(height: 10,),
                    product.discountedPrice == null
                      ? Text('${product.saleQuantity} × ${product.saleAmount} = ${product.subTotal}')
                      : Text('${product.saleQuantity} × ${product.discountedPrice} = ${product.subTotal}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
