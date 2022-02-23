import 'package:get/get.dart';
import 'package:sabzishop/services/http_service.dart';

class StepperController extends GetxController{
  RxInt counter = 0.obs;
  double packagingCharges=0;
  double deliveryCharges=0;
  String dateOption;
  RxString appbarTitle = "My Cart".obs;
  String billingAddress;
  RxInt currentIndex = 0.obs;

  @override
  onInit(){
    loadCharges();
    super.onInit();
  }

  StepperController() {
    loadCharges();
  }

  loadCharges() async {
    var response = await HttpService.getPackagingandServiceDelivery();
    packagingCharges = double.parse(response['packaging_charges']);
    deliveryCharges = double.parse(response['product_delivery']);
    dateOption = response['date_option'];
    print(dateOption);
  }

}