import 'package:get/get.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/services/http_service.dart';

class OrderHistoryController extends GetxController{
  AuthController authController = Get.find();
  RxString sorteditem = 'All Orders'.obs;
  RxBool progressing =false.obs;
  OrderHistoryModal modal = OrderHistoryModal(orders: <Order>[].obs);
  int currentPage = 1;
  List<Order> orderHistoryBackupList = [];
  OrderHistoryController(){
    loadOrders();
  }
//  void init(){
//    loadOrders();
//    super.onInit();
//  }

  //Pending,Verified,Processed,In-deliver,Completed,Cancelled

  sortItems(){
  if(sorteditem.value == "All Orders")
    {
      modal.orders.clear();
      modal.orders.addAll(orderHistoryBackupList);
    }
  else
    {
      modal.orders.clear();
      orderHistoryBackupList.forEach((orderHistoryItem) {
        modal.orders.addIf(orderHistoryItem.status.toUpperCase() == sorteditem.value.toUpperCase(), orderHistoryItem);
      });
    }
  }

  Future<void> loadOrders() async {
    progressing.value = true;
     HttpService.getOrdersHistory(
        customerId: authController.user.value.id.toString(),
      pageNo: 1
    ).then((value) {
       currentPage = 1;
      modal.orders.clear();
      orderHistoryBackupList.clear();
      orderHistoryBackupList.addAll(value.orders.value);

       if(sorteditem.value != "All Orders")
        {
          sortItems();
        }
      else
        {
        modal.orders.addAll(value.orders);
      }
      modal.totalPages = value.totalPages;
      progressing.value = false;
    });
  }

  Future<void> loadMoreOrders() async {
    currentPage++;
    HttpService.getOrdersHistory(
        customerId: authController.user.value.id.toString(),
        pageNo: currentPage
    ).then((result) {
    if(result==null)
      {
        currentPage--;
      }
    else
      {
        orderHistoryBackupList.addAll(result.orders.value);
        if(sorteditem.value != "All Orders")
        {
          sortItems();
        }
        else
        {
          modal.orders.addAll(result.orders);
        }
        progressing.value = false;
      }
    });

  }
}

