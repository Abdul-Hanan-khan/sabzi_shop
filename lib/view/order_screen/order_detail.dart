import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/view/order_screen/deal_detail_product.dart';
import 'package:sabzishop/widgets/my_label.dart';
import 'package:url_launcher/url_launcher.dart';


class OrderDetailScreen extends StatelessWidget {
  Order order;
  OrderDetailScreen({this.order});

  @override
  Widget build(BuildContext context) {
    Color labelColor = Colors.black54;
    if(order.status== "Completed")
    {
      labelColor = ColorPalette.green;
    }
    if(order.status== "Pending")
    {
      labelColor = ColorPalette.orange;
    }
    if(order.status== "Cancelled")
    {
      labelColor = Colors.red;
    }
    return Scaffold(
      backgroundColor: Colors.white,
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
                    order.driverId == "0"
                    ? Container(width: 0, height: 0,)
                    : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Driver Details: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 16, color: Colors.black54),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(order.driverDetails.name, style: TextStyle(fontSize: 16,),),
                                    GestureDetector(
                                      onTap:()  {
                                        _makePhoneCall(order.driverDetails.phone);
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 12,
                                            backgroundColor: Colors.green,
                                            child: Icon(Icons.phone, size: 18,color: Colors.white,),
                                          ),
                                          Text('\t${order.driverDetails.phone}', style: TextStyle(fontSize: 16,),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...order.orderDetails.map((e) => renderingDeal(e, context)).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
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
                    borderRadius: 5,
                    backGroundColor: labelColor
                  ),
                  Row(
                    children: [
                      Text('Total : Rs ', style: TextStyle( fontSize: 16),),
                      Text('${int.parse(order.amount)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),),
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
    return  order.type=='product' ? Column(
      children: [
        Padding(
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
                                order.discountedPrice == "" || order.discountedPrice == null || order.discountedPrice == order.saleAmount
                                    ? Container()
                                    : Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                order.discountedPrice == "" || order.discountedPrice == null || order.discountedPrice == order.saleAmount
                                    ? Container()
                                    : Text("${order.saleAmount}", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
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
                        Text("${order.productTitle}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("${utf8.decode(order.urduTitle.codeUnits)}", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
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
              Divider(color: Colors.grey,),
            ],
          ),
        ),
      ],
    ) : Container();

//   Column(children: order.dealDetails.map((deal) =>
//
//   ).toList(),);
  }

  renderingDeal(OrderDetails order, BuildContext context){
    return order.dealInformation == null
      ? Container()
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GestureDetector(
            onTap: (){
              Map<String, dynamic> json = order.dealInformation.toJson();
              json['deal_details']= order.toJson()['deal_details'];
              Get.to(() => DealDetail(deal: Deal.fromJson(json),));
            },
            child: Container(
              height: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: order.dealDetails.length == 1 ? Get.width-20 : Get.width-40,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Card(

                        child:ListTile(
                            title: Row(

                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: Image.network(order.dealInformation.squareImage,fit: BoxFit.cover,),

                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(order.dealInformation.title,style: TextStyle(fontWeight: FontWeight.w800)),
                                    Text(utf8.decode(order.dealInformation.urduTitle.codeUnits),style: TextStyle(fontWeight: FontWeight.w800)),
                                    SizedBox(height: 10,),
                                    Container(
                                        width: Get.width*0.4,
                                        child: Text(order.dealInformation.shortDetails,style: TextStyle(color: Colors.grey))),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text("Total price"),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("${order.saleQuantity} × ${order.dealInformation.dealAmount} = ",),
                                            Text("${(double.parse(order.saleQuantity)* double.parse(order.dealInformation.dealAmount)).toStringAsFixed(0)}",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: ColorPalette.green,
                        child: Text("${order.saleQuantity}X",style: TextStyle(fontSize: 8,color: Colors.black,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

  }

  Future<void> _makePhoneCall(String url) async {
    String phoneNumber = 'tel:'+url;
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $url';
    }
  }

}
