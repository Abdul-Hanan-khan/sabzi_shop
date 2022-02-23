import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/modal/category.dart';
import 'package:sabzishop/services/http_service.dart';

class HomeScreenController extends GetxController{
  HomeScreenController(){
     loadOrders();
  }
  RxBool progressing = false.obs;
  List<Categories> categoriesList = <Categories>[].obs;

  loadOrders() async {
    progressing.value = true;
    categoriesList = await HttpService.getCategories();
    progressing.value = false;
  }
}


//controller.user.value.id