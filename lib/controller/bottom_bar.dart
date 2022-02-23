import 'package:get/get.dart';

class BottomBarController extends GetxController{
  RxInt currentBNBIndex = 1.obs;


  void indexChanged(int index){
    currentBNBIndex.value = index;
  }
}