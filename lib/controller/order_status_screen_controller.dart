import 'package:get/get.dart';
import 'package:sabzishop/services/http_service.dart';

class OrderStatusScreenController extends GetxController{
RxBool progressing = false.obs;


cancelOrder(String orderId) async {
  progressing.value= true;
var result=  await HttpService.cancelOrder(orderId: orderId);
return result;
}
}