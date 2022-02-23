import 'package:get/get.dart';
import 'package:sabzishop/modal/slides.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';

class SliderScreenController  extends GetxController{
Slides slides = Slides();
RxBool loading = true.obs;


SliderScreenController(){
  loadSlides().then((value) {
    loading.value = false;
  }).onError((error, stackTrace) {
    Utils.showToast("Check Your internet connection and try again");
  });
}



 Future<void> loadSlides() async {
slides = await HttpService.getSlides();
  }


}