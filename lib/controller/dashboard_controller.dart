import 'package:get/get.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/modal/dashboad.dart';
import 'package:sabzishop/services/http_service.dart';

class DashBoardController extends GetxController{
  AuthController controller = Get.find();

  RxBool progressing = false.obs;
  DashBoard dashBoard;


  DashBoardController(){
    loadDashboardList();
  }

  loadDashboardList() async {

    progressing.value =true;
    dashBoard = await HttpService.getDashBoardlist(customerId: controller.user.value.id);
    progressing.value =false;

  }

}