import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/order_status_screen_controller.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/view/order_screen/order_detail.dart';
import 'package:sabzishop/view/order_screen/order_history.dart';
import 'package:sabzishop/widgets/AlertDialogeWidget.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:intl/intl.dart';



class OrderStatusScreen extends StatelessWidget {
  Order order;
  OrderStatusScreen({this.order});
  OrderStatusScreenController controller = OrderStatusScreenController();
  List<String> statusList = ['Pending','Verified','Processed','In-deliver','Completed'];

  @override
  Widget build(BuildContext context) {
    if(order.status=="Cancelled"&& !statusList.any((element) => element=="Cancelled"))
    {
      statusList.add("Cancelled");
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.off(() => OrderHistoryScreen());}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Order Status', style: TextStyle(color: Colors.black),),
      ),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Obx(
      ()=> ModalProgressHUD(
        inAsyncCall: controller.progressing.value,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order #:${order.id}"),
                     order.status == "Pending"
                       ? MyFilledButton(txt: "Cancel",
                         color: ColorPalette.orange,
                         borderRadius: 5,
                         width: 100,
                         height: 30,
                         ontap: (){
                           showDialog(context: context, builder: (BuildContext context){
                             return  AlertDialogWidget(title: "Cancel Order?",
                            subTitle: "Are you sure to cancel this order?",
                            onPositiveClick: () async {
                           Get.back();
                            String status =  await  controller.cancelOrder(order.id);
                            if(status=="success")
                              {
                                order.status="Cancelled";
                                order.cancelledDate = DateFormat('dd/MM/yyyy KK:MM').format(DateTime.now()).toString();
                                statusList.add("Cancelled");
                                controller.progressing.value = false;
                               // Get.off(OrderHistoryScreen(cancel: 'Cancelled',));
                              }
                            },
                          );
                           });
                         },
                       )
                       : Container()
                    ],
                  ),
                  Divider(),
                  // Stepper(steps: statusList.map((status){
                  //   return Step(
                  //       title: Text(status),
                  //       content: Container(child: Text("Test"),),
                  //     state:   StepState.indexed,
                  //     isActive: statusIndex("Processed")>= statusIndex(status)
                  //   );
                  // }).toList(),
                  // // currentStep: statusIndex(order.status),
                  // )

                  ...statusList.map((status) {
                    // order.status = "Cancelled";
                    if(order.status=="Cancelled")
                    {
                      return StepperRow(status=="Cancelled",status);
                    }
                    else
                      return  StepperRow(statusIndex(order.status)>= statusIndex(status),status);
                  }
                  ).toList(),
                  SizedBox(height: 20,),
                  Divider(thickness: 5,),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Order Date: "),
                      Text(order.createdDate,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Delivery Date: "),
                      Text(order.deliveryDate,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Packaging Charges: "),
                      Text(order.packagingCharges == "0" ? "Free" : order.packagingCharges,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Delivery Charges: "),
                      Text(order.productDelivery == "0" ? "Free" : order.productDelivery,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Total Price: "),
                      Text(order.amount,style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Payment Mode: "),
                      Text("COD",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Delivery Time Slot: "),
                      Text("${order.timeFrom} - ${order.timeTo}",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text("Delivery Address: "),
                  Flexible(child: Text("${order.billingAddress.address} ",style: TextStyle(fontWeight: FontWeight.bold),)),
                  Flexible(child: Text("${order.billingAddress.manualAddress} ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black45),))

                ],
              ),
            ),
            MyFilledButton(
              borderRadius: 10,
              txt:"View Order Details",
              color: ColorPalette.green,
              width: Get.width-16,
              ontap: (){
                Get.to(OrderDetailScreen(order: order,));
              },
            ),
          ],
        ),
      ),
    ),
  ),

    );
  }

Widget StepperRow(bool active,String status){
    Color dotColor = ColorPalette.green;
   String date = "";
   if(status==statusList[0])
     {
       date = order.createdDate??"";
     }
   else if(status == statusList[1])
   {
     date = order.verifiedDate??"";
   }
   else if(status == statusList[2])
   {
     date = order.processedDate??"";
   }
   else if(status == statusList[3])
   {
     date = order.assignedDate??"";
   }
   else if(status == statusList[4])
   {
     date = order.paidDate??"";
   }
   else if(status == statusList[5])
   {
     date = order.cancelledDate??"";
     dotColor = Colors.red;
   }

   return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Container(
                width: 2,
                height: 30,
                color: Colors.grey,
              ),
            ),
            Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle,color: active?dotColor:Colors.grey,size: 15,),
                Container(
                    width: 100,
                    child: Text(" "+status)),
                SizedBox(width: 50,),
                Text(date),
              ],
            )
          ],
        ),

      ],
    );

}

 int statusIndex(String status){
   return statusList.indexOf(status);
  }

}
