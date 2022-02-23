//import 'package:flutter/material.dart';
//import 'package:sms_autofill/sms_autofill.dart';
//
//class OtpScreen extends StatefulWidget {
//  @override
//  _OtpScreenState createState() => _OtpScreenState();
//}
//
//class _OtpScreenState extends State<OtpScreen> {
//  TextEditingController otpController = TextEditingController();
//  @override
//  void initState() {
//    super.initState();
//    listenOtp();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        leadingWidth: 20,
//        title: Text('Authentication'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Container(
//              padding: EdgeInsets.only(left: 10, right: 10),
//              child: PinFieldAutoFill(
//                controller: otpController,
//                codeLength: 6,
//                onCodeChanged: (val){print(val);},
//              ),
//            )
//          ],
//        ),
//      )
//    );
//  }
//  void listenOtp() async {
//    await SmsAutoFill().listenForCode;
//  }
//}



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/auth_controller.dart';
import 'package:sabzishop/controller/bottom_bar.dart';
import 'package:sabzishop/modal/auth_response.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatelessWidget {
  String userID;
  OtpScreen({@required this.userID});
  TextEditingController otpController = TextEditingController();
  BottomBarController bottomBarController = BottomBarController();
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    SmsAutoFill().listenForCode;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        title: Text('Authentication'),
      ),
        body: Obx(
            () =>  ModalProgressHUD(
              inAsyncCall: controller.progressing.value,
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enter your OTP Code ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                     Container(
                       child: PinFieldAutoFill(
                         decoration: UnderlineDecoration(
                           textStyle: TextStyle(fontSize: 20, color: Colors.black),
                           colorBuilder: FixedColorBuilder(Colors.black),
                         ),
                         onCodeChanged: (code) {
                           if (code.length == 6) {
                             FocusScope.of(context).requestFocus(FocusNode());
                           }
                         },
                         controller: otpController,
                         keyboardType: TextInputType.phone,
                         codeLength: 6,
                         onCodeSubmitted: (code){
                           otpController.text= code;
                           controller.verifyOtp(otp: code, id: userID);
                         },
                       ),
                     ),
//                  MyTextField(
//                    keyboardType: TextInputType.number,
//                    height: 65,
//                    maxLength: 6,
//                    controller: otpController,
//                    label: otpController.text,
//                    enabled: false,
//                  ),
                    SizedBox(height: 20,),
                    MyFilledButton(
                      height: 40,
                      width: double.infinity,
                      color: ColorPalette.green,
                      borderRadius: 0,
                      txt: 'Submit',
                      ontap: () async {
                        if(otpController.text.length!=6)
                          Utils.showToast('Otp is not valid');
                        else
                        controller.verifyOtp(otp: otpController.text, id: userID);
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't recieve OTP? ",
                          style: TextStyle(
                              fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () async {
                            controller.progressing.value = true;
                            AuthResponse response = await HttpService.resendOtp(customerId: userID);
                            Utils.showToast(response.msg);
                            print("otp:${response.user.otp}");
                            controller.progressing.value = false;
                          },
                          child: Text("Resend Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
          ),
            ),
        )
    );
  }
}

