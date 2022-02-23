import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/services/http_service.dart';

class ProductScreenController extends GetxController{
  RxInt currentPage = 1.obs;
  RxInt currentSearchPage = 1.obs;
  Rx<ProductsModal> productsModal = ProductsModal(products: <Product>[].obs,totalPages: 0).obs;
  List<Product> duplicatedProductsModal = [];
  RxBool search = false.obs;
  RxString appBarTitle='Our Products'.obs;
  RxBool searchinProgress = false.obs;
  FocusNode searchFocus = FocusNode();
  // ProductScreenController(){
  //   loadProducts(loadMore: false);
  // }
  @override
  void onInit() {
    loadProducts(loadMore: false);
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> loadProducts({@required bool loadMore}) async {
print('calling load products');
    if(!loadMore)
      {
        currentPage = 1.obs;
        ProductsModal productResult = await HttpService.getProducts(currentPage.value)??ProductsModal(products: <Product>[].obs,totalPages: 0).obs;
        productsModal.value = productResult;
      }
    else
      {
        currentPage.value++;
        ProductsModal productResult =await HttpService.getProducts(currentPage.value);
        productsModal.value.products.addAll(productResult.products);
        update();
        print("added");
      }
  }


  Future<void> searchProducts({@required String searchString,@required bool searchMore}) async {
    searchinProgress.value = true;
   if(!searchMore)
     {
       ProductsModal searchResult =  await  HttpService.searchProduct(currentSearchPage.value, searchString);
       searchinProgress.value = false;
    productsModal.value = searchResult;

     }
   else
     {
       currentSearchPage.value++;
       ProductsModal searchResult =  await  HttpService.searchProduct(currentSearchPage.value, searchString);
       searchinProgress.value = false;
       productsModal.value.products.addAll(searchResult.products);
     }
  }
  toogleSerach(){
    if(search.value){
      print(true);
      search.value = false;
      productsModal.value.products.clear();
      productsModal.value.products.addAll(duplicatedProductsModal);
      currentSearchPage.value = 1;
    }
    else
    {
      print(false);
      search.value = true;
      duplicatedProductsModal.clear();
      duplicatedProductsModal.addAll(productsModal.value.products.value);
    }
  }
}