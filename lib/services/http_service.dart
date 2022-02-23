
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sabzishop/controller/ForgotPassword.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/time_slots_controller.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/modal/category.dart';
import 'package:sabzishop/modal/colony.dart';
import 'package:sabzishop/modal/dashboad.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/modal/faq_model.dart';
import 'package:sabzishop/modal/html_content.dart';
import 'package:sabzishop/modal/order_history.dart';
import 'package:sabzishop/modal/place_order_detail_modal.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/modal/slides.dart';
import 'package:sabzishop/modal/time_slot.dart';
import 'package:sabzishop/statics/static_var.dart';
import 'package:sabzishop/utilities.dart';

class HttpService {
  static Uri _uri = Uri.parse("https://imrans9.sg-host.com/app/app.php");
  AuthController authController = Get.find();
  TimeSlotsController slotController = Get.find();

  static Future<ProductsModal> getProducts(int page_no) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'all_products': '1',
          'page_no': page_no.toString(),
        },
      );
      if (response.statusCode == 200) {
        return ProductsModal.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }




  static Future<ProductsModal> getProductsOfSubCategory(int page_no,String subCatId) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'all_products': '1',
          'sub_category_id': subCatId,
          'page_no': page_no.toString(),
        },
      );
      if (response.statusCode == 200) {
        return ProductsModal.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Deal>> getDeals() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'all_deals': '1'
        },
      );
      if (response.statusCode == 200) {
        List jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Deal.fromJson(json) ).toList();
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<List<Categories>> getCategories() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_all_categories': '1',

        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => Categories.fromJson(json)).toList();

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<TimeSlotModal> getTimeSlots() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_all_timeslots': '1'
        },
      );
      if (response.statusCode == 200) {
        return TimeSlotModal.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> getShowDatePickerStatus() async {
    try {
    var response = await http.post(
    _uri,
    body: {
      'get_settings' : '1'
    },
    );
    if (response.statusCode == 200) {
    return jsonDecode(response.body)['date_option']=="1";
    } else
    return null;
    }
    catch (e) {
    print(e);
    return null;
    }
  }

  static Future<dynamic> getPackagingandServiceDelivery() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_settings' : '1'
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }



  static Future<ProductsModal> searchProduct(int page_no,String searchString) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'search_string': searchString,
          'page_no': page_no.toString(),
        },
      );
      if (response.statusCode == 200) {
        return ProductsModal.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

  static Future<dynamic> placeOrderForLoginCustomer({String customerID,String addressID,String deliveryDate,String slotId,String orderNotes,String amount, List<PlaceOrderDetailModal> orderDetails, int tomorrow}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'new_order': '1',
          'customer_id' : customerID,
          'customer_type' : 'login',
          'address_id' : addressID,
          'delivery_date' : deliveryDate,
          'slot_id' : slotId,
          'order_notes' : orderNotes ?? "",
          'amount' : amount,
          'order_details' : jsonEncode(orderDetails),
          'tomorrow' : tomorrow.toString()
      },
      );
      if (response.statusCode == 200) {
      Utils.showToast(jsonDecode(response.body)["msg"]);
      return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<dynamic> placeOrderForGuestCustomer({String name,String deliveryDate,String slotId,String orderNotes,String amount, List<PlaceOrderDetailModal> orderDetails, String email, String phone, String colonyID, String address, String city, String postCode}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'new_order': '1',
          'customer_type' : 'guest',
          'delivery_date' : deliveryDate,
          'slot_id' : slotId,
          'order_notes' : orderNotes ?? "",
          'amount' : amount,
          'order_details' : jsonEncode(orderDetails),
          'name': name,
          'email': email,
          'phone': phone,
          'colony_id': colonyID,
          'address': address,
          'city': city,
          'postcode': postCode
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }


  static Future<List<Colony>> get_colonies() async {
    try {
      var response = await http.post(
        _uri,
        body: {'get_colonies': '1'},
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => Colony.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<AuthResponse> registerUser
      (
      String name,
      String email,
      String phone,
      String colonyId,
      String address,
      String manualAddress,
      String postcode,
      String city,
      ) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'register_account': '1',
          'name': name,
          'email': email,
          'phone': "+92$phone",
          'colony_id': colonyId,
          'address': address,
          'manual_address': manualAddress,
          'postcode': postcode,
          'city': city,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> getAddressFromGoogleMapsAPI
      (double lat,double lng) async {
    try {
      var response = await http.post(
        Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDodI_dtDEr_P9ur1yYfW80QM3NQoStAxA"),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['results'][0]['formatted_address'];
      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }

  static Future<AuthResponse> loginUser
      (String number) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'user_login': '1',
          'phone': "+92$number",
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<ForgotPasswordResponse> forgotPassword
      (String email) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'forgot_email': email,
        },
      );
      if (response.statusCode == 200) {
        return ForgotPasswordResponse.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<AuthResponse> verifyOtp
      ({String customerId, String otp}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'verify_otp': '1',
          'customer_id': customerId,
          'otp': otp,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<AuthResponse> resendOtp
      ({String customerId}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'resend_otp': '1',
          'customer_id': customerId,
        },
      );
      if (response.statusCode == 200) {
        return AuthResponse.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<Order> getOrderWithID
      (String orderId) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'view_order': '1',
          'order_id': orderId,
        },
      );
      if (response.statusCode == 200) {
        return Order.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> addAdress
      ({@required String customerId,@required String colonyId,@required String address, String manualAddress, String postCode, String city}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'add_address': '1',
          'customer_id': customerId,
          'colony_id': colonyId,
          'address': address,
          'manual_address' : manualAddress,
          'postcode': postCode??"",
          'city': city??"",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> editAddress
      ({@required String addressId,@required String colonyId,@required String address , String manualAddress, String postCode, String city}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'edit_address': '1',
          'address_id':addressId,
          'colony_id': colonyId,
          'address': address,
          'manual_address' : manualAddress,
          'postcode': postCode??"",
          'city': city??""
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  static Future<String> deleteAddress
      ({String addressId}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'delete_address': '1',
          'address_id': addressId,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['msg'];

      } else
        return "Some error accrued";
    }
    catch (e) {
      return "Some error accrued";
    }
  }

  static Future<OrderHistoryModal> getOrdersHistory
      ({String customerId,int pageNo}) async {
    print("CustomerID: $customerId");
    try {
      var response = await http.post(
        _uri,
        body: {
          'order_history': '1',
          'customer_id': customerId,
          'page_no' : pageNo.toString(),
        },
      );
      if (response.statusCode == 200) {
       return OrderHistoryModal.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> cancelOrder
      ({String orderId}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'cancel_order': '1',
          'order_id': orderId,
        },
      );
      if (response.statusCode == 200) {
       Utils.showToast(jsonDecode(response.body)['msg']);
       return jsonDecode(response.body)['status'];
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }



  static Future<Slides> getSlides() async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'get_settings': '1',
        },
      );
      if (response.statusCode == 200) {
        StaticVariable.initial_slide_1= jsonDecode(response.body)['initial_slide_1'];
        StaticVariable.initial_slide_2= jsonDecode(response.body)['initial_slide_2'];
        StaticVariable.initial_slide_3= jsonDecode(response.body)['initial_slide_3'];
        return Slides.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }





  static Future<HtmlContent> htmlContent
      (String page_id) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'html_content': '1',
          'page_id': page_id,
        },
      );
      if (response.statusCode == 200) {
        return HtmlContent.fromJson(jsonDecode(response.body)['data']);

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }


  static Future<String> contactUs
      ({String name, String email, String phone, String subject, String message}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'contact_us': '1',
          'name': name,
          'email': email,
          'phone': phone,
          'subject': subject,
          'message': message
        },
      );
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status']==0){
          Fluttertoast.showToast(msg: jsonDecode(response.body)['status']);
        }
        return jsonDecode(response.body)['msg'];

      } else
        return "Some error accoured";
    }
    catch (e) {
      return "Some error accoured";
    }
  }



  static Future<List<Faq>> getFaqs
      () async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'faqs': '1',
        },
      );
      if (response.statusCode == 200) {
        List rawList = jsonDecode(response.body);
        return rawList.map((json) => Faq.fromJson(json)).toList();
      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }



  static Future<Map<String, dynamic>> updateProfile
      ({String customerID, String name, String email, String phone}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'update_profile': '1',
          'customer_id':customerID,
          'name': name,
          'email': email,
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }

  ///---------------------------------------------FCM Integrations-----------------------------------------------///

  static Future<String> createToken
      (String userID,String deviceID,String token) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'create_token': '1',
          'user_id' : userID,
          'device_id' : deviceID,
          'type' : '0',
          'token' : token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }




  static Future<String> updateToken
      (String deviceID,String token) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'update_token': '1',
          'device_id' : deviceID,
          'type' : '0',
          'token' : token
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }




  static Future<String> deleteToken
      (String deviceID) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'delete_token': '1',
          'device_id' : deviceID,
          'type' : '0',
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['msg']);
        return jsonDecode(response.body)['status'];

      } else
        return "";
    }
    catch (e) {
      return "";
    }
  }



  static Future<DashBoard> getDashBoardlist
      ({String customerId}) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'customer_dashboard': '1',
          'customer_id': customerId,
        },
      );
      if (response.statusCode == 200) {
        return DashBoard.fromJson(jsonDecode(response.body));

      } else
        return null;
    }
    catch (e) {
      return null;
    }
  }



}