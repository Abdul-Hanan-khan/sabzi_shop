import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/widgets/my_label.dart';

import 'my_filled_button.dart';
CartController _cartController = Get.find();


class MyProduct extends StatelessWidget {
  Product product;
  bool outOfStock= false;
  RxInt cartIndex = 1.obs;


  MyProduct({@required this.product}){
    cartIndex.value =  _cartController.cart.products.indexWhere((element) => element.id==product.id);
  }

  @override
  Widget build(BuildContext context) {
    outOfStock = product.status.toString() == "0" ?true:false;
    return Stack(
      children: [
        Container(
           constraints: BoxConstraints(
               minWidth: 400,
               minHeight: 100,
               maxWidth: 400,
               maxHeight: 350
           ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                height: 200,
                  width: 200,
                  child: Image.network(product.photo),
                ),
                SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${product.title}  ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Text("${utf8.decode(product.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16),),
                  ],
                ),
                SizedBox(height: 3,),
                Text("(${product.unitName})", style: TextStyle(fontSize: 16,color: Colors.black54),),
                SizedBox(height: 3,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    product.discountedPrice == null
                        ? Text("${double.parse(product.salePrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        : Text("${double.parse(product.discountedPrice).toStringAsFixed(0)}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    product.discountedPrice == null
                        ? Container()
                        : Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    product.discountedPrice == null
                        ? Container()
                        : Text("${product.salePrice}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
                  ],
                ),
                SizedBox(height: 3,),
                Obx(
                  ()=>cartIndex == -1
                      ? Container(
                        child: MyFilledButton(
                          borderRadius: 10 ,
                          txt: outOfStock?'Out of Stock':'Add to Cart',
                          ontap: () {
                            if(!outOfStock)
                              _cartController.addItem(product, cartIndex.value);
                          },
                          height: 45,
                          width: double.infinity,
                          color: outOfStock ? Colors.red : ColorPalette.green,
                        ),
                      )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyFilledButton(
                              width: Get.width*0.27,
                              ontap: () {
                                _cartController.removeItem(product,cartIndex.value);
                              },
                              height: 45,
                              txt: '–',
                              borderRadius: 10,
                              color: ColorPalette.orange,
                            ),
                            Text(_cartController.cart.products[cartIndex.value].quantity.value.toString(), style: TextStyle(fontSize: 18),),
                            MyFilledButton(
                              width: Get.width*0.27,
                              ontap: () {
                                _cartController.addItem(product,cartIndex.value);
                              },
                              height: 45,
                              txt: '+',
                              borderRadius: 10,
                              color: ColorPalette.green,
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: product.discount =="0"? Container(): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyLabel(label: "Discount ${product.discount}%"),
            ],
          ),
        ),
      ],
    );
  }
}
