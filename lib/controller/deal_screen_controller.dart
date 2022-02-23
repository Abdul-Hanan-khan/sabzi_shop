import 'package:get/get.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/services/http_service.dart';

class DealScreenController extends GetxController{
RxList<Deal> deals = <Deal>[].obs;
RxBool progressing = false.obs;


  @override
  void onInit() {

    loadDeals();
    // TODO: implement onInit
    super.onInit();
  }

  loadDeals() async {
     progressing.value = true;
       deals.value = await HttpService.getDeals();
     progressing.value = false;
     print(deals.toString());
  }


}