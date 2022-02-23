import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/modal/dashboad.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_label.dart';

class LatestOrderScreen extends StatelessWidget {

  Order order;
  LatestOrderScreen({this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Order Details', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // order.driverId == "0"
                    //     ? Container(width: 0, height: 0,)
                    //     : Column(
                    //   children: [
                    //     Container(
                    //       width: double.infinity,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text('Driver Details: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 16, color: Colors.black54),),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(order.driverDetails.name, style: TextStyle(fontSize: 16,),),
                    //                 Row(
                    //                   children: [
                    //                     Icon(Icons.phone, size: 18,),
                    //                     Text('\t${order.driverDetails.phone}', style: TextStyle(fontSize: 16,),),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(height: 5,),
                    //     Container(
                    //       height: 2,
                    //       decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //               colors: [
                    //                 Colors.white,
                    //                 ColorPalette.green,
                    //                 Colors.white,
                    //               ]
                    //           )
                    //       ),
                    //     )
                    //   ],
                    // ),

                    // SizedBox(height: 20,),
                    ...order.orderDetails.map((e) => rendringProduct(e, context)).toList(),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyLabel(
                    label: order.status,
                    backGroundColor: order.status == 'Pending' ? ColorPalette.orange.shade800 : order.status == 'Cancelled' ? Colors.red : ColorPalette.green.shade800,
                  ),
                  Row(
                    children: [
                      Text('Total : Rs ', style: TextStyle( fontSize: 16),),
                      Text('${double.parse(order.amount).toStringAsFixed(2)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  rendringProduct(OrderDetails order, BuildContext context){
    return order.type == 'product' ? Padding(
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
                            child: Image.network(order.productPhoto)
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${order.discountedPrice}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            order.discountedPrice == null ?Container():
                            Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            order.discountedPrice == null ?Container():
                            Text("${order.saleAmount}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
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
                    Text("${order.productTitle} ${utf8.decode(order.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("(${order.unitName})", style: TextStyle(fontSize: 16,color: Colors.black54),),
                    SizedBox(height: 10,),
                    Text('${order.saleQuantity} × ${order.discountedPrice} = ${order.subTotal}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            height: 2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      ColorPalette.green,
                      Colors.white,
                    ]
                )
            ),
          ),
        ],
      ),
    ) : Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[600]),
                  color: ColorPalette.green.shade200,
                  borderRadius: BorderRadius.circular(10)
              ),
              height: 40,
              child: Center(
                child: Text('${order.dealInformation.title}\t ${utf8.decode(order.dealInformation.urduTitle.codeUnits)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
            ),
            SizedBox(height: 10,),
            ...order.dealDetails.map((deal) =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 150,
                                height: 100,
                                child: Image.network(deal.productPhoto)
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("${deal.discountedPrice}", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                deal.discountedPrice == null ?Container():
                                Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                deal.discountedPrice == null ?Container():
                                Text("${deal.saleAmount}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
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
                        Text("${deal.productTitle} ${utf8.decode(deal.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("(${deal.unitName})", style: TextStyle(fontSize: 16,color: Colors.black54),),
                        SizedBox(height: 10,),
                        Text('${deal.saleQuantity} × ${deal.discountedPrice} = ${deal.subTotal}'),
                      ],
                    ),
                  ],
                )
            ).toList(),
            Divider(color: Colors.grey[400],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 25,),
                    Text('${order.saleQuantity} × ${order.dealInformation.dealAmount}\t\t', style: TextStyle(fontSize: 16,),),
                    Text('${order.dealInformation.originalDealTotal}', style: TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.black54),),
                  ],
                ),
                Row(
                  children: [
                    Text('Rs ', style: TextStyle(fontSize: 16,),),
                    Text('${(double.parse(order.saleQuantity)*double.parse(order.dealInformation.dealAmount)).toStringAsFixed(2)}', style: TextStyle(fontSize: 16,),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    ColorPalette.green,
                    Colors.white,
                  ]
                )
              ),
            ),
          ],
        ),
      ),
    );

//   Column(children: order.dealDetails.map((deal) =>
//
//   ).toList(),);
  }
}
