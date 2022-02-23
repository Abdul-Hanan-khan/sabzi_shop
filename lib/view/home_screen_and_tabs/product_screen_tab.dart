import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/cart_controller.dart';
import 'package:sabzishop/controller/product_screen_controller.dart';
import 'package:sabzishop/view/stepper/stpper_bar.dart';
import 'package:sabzishop/widgets/my_product.dart';
import 'package:sabzishop/widgets/url_launcher_whatsapp.dart';
import 'homepage.dart';

class ProductScreenTab extends StatelessWidget {
TextEditingController searchController = TextEditingController();
ProductScreenController controller = Get.find();
RefreshController _refreshController = RefreshController();


CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
          leading: Container(),
          leadingWidth: 0,
          title: Text(controller.appBarTitle.value),
          actions: [
            Obx(()=> controller.searchinProgress.value?Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2,)),
              ),
            ):
            IconButton(
              onPressed: () {
                searchController.clear();
                controller.toogleSerach();
              },
              icon:  Icon(
              controller.search.value
                  ? Icons.search_off
                  :Icons.search,
                color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(StepperBar());
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        Get.to(StepperBar());
                      },
                      color: Colors.black
                  ),
                  Obx(
                        () => Stack(
                      alignment: Alignment.center,
                      children: [
                        cartController.cart.deals.length == 0 && cartController.cart.products.length == 0
                            ? Container()
                            : Icon(
                          Icons.circle,
                          color: ColorPalette.green,
                        ),
                        Text(
                          (cartController.cart.products.length + cartController.cart.deals.length).toString(),
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ]
              ),
            ),
          ],
          bottom:PreferredSize(
            child: Obx(
                (){
                  if(controller.search.value){
                    controller.searchFocus.requestFocus();
                  }
                  else{
                    controller.searchFocus.unfocus();
                  }
                  return  !controller.search.value
                ? Container()
                : Container(
                  height:60.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                    children: [
                      TextField(
                        onEditingComplete: (){
                          controller.searchProducts(searchString: searchController.text,searchMore: false).then((value) {
                            controller.searchFocus.unfocus();
                          });
                        },
                        focusNode: controller.searchFocus,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        // hintText: "Type Order number,Merchant name or Pick/Delivery Date",
                        decoration: InputDecoration(
                          hintText: "Search item",
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                          ),
                        ),
                        onChanged:(val){
                          if(val.length==0)
                            {
                              Get.back();
                              controller.toogleSerach();
                            }
                          else
                            {
                              // controller.searchProducts(searchString: val,searchMore: false);
                            }
                        },
                        controller: searchController,
                      ),
                    ],
                  ),
                ),
              );
              }
            ),
            preferredSize: Size.fromHeight(controller.search.value?60.0:0.0),
          ),
        ),
        body: Obx(
            ()=> SmartRefresher(
            enablePullUp: controller.search.value?
            !(controller.productsModal.value.totalPages==controller.currentSearchPage.value):
            !(controller.productsModal.value.totalPages==controller.currentPage.value),
            controller: _refreshController,
            onRefresh: (){
              if(controller.search.value)
            {
              controller.appBarTitle.value='Our Products';

              controller.searchProducts(searchString: searchController.text, searchMore: false).then((value)  {
                _refreshController.refreshCompleted();
              });
            }
              else
                {
                  controller.loadProducts(loadMore: false).then((value)  {
                    _refreshController.refreshCompleted();
                    controller.appBarTitle.value='Our Products';
                  });
                }
            },
              onLoading: (){
                controller.search.value
                  ? controller.searchProducts(searchString: searchController.text, searchMore: true).then((value) {_refreshController.loadComplete();})
                  :controller.loadProducts(loadMore: true).then((value) {_refreshController.loadComplete();});
            },
            child: SingleChildScrollView(
              child: Center(
                child: Obx(
                    ()=> controller.productsModal.value.products.length == 0? Container(
                      height: Get.height*0.9,
                      child: Center(
                        child: Text('No Products found in this list',style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ): Wrap(
                  // children:  MyProduct(outOfStock: false,quantity: 0.obs,),
                  children: controller.productsModal.value.products.map((product) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8),
                    child: MyProduct(product: product),
                  ), ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: UrlLauncherWhatsapp(),
      ),
    );
  }
}
