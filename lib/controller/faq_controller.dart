import 'package:get/get.dart';
import 'package:sabzishop/modal/faq_model.dart';
import 'package:sabzishop/services/http_service.dart';

class FAQController extends GetxController{

  RxInt expandedIndex = 0.obs;

  String answers;
  RxBool loading = true.obs;
  List<Faq> faqs =[];
  FAQController(){
    loadFaqs();
  }

  loadFaqs() async{
    faqs = await HttpService.getFaqs();
    expandedIndex.value = faqs.length;
    loading.value = false;
  }



}