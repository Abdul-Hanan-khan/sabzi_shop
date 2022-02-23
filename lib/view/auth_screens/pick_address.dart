import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/place_order_login_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';

class PickAddress extends StatelessWidget {
  AuthController authController = Get.find();
  PlaceOrderLoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Select an Address', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          ListView.builder(
              itemCount: authController.user.value.addresses.length,
              shrinkWrap: true,
              itemBuilder: (context,index) {
                return addressItem(authController.user.value.addresses[index], index, controller.isSelected.value);
              }
          ),
        ],
      ),
    );
  }

  addressItem(Address address, int index, bool selected){
    int addressIndex = authController.user.value.addresses.indexWhere((element) => element.id==controller.currentAddress.value.id);
    return GestureDetector(
      onTap: () {
        controller.currentAddress.value = authController.user.value.addresses[index];
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: index==addressIndex ? ColorPalette.green[100] : Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(color: Colors.grey[500]),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child:
                  Text(
                    address.address??"",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      address.colonyName,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      address.city,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                address.manualAddress== "" || address.manualAddress==null
                   ? Container()
                   : Container(
                  child:
                  Text(
                    address.manualAddress??"",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// class SelectableContainer extends StatelessWidget {
//   SelectableContainer({
//      this.controller,
//      this.index,
//     this.isSelected,
//   });
//
//   AuthController controller;
//   int index;
//   bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: isSelected ? ColorPalette.green : Colors.transparent),
//             color:  isSelected ? ColorPalette.green.shade300 : Colors.black12,
//             borderRadius: BorderRadius.circular(6),
//           ),
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: Get.width-33,
//                       child: Text('${controller.user.value.addresses[index].address}\t\t\t', style: TextStyle(fontSize: 16,),),
//                     ),
//                     SizedBox(height: 3,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('${controller.user.value.addresses[index].colonyName}, ', style: TextStyle(fontSize: 16,),),
//                         Text('${controller.user.value.addresses[index].postcode},\t\t\t', style: TextStyle(fontSize: 16,), ),
//                         Text(controller.user.value.addresses[index].city, style: TextStyle(fontSize: 16,),),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 7,),
//       ],
//     );
//   }
// }



}
