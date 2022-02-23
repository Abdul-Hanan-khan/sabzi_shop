import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/deal_screen_controller.dart';
import 'package:sabzishop/controller/home_screen_controller.dart';
import 'package:sabzishop/controller/product_screen_controller.dart';
import 'package:sabzishop/modal/category.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/statics/static_var.dart';
import 'package:sabzishop/widgets/my_appbar.dart';


class HomeScreenTab extends StatelessWidget {
  BottomBarController bottomBarController = Get.find();
  HomeScreenController controller = HomeScreenController();
  ProductScreenController productScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidgets("").getMyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Carousel(
                  dotSize: 5,
                  dotSpacing: 10,
                  autoplay: false,
                  dotColor: Colors.white,
                  dotIncreasedColor: ColorPalette.green,
                  indicatorBgPadding: 5,
                  dotBgColor: Colors.transparent,
                  dotVerticalPadding: 5,
                  images: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(StaticVariable.initial_slide_1,),
                            fit:BoxFit.cover
                        )
                      ),
                        // child: Image.network(StaticVariable.initial_slide_1)
                    ),Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(StaticVariable.initial_slide_2,),
                            fit:BoxFit.cover
                        )
                      ),
                        // child: Image.network(StaticVariable.initial_slide_1)
                    ),Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(StaticVariable.initial_slide_3,),
                            fit:BoxFit.cover
                        )
                      ),
                        // child: Image.network(StaticVariable.initial_slide_1)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('تازہ خریدیں ، تازہ کھائیں ، صحت مند رہیں۔', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Text('Buy Fresh, Eat Fresh, be Healthy.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
              controller.categoriesList.isNull || controller.categoriesList == null
                  ? Center(
                child: Text('Some trouble in getting item , try checking internet connection', style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
              )
                  : Obx(
                    ()=> controller.progressing.value ? Center(child: CircularProgressIndicator(),) : Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    // color: Colors.red,
                    height: Get.height*0.5,
                    child: ListView.builder(
                      itemCount: controller.categoriesList.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            listItem(controller.categoriesList[index] , index),
                            SizedBox(height: 10,),
                            Divider(color: Colors.grey,height: 2,)
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(Categories item,int index ){
    return  ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: Get.width*0.25,
                    width: Get.width*0.25,
                    child: Image.network(item.banner, fit: BoxFit.cover,)
                ),
                SizedBox(width: 10,),
                Container(
                  // color: AppColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          item.title,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: Get.width *0.42,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            item.shortDetails,
                            style: TextStyle(color: Colors.black38,fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height:3),

          ],
        ),
        textColor: Colors.black,
        children:[
          Container(
            color: Colors.white60,
            width: Get.width,
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList[index].subCategories.length,
              itemBuilder: (contex,subIndex){
                return
                  GestureDetector(
                    onTap: () async {
                      ProductsModal productResult = await HttpService.getProductsOfSubCategory(1,controller.categoriesList[index].subCategories[subIndex].id);
                      productScreenController.productsModal.value = productResult;
                      productScreenController.appBarTitle.value=controller.categoriesList[index].subCategories[subIndex].title;
                      bottomBarController.currentBNBIndex.value=1;
                    },
                    child: Container(

                      decoration:BoxDecoration(
                        border: Border.all(color: Colors.grey[200]),
                      ) ,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              child: Container(
                                  height: 100,
                                  width: 120,
                                  child: Image.network(item.subCategories[subIndex].photo, fit: BoxFit.cover,)
                              ),
                            ),
                            Text(
                              item.subCategories[subIndex].title,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              },
            ),
          ),
        ]
    );

  }

}
