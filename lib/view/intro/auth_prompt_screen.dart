// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sabzishop/Settings/color_palates.dart';
// import 'package:sabzishop/view/auth_screens/create_account.dart';
// import 'package:sabzishop/view/auth_screens/login%20screen.dart';
// import 'package:sabzishop/widgets/my_filled_button.dart';
//
// class AuthPromptScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Container(
//             color: Colors.transparent,
//             width:  MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//           ),
//           Center(child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10)
//             ),
//             constraints: BoxConstraints(
//               maxWidth:  MediaQuery.of(context).size.width-100,
//               maxHeight: MediaQuery.of(context).size.height-200,
//               minWidth: MediaQuery.of(context).size.width-100,
//               minHeight: 100,
//             ),
//
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 80,
//                       backgroundImage: AssetImage("assets/image/logo.jpeg"),
//                       ),
//                   SizedBox(height: 100,),
//                   MyFilledButton(txt: "Login",color: ColorPalette.green,ontap: (){
//                     Get.off(LoginScreen());
//                   },),
//                   SizedBox(height: 12,),
//                   MyFilledButton(txt: "Register",color: ColorPalette.green,ontap: (){
//                     Get.off(CreateAccount());
//                   },),
//                   SizedBox(height: 12,),
//                   TextButton(child: Text("Skip for now",style: TextStyle(decoration: TextDecoration.underline),),
//                     onPressed: (){
//                     Get.back();
//                     },
//                   )
//                 ],
//               ),
//             )
//           ),
//           ),
//         ],
//       ),
//     );
//   }
// }
