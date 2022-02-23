import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/register_screen_controller.dart';
import 'package:sabzishop/view/about_us.dart';
import 'package:sabzishop/view/auth_screens/dashboard_screen.dart';
import 'package:sabzishop/view/auth_screens/faq_sqreen.dart';
import 'package:sabzishop/view/auth_screens/login%20screen.dart';
import 'package:sabzishop/view/auth_screens/create_account.dart';
import 'package:sabzishop/view/auth_screens/profile.dart';
import 'package:sabzishop/view/auth_screens/personal_information.dart';
import 'package:sabzishop/view/contact_us_screen.dart';
import 'package:sabzishop/view/html_screen.dart';
import 'package:sabzishop/view/order_screen/order_history.dart';
import 'package:sabzishop/widgets/AlertDialogeWidget.dart';
import 'package:sabzishop/widgets/my_appbar.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/view/my_google_map.dart';

class AccountScreenTab extends StatelessWidget {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidgets("").getMyAppBar(),
      body: Obx(
          () => authController.isLogedIn.value
          ? SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => DashBoardScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.dashboard_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'My Dashboard',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                    onTap: () {
                      Get.to(() => OrderHistoryScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.reorder_rounded,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Orders History',
                            style: TextStyle(
                                fontSize: 20,
//                    letterSpacing: 2,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                  onTap: () {Get.to(Profile());},
                  child: Row(
                    children: [
                      Icon(Icons.account_circle_outlined,),
                      SizedBox(width: 10,),
                      Container(
                        width: Get.width-65,
                        child: Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                    onTap: () {
                      Get.to(() => ContactUs());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.phone_in_talk_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                      letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AboutUs());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.info_outlined,),
                      SizedBox(width: 10,),
                      Container(
                        width: Get.width-65,
                        child: Text(
                          'About Us',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                    onTap: () {
                      Get.to(FAQScreen());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.help_outline_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'FAQs',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                      letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("4"));},
                    child: Row(
                      children: [
                        Icon(Icons.library_books_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                      letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("5"));},
                    child: Row(
                      children: [
                        Icon(Icons.description_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                      letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 15,),
                Divider(),
                GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialogWidget(
                          title: 'Log Out From Sabzi Shop',
                          subTitle: "Are you sure to logout from your account?",
                          onPositiveClick: () {
                            authController.logOut();
                            Get.back();
                          },
                        );
                      }
                  );
                },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.orange,
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
                        child: Text('Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
              )
          : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: () {Get.to(ContactUs());},
                  child: Row(
                    children: [
                      Icon(Icons.phone_in_talk_outlined,),
                      SizedBox(width: 10,),
                      Container(
                        width: Get.width-65,
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
//                    letterSpacing: 2
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Divider(),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {
                      Get.to(() => AboutUs());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.info_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'About Us',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Divider(),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {Get.to(FAQScreen());},
                    child: Row(
                      children: [
                        Icon(Icons.help_outline_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'FAQs',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                    letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Divider(),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("4"));},
                    child: Row(
                      children: [
                        Icon(Icons.library_books_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                    letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Divider(),
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {Get.to(HtmlViewer("5"));},
                    child: Row(
                      children: [
                        Icon(Icons.description_outlined,),
                        SizedBox(width: 10,),
                        Container(
                          width: Get.width-65,
                          child: Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
//                    letterSpacing: 2
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Divider(),
                SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () {
                    Get.to(()=>MyGoogleMap());
                  },
                  color: ColorPalette.orange,
                  width: double.infinity,
                  txt: 'Create Account',
                  borderRadius: 0,
                ),
                SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () {
                    Get.to(LoginScreen());
                  },
                  color: ColorPalette.green,
                  width: double.infinity,
                  txt: 'Sign In',
                  borderRadius: 0,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}