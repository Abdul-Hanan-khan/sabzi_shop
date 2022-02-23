import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/dashboard_controller.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/view/order_screen/latest_order_screen.dart';
import 'package:sabzishop/view/order_screen/order_detail.dart';
import 'package:sabzishop/view/order_screen/order_status_screen.dart';
import 'package:sabzishop/widgets/my_label.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardController controller = DashBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('My Dashboard', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => controller.progressing.value
            ? Center(child: CircularProgressIndicator(),)
            : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  controller.dashBoard.latestOrder == null
                      ? Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      child: Text('You have no Latest Orders', style: TextStyle(fontSize: 20,))
                    ),)
                      :  GestureDetector(
                  onTap: (){
                    Get.to(OrderStatusScreen(order: controller.dashBoard.latestOrder,));
                    // Get.to(LatestOrderScreen(order: controller.dashBoard.latestOrder,));
                  },
                  child: Column(
                    children: [
                      Text('Your Latest Order', style: TextStyle(fontSize: 20,),),
                      SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(color: Colors.grey[500]),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ID # ${controller.dashBoard.latestOrder.id}', style: TextStyle(fontSize: 18, color: Colors.black),),
                              SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Created On:', style: TextStyle(fontSize: 18, color: Colors.black),),
                                  Text(controller.dashBoard.latestOrder.createdDate, style: TextStyle(fontSize: 18, color: Colors.black),),
                                ],
                              ),
                              SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.dashBoard.latestOrder.label, style: TextStyle(fontSize: 18, color: Colors.black),),
                                  MyLabel(
                                    label: controller.dashBoard.latestOrder.status,
                                    backGroundColor: controller.dashBoard.latestOrder.status == 'Cancelled' ?  Colors.red : controller.dashBoard.latestOrder.status == 'Pending' ? ColorPalette.orange : controller.dashBoard.latestOrder.status == 'In-deliver' ? Colors.grey[800] : ColorPalette.green,
                                    // height: 35,
                                    // width: 100,
                                    borderRadius: 5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Divider(color: Colors.grey[800],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivered Orders', style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text(controller.dashBoard.deliveredOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(color: Colors.grey[800],),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pending Orders', style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text(controller.dashBoard.pendingOrders, style: TextStyle(fontSize: 20, color: Colors.black),),
                  ],
                ),
                  SizedBox(height: 10,),
                  Divider(color: Colors.grey[800],),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Spent', style: TextStyle(fontSize: 20, color: Colors.black),),
                      Text(controller.dashBoard.totalSpending, style: TextStyle(fontSize: 20, color: Colors.black),),
                    ],
                  ),
              ],
            ),
        ),
      ),
    );
  }
}
