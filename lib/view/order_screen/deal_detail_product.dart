import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/modal/deal.dart';

class DealDetail extends StatelessWidget {
  Deal deal;
  DealDetail ({this.deal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Deal Details', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
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
          ListView.separated(
              shrinkWrap: true,
              itemCount: deal.dealProducts.length,
              separatorBuilder: (context,ind)=> Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: Colors.grey,),
              ),
              itemBuilder: (BuildContext context , index)=>renderDealProduct(deal.dealProducts[index], index, context)),
        ],
      ),
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
                            Text("${product.discountedPrice}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            product.discountedPrice == null || product.discountedPrice == product.saleAmount
                                ? Container()
                                : Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            product.discountedPrice == null || product.discountedPrice == product.saleAmount
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
                    Text("${product.title??""} ${utf8.decode(product.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("(${product.unitName})", style: TextStyle(fontSize: 16,color: Colors.black54),),
                    SizedBox(height: 10,),
                    Text('${product.saleQuantity} × ${product.discountedPrice} = ${product.subTotal}'),
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
