import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/order_history_screen_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/view/order_screen/order_detail.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_label.dart';

import 'order_status_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  String cancel;
  OrderHistoryScreen({this.cancel});
  OrderHistoryController controller = OrderHistoryController();
  AuthController authController = Get.find();
  RefreshController refreshController = RefreshController();

  List<String> sortedTerms = ['All Orders','Pending','Verified','Processed','In-deliver','Completed','Cancelled'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Get.back();
          }, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Orders History', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
      () => controller.progressing.value
      ? Center(child: CircularProgressIndicator(),)
      : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          ()=> Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[600],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Text(controller.sorteditem.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                      DropdownButton<String>(
                        isExpanded: true,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 3.0),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey[600],
                          ),
                        ),
                        iconSize: 30,
                        style: TextStyle(color: ColorPalette.green),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (newValue) {
                          controller.sorteditem.value = newValue;
                          controller.sortItems();
                        },
                        items: sortedTerms.map((value) =>
                          DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),),
                          )
                        ).toList()
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: Get.height-195,
                child: controller.modal.orders.length ==0
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.search), iconSize: 50,),
                      SizedBox(height: 15,),
                      Text('You have no orders yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ],
                  ),
                )
                    : Obx(
                  ()=> controller.modal.orders.length == 0
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(icon: Icon(Icons.search), iconSize: 50,),
                        SizedBox(height: 15,),
                        Text('No Order Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        SizedBox(height: 15,),
                        Text('Manage your orders here', style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  )
                      : SmartRefresher(
                  controller: refreshController,
                        onLoading: (){
                      controller.loadMoreOrders().then((value) =>refreshController.loadComplete());
                        },
                  onRefresh: (){
                      controller.loadOrders().then((value) => refreshController.refreshCompleted());
                  },
                  enablePullUp: controller.currentPage<controller.modal.totalPages.value,
                        child: ListView.builder(
                        itemCount: controller.modal.orders.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index)=> renderListItem(controller.modal.orders[index]),
                ),
                      ),
                    ),
              ),
//                ...controller.orderHistoryList.map((order) => renderListItem(order)).toList(),
            ],
          ),
        ),
          ),
      ),
    );
  }

  renderListItem(Order order){
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
    return GestureDetector(
      onTap: (){
        Get.off(OrderStatusScreen(order:order));
      },
      child: Column(
        children: [
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
                border: Border.all(color: Colors.grey[800]),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID # ${order.id}', style: TextStyle(fontSize: 18, color: Colors.black),),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Created On:', style: TextStyle(fontSize: 18, color: Colors.black),),
                      Text(order.createdDate, style: TextStyle(fontSize: 18, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.label, style: TextStyle(fontSize: 18, color: Colors.black),),
                      MyLabel(
                        label: order.status,
                        backGroundColor: labelColor,
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
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}



