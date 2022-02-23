import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/controller/home_screen_controller.dart';
import 'package:sabzishop/controller/product_screen_controller.dart';
import 'package:sabzishop/modal/category.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/widgets/my_appbar.dart';


class DummyOrderHistory extends StatelessWidget {

  HomeScreenController controller = HomeScreenController();
  BottomBarController bottomController= Get.find();
  ProductScreenController productScreenController = Get.find();
   @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: MyAppBarWidgets("").getMyAppBar(),
        body: controller.categoriesList.isNull || controller.categoriesList == null
          ? Center(
          child: Text('Some trouble in getting item , try checking internet connection', style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
        )
          : Obx(
              ()=> controller.progressing.value ? Center(child: CircularProgressIndicator(),) : Padding(
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
              itemCount: controller.categoriesList.length,
                  itemBuilder: (context,index){
                return Column(
                  children: [
                    listItem(controller.categoriesList[index] , index),
                    SizedBox(),
                    Divider(color: Colors.grey,height: 2,)
                  ],
                );
                  },


                  // ...controller.categoriesList.map((item) =>





                      // listItem(item)),

            ),
          ),
        )
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
                      width: Get.width *0.45,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          item.shortDetails,
                          style: TextStyle(color: Colors.black38),
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
                       ProductsModal productResult = await HttpService.getProductsOfSubCategory(1,controller.categoriesList[index].id);
                       productScreenController.productsModal.value = productResult;
                       bottomController.currentBNBIndex.value=1;
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
                          padding: const EdgeInsets.all(8.0),
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
