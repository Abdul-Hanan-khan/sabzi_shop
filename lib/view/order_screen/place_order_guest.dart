// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sabzishop/Settings/color_palates.dart';
// import 'package:sabzishop/controller/auth_controller.dart';
// import 'package:sabzishop/controller/cart_controller.dart';
// import 'package:sabzishop/controller/my_google_map_controller.dart';
// import 'package:sabzishop/controller/place_order_guest_controller.dart';
// import 'package:sabzishop/controller/register_screen_controller.dart';
// import 'package:sabzishop/controller/time_slots_controller.dart';
// import 'package:sabzishop/modal/auth_response.dart';
// import 'package:sabzishop/modal/place_order_detail_modal.dart';
// import 'package:sabzishop/modal/time_slot.dart';
// import 'package:sabzishop/services/http_service.dart';
// import 'package:sabzishop/utilities.dart';
// import 'package:sabzishop/view/auth_screens/otp_screen.dart';
// import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
// import 'package:sabzishop/widgets/my_filled_button.dart';
// import 'package:sabzishop/view/my_google_map.dart';
// import 'package:sabzishop/widgets/my_text_field.dart';
// import 'package:sabzishop/widgets/my_time_slot.dart';
// import 'package:sms_autofill/sms_autofill.dart';
//
// class PlaceOrderGuest extends StatelessWidget {
//   String packingCharges;
//   String deliveryCharges;
//   PlaceOrderGuest({this.packingCharges, this.deliveryCharges});
//   RegisterScreenController controller = Get.find();
//   CartController cartController = Get.find();
//   AuthController authController = Get.find();
//   TimeSlotsController slotsController = Get.put(TimeSlotsController());
//   PlaceOrderGuestController   placeOrderGuestController= Get.put(PlaceOrderGuestController());
//   MyGoogleMapController _myGoogleMapController = MyGoogleMapController(latlng: LatLng(31.4504, 73.1350).obs);
//   FocusNode phoneFocus = FocusNode();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     controller.fetchingAddress.value = true;
//     controller.loadCurrentLocation().then((value) async  {
//       _myGoogleMapController.latlng.value = controller.latlng;
//       String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
//       placeOrderGuestController.address.clear();
//       controller.fetchingAddress.value = false;
//       placeOrderGuestController.address.text = formated_address;
//     });
// //    if(placeOrderGuestController!=null)
// //      {
// //        placeOrderGuestController = Get.find();
// //      }
// //    else
// //      {
// //        placeOrderGuestController= Get.put(PlaceOrderGuestController());
// //      }
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
//         leadingWidth: 30,
//         title: Text('Place Order', style: TextStyle(color: Colors.black),),
//       ),
//       body: Obx(
//           () => SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 MyTextField(controller: placeOrderGuestController.name, label: 'Name',),
//                 SizedBox(height: 10),
//                 MyTextField(controller: placeOrderGuestController.email, label: 'Email', keyboardType: TextInputType.emailAddress,),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     MyTextField(
//                       label: '',
//                       controller: placeOrderGuestController.code,
//                       width: 75,
//                       // height: 65,
//                       phoneNumber: true,
//                       enabled: false,
//                       keyboardType: TextInputType.none,
//                     ),
//                     SizedBox(width: 10,),
//                     Expanded(
//                       child: MyTextField(
//                         controller: placeOrderGuestController.phone,
//                         label: 'Phone Number Without Leading 0',
//                         keyboardType: TextInputType.number,
//                         // height: 65,
//                         phoneNumber: true,
//                         onChanged: (val){
//                           if(val.length<2 && placeOrderGuestController.phone.text==0.toString()){
//                             placeOrderGuestController.phone.clear();
//                           }
//                         },
//                         // width: 40,
// //                     focusNode: phoneFocus,
// //                     onChanged: (val){
// //                       if(val.length < 4){
// //                         phone.text = "+92";
// //                         phoneFocus.unfocus();
// // //                      phoneFocus.requestFocus();
// //                       }
// //                     },
// //                     autoFocus: false,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text('Address:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                 SizedBox(height: 5,),
//                 Stack(
//                   alignment: Alignment.centerRight,
//                   children: [
//                     MyTextField(
//                       controller: placeOrderGuestController.colony,
//                       label: "Colony",
//                       enabled: false,
//                     ),
//                     Obx(
//                           () => DropdownButton<String>(
//                         isExpanded: true,
//                         // value: _prefferedDurationOfLesson,
//                         icon: Padding(
//                           padding: EdgeInsets.only(right: 3.0),
//                           child: Icon(
//                             Icons.arrow_drop_down,
//                             color: ColorPalette.green,
//                           ),
//                         ),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: TextStyle(color: ColorPalette.green),
//                         underline: Container(
//                           color: Colors.transparent,
//                         ),
//                         onChanged: (newValue) {
//                           placeOrderGuestController.colony.text = newValue;
//                           controller.selectedColony= controller.colonies.firstWhere((element) => element.name == placeOrderGuestController.colony.text);
//                         },
//                         items: controller.colonies.map((e) => e.name).toList()
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value, style: TextStyle(color: Colors.black),),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 MyTextField(
//                   height: 100,
//                   maxLines:5,
//                   controller: placeOrderGuestController.address, label: 'Address',
//                   suffixIcon: IconButton(
//                     icon: controller.fetchingAddress.value == true?Container(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(strokeWidth: 2,)): GestureDetector(
//                       onLongPress: () async {
//                         controller.fetchingAddress.value = true;
//                         String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
//                         placeOrderGuestController.address.clear();
//                         controller.fetchingAddress.value = false;
//                         placeOrderGuestController.address.text = formated_address;
//                       },
//                       child: Icon(Icons.add_location, size: 30,)),
//                       color: ColorPalette.green,
//                       onPressed: (){
//                         controller.loadCurrentLocation().then((value) {
//                           // Future<Address> reverseGeocoding({double latitude, double longitude});
//                           // address.text = controller.latlng.toString();
//                           Get.dialog(Stack(
//                             alignment: Alignment.bottomLeft,
//                             children: [
//                               Container(
//                                 child: MyGoogleMap(controller:_myGoogleMapController),
//                               ),
//                               ElevatedButton(child:Icon(Icons.done),
//                                 onPressed: () async {
//                                   Get.back();
//                                   controller.fetchingAddress.value = true;
//                                   String formated_address = await HttpService.getAddressFromGoogleMapsAPI(_myGoogleMapController.latlng.value.latitude,_myGoogleMapController.latlng.value.longitude);
//                                   placeOrderGuestController.address.clear();
//                                   placeOrderGuestController.address.text = formated_address;
//                                   controller.fetchingAddress.value = false;
//
//                                 },
//                               ),
//                             ],
//                           ));
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 MyTextField(controller: placeOrderGuestController.postcode, label: 'Post Code', keyboardType: TextInputType.number,),
//                 SizedBox(height: 10),
//                 MyTextField(controller: placeOrderGuestController.city, label: 'City',),
//                 SizedBox(height: 10),
//                 Text('Additional Information:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                 SizedBox(height: 5,),
//                 Container(
//                   width: double.infinity,
//                   height: Get.height*0.17,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: ColorPalette.green)
//                   ),
//                   child: TextField(
//                     controller: placeOrderGuestController.message,
//                     keyboardType: TextInputType.multiline,
//                     textInputAction: TextInputAction.newline,
//                     minLines: 1,
//                     maxLines: 5,
//                     decoration: InputDecoration(
//                       hintText: 'Order Notes',
//                       hintStyle: TextStyle(color: ColorPalette.green),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5,),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: ColorPalette.green),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Sub Total ', style: TextStyle(fontSize: 16)),
//                                 Spacer(),
//                                 Text(cartController.calculateTotalAmmout().toStringAsFixed(0), style: TextStyle(fontSize: 16)),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               children: [
//                                 Text('Product Delivery ', style: TextStyle(fontSize: 16)),
//                                 Spacer(),
//                                 deliveryCharges =='0'
//                                     ? Text('Free', style: TextStyle(fontSize: 16))
//                                     : Text(deliveryCharges, style: TextStyle(fontSize: 16)),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               children: [
//                                 Text('Packaging ', style: TextStyle(fontSize: 16)),
//                                 Spacer(),
//                                 packingCharges =='0'
//                                     ? Text('Free', style: TextStyle(fontSize: 16))
//                                     : Text(packingCharges, style: TextStyle(fontSize: 16)),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                             Row(
//                               children: [
//                                 Text('Total ', style: TextStyle(fontSize: 16)),
//                                 Spacer(),
//                                 Text((cartController.calculateTotalAmmout()+double.parse(packingCharges)+double.parse(deliveryCharges)).toStringAsFixed(0), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             SizedBox(height: 5,),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: MyFilledButton(
//                     borderRadius: 10,
//                     color: ColorPalette.green,
//                     height: 40,
//                     width: double.infinity,
//                     txt: "Proceed Now",
//                     ontap: (){
//                       if(placeOrderGuestController.checkOutValidation()){
//                         showModalBottomSheet(
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (context) =>Container(
//                               height: Get.height/2.3,
//                               child: MyTimeSlots(deliveryCharge: deliveryCharges, packingCharge: packingCharges,)),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   placeOrder(TimeSlot slot) async {
//     PlaceOrderGuestController pcontroller = Get.find();
//     List<PlaceOrderDetailModal> orderDetails = [];
//
//     if(cartController.cart.products.length>0)
//     {
//       cartController.cart.products.forEach((product) {orderDetails.add(PlaceOrderDetailModal(productId: product.id,quantity: product.quantity.toString(),type: "product"));});
//     }
//
//     if(cartController.cart.deals.length>0)
//     {
//       cartController.cart.deals.forEach((deal) {orderDetails.add(PlaceOrderDetailModal(productId: deal.id,quantity: deal.quantity.toString(),type: "deal"));});
//     }
//
//
//     Map<String, dynamic> status = await HttpService.placeOrderForGuestCustomer(
//       city: pcontroller.city.text,
//       address: pcontroller.address.text,
//       postCode: pcontroller.postcode.text,
//       name: pcontroller.name.text,
//       email: pcontroller.email.text,
//       phone: pcontroller.phone.text,
//       amount: cartController.calculateTotalAmmout().toString(),
//       colonyID: controller.selectedColony.id,
//       deliveryDate: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
//       orderNotes: pcontroller.message.text,
//       slotId: slot.id,
//       orderDetails: orderDetails
//     );
//     Utils.showToast(status["customer_msg"]);
//     if(status['customer_status'] == "success")
//     {
//       Utils.showToast(status["msg"]);
//       //todo: register
//       authController.register(
//         colonyId: controller.selectedColony.id,
//         city: placeOrderGuestController.city.text,
//         address: placeOrderGuestController.address.text,
//         name: placeOrderGuestController.name.text,
//         email: placeOrderGuestController.email.text,
//         phone: placeOrderGuestController.phone.text,
//         postCode: placeOrderGuestController.postcode.text
//       );
//       cartController.clearCart();
//     }
//   }
//
// }
//
// //class MyTimeSlots extends StatelessWidget {
// //  TimeSlotsController slotsController = Get.find();
// //
// //  CartController cartController = Get.find();
// //  @override
// //  Widget build(BuildContext context) {
// //    if(slotsController.timeSlots.length==0)
// //      slotsController.loadSlots();
// //    return Obx(
// //          ()=> slotsController.loading.value?
// //      Center(child: CircularProgressIndicator(),):
// //      SingleChildScrollView(
// //        child: Container(
// //          child: Padding(
// //            padding: const EdgeInsets.all(10.0),
// //            child: Container(
// //                constraints: BoxConstraints(
// //                  minHeight: Get.height * 0.15,
// //                  maxHeight: Get.height * 0.75,
// //                ),
// //                // height: Get.height*0.75-62,
// //                child: SingleChildScrollView(
// //                  child: Column(
// //                    crossAxisAlignment: CrossAxisAlignment.center,
// //                    children: [
// //                      SizedBox(
// //                        height: 5,
// //                      ),
// //                      SizedBox(
// //                          height: 21,
// //                          child: Text(
// //                            'Select Time Slot',
// //                            style: TextStyle(
// //                                fontWeight: FontWeight.bold, fontSize: 18),
// //                          )),
// //                      Divider(),
// //                      ...slotsController.timeSlots.map((slot) => GestureDetector(
// //                        onTap: (){
// //                          //TODO; send more arguments here
// //                          cartController.checkout(slot:slot,);
// //                        },
// //                        child: Padding(
// //                          padding: const EdgeInsets.all(5.0),
// //                          child: Container(
// //                            color: ColorPalette.green.shade100,
// //                            child: Row(
// //                              mainAxisAlignment: MainAxisAlignment.center,
// //                              children: [
// //                                Padding(
// //                                  padding: EdgeInsets.symmetric(vertical: 15.0),
// //                                  child: Text(
// //                                    "${slot.timeFrom} - ${slot.timeTo}",
// //                                    style: TextStyle(fontSize: 18),
// //                                  ),
// //                                ),
// //                              ],
// //                            ),
// //                          ),
// //                        ),
// //                      ))
// //                          .toList()
// //                    ],
// //                  ),
// //                )),
// //          ),
// //        ),
// //      ),
// //    );
// //  }
// //}