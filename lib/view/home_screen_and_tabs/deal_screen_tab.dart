import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/deal_screen_controller.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/widgets/my_appbar.dart';
import 'package:sabzishop/widgets/url_launcher_whatsapp.dart';

import '../deal_detail_screen.dart';

class DealScreenTab extends StatelessWidget {
  DealScreenController controller = Get.find();
  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidgets("").getMyAppBar(),
      body:Container(
        child: controller.deals==null || controller.deals.length==0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No deals available yet", style: TextStyle(color: Colors.black, fontSize: 18),),
                    // ElevatedButton(child: Text("Refresh"),onPressed: (){
                    //   controller.loadDeals();
                    // },)
                  ],
                ),
              )
            : Obx(
              ()=> SmartRefresher(
                controller: _refreshController,
                onRefresh: (){
                  controller.loadDeals().then((value)  {
                    _refreshController.refreshCompleted();
                  });
                },
                child: ListView.builder(
                  itemCount: controller.deals.length,
                  itemBuilder: (BuildContext context, index)=>renderListItem(controller.deals.value[index]),
                ),
              ),
        ),
      ),
      floatingActionButton: UrlLauncherWhatsapp(),
    );
  }
  Widget renderListItem(Deal deal){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // color: ColorPalette.green.shade50,
        child:ListTile(
          onTap: (){
            Get.to(()=>DealDetailScreen(deal));
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                  width: Get.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(deal.fullImage,fit: BoxFit.cover,))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(deal.title,style: TextStyle(fontWeight: FontWeight.w800)),
                  Text(utf8.decode(deal.urduTitle.codeUnits),style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
              SizedBox(height: 10,),
              Text(deal.shortDetails,style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expires on"),
                  Text(deal.expiryDate,style: TextStyle(color: ColorPalette.orange)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total price"),
                  Text("Rs ${deal.dealAmount}",style: TextStyle(color: ColorPalette.green, fontWeight: FontWeight.bold),),
                ],
              ),

            ],
          ),
        )
      ),
    );
  }

}