import 'package:cached_map/cached_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/auth_screens/add_address.dart';
import 'package:sabzishop/view/auth_screens/edit_address.dart';
import 'package:sabzishop/view/auth_screens/personal_information.dart';
import 'package:sabzishop/view/my_google_map.dart';
import 'package:sabzishop/widgets/AlertDialogeWidget.dart';

class Profile extends StatelessWidget {
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('My Profile', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () =>  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                () => Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.green, width: 2),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.green),),
                            IconButton(onPressed: () {Get.to(UpdateProfile());}, icon: Icon(Icons.edit, color: ColorPalette.green,)),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('${controller.user.value.name}', style: TextStyle(fontSize: 16,), )
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('${controller.user.value.phone}', style: TextStyle(fontSize: 16,), )
                          ],
                        ),
                        SizedBox(height: 5,),
                        controller.user.value.email == ""? Container() : Row(
                          children: [
                            Text('${controller.user.value.email}', style: TextStyle(fontSize: 16,), )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.orange, width: 2),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Manage Addresses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorPalette.orange),),
                          IconButton(
                              onPressed: () {
                                Get.to(MyGoogleMap(customerID: controller.user.value.id,));
                              },
                              icon: Icon(
                                Icons.add,
                                size: 25,
                                color: ColorPalette.orange,
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
//                    Container(
//                      decoration: BoxDecoration(
//                        border: Border.all(color: ColorPalette.orange.shade200),
//                        borderRadius: BorderRadius.circular(6),
//                      ),
//                      width: double.infinity,
//                      child: Padding(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                Row(
//                                  children: [
//                                    Text('CB-151/A Str.06', style: TextStyle(fontSize: 16,),),
//                                  ],
//                                ),
//                                SizedBox(height: 3,),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                  children: [
//                                    Text('Gulshan Colony\t\t\t', style: TextStyle(fontSize: 16,),),
//                                    Text('4400', style: TextStyle(fontSize: 16,), )
//                                  ],
//                                ),
//                                SizedBox(height: 3,),
//                                Row(
//                                  children: [
//                                    Text('Islamabad', style: TextStyle(fontSize: 16,),),
//                                  ],
//                                ),
//                              ],
//                            ),
//                            Column(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: [
//                                IconButton(
//                                  onPressed: () {
//                                    Get.to(AdressInformation());
//                                  },
//                                  icon: Icon(
//                                    Icons.edit,
//                                    color: ColorPalette.orange,
//                                  )
//                                ),
//                                SizedBox(height: 3,),
//                                IconButton(
//                                  onPressed: () {
//                                    showDialog(
//                                        context: context,
//                                        builder: (BuildContext context) {
//                                          return AlertDialogWidget(
//                                            title: 'Are you Sure?',
//                                            subTitle: "Do You Want to Delete your address?",
//                                            onPositiveClick: () {
//                                              Get.back();
//                                            },
//                                          );
//                                        }
//                                    );
//                                  },
//                                  icon: Icon(
//                                    Icons.delete,
//                                    color: ColorPalette.red,
//                                  )
//                                ),
//                                SizedBox(height: 3,),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
                      ...controller.user.value.addresses.map((address) =>
                        Column(
                          children: [
                            Container(
                              color: ColorPalette.orange.shade200,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width-145,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              address.address,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                              ),
                                            )
                                          ),
                                          Text('${address.colonyName}\t\t\t${address.postcode}', style: TextStyle(fontSize: 14),),
                                          Text(address.city, style: TextStyle(fontSize: 14),),
                                          address.manualAddress == "" || address.manualAddress==null
                                              ? Container()
                                              : Container(child: Text(address.manualAddress, style: TextStyle(fontSize: 14, color: Colors.grey),)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: Get.height*0.1,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialogWidget(
                                                    title: 'Delete Address',
                                                    subTitle: "Do You Want to Delete your address?",
                                                    onPositiveClick: () async {
                                                      int index = controller.user.value.addresses.indexWhere((element) =>
                                                      element.id == address.id);
                                                      if (index != null){
                                                        controller.user.value.addresses.removeAt(index);
                                                        controller.updateUser(controller.user.value);
                                                      }
                                                      String message = await HttpService.deleteAddress(addressId: address.id.toString());
                                                      Utils.showToast(message);
                                                      Get.back();

                                                    },
                                                  );
                                                }
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: ColorPalette.red,
                                            )
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Get.to(()=> MyGoogleMap(addressID: address.id,address: address.address,manualAddress: address.manualAddress,colony:Colony(id: address.colonyId,name: address.colonyName),));
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: ColorPalette.orange,
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        )).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
