import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/services/http_service.dart';
import 'package:sabzishop/utilities.dart';
import 'package:sabzishop/widgets/my_filled_button.dart';
import 'package:sabzishop/widgets/my_text_field.dart';

class ContactUs extends StatelessWidget {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  RxBool progressing = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('Contact Us', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () =>
         progressing.value ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                MyTextField(controller: name, label: 'Enter Name'),
                SizedBox(height: 10,),
                MyTextField(controller: email, label: 'Enter Email'),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      label: '',
                      controller: TextEditingController(text: '+92'),
                      width: 65,
                      // phoneNumber: true,
                      enabled: false,
                      keyboardType: TextInputType.none,
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      child: MyTextField(
                        height: 64,
                        maxLength: 10,
                        controller: phone,
                        label: 'Enter Phone No.',
                        keyboardType: TextInputType.number,

                        // phoneNumber: true,
                        onChanged: (val){
                          if(val.length<2 && phone.text==0.toString()){
                            phone.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                MyTextField(controller: subject, label: 'Enter Subject'),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.17,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.green),
                      borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: message,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter Message',
                      hintStyle: TextStyle(color: ColorPalette.green),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                MyFilledButton(
                  ontap: () async {
                    if(contactUsValidation()){
                      progressing.value = true;
                      String response = await HttpService.contactUs(
                          phone: "+92${phone.text}",
                          email: email.text,
                          name: name.text,
                          message: message.text,
                          subject: subject.text
                      );
                      progressing.value = false;
                      Fluttertoast.showToast(msg: response);
                      Get.back();
                    }
                  },
                  color: ColorPalette.green,
                  width: double.infinity,
                  height: 40,
                  borderRadius: 0,
                  txt: 'Send Message',
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.green)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: ColorPalette.green, width: 2)
                          ),
                          child: Icon(Icons.map_outlined, size: 30, color: ColorPalette.green, )
                        ),
                        SizedBox(height: 5,),
                        Text('Email Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 5,),
                        Text('We send emails for discounts and offers provided by us. Also if there is any new product added in the store, we let you know about that.',
                          style: TextStyle(fontSize: 16,),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.green)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ColorPalette.green, width: 2)
                            ),
                            child: Icon(Icons.drafts_outlined, size: 30, color: ColorPalette.green, )
                        ),
                        SizedBox(height: 5,),
                        Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 5,),
                        Text('support@sabzishope.com',
                          style: TextStyle(fontSize: 16,),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPalette.green)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ColorPalette.green, width: 2)
                            ),
                            child: Icon(Icons.smartphone_outlined, size: 30, color: ColorPalette.green, )
                        ),
                        SizedBox(height: 5,),
                        Text('Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        SizedBox(height: 5,),
                        Text('0300-1114636',
                          style: TextStyle(fontSize: 16,),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Get in Touch', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 3,),
                Text('Get in touch with our customer support team using our online portal. You can leave a message on our website directly by filling and submitting an e-form available on our website. We do not exploit your data for any use. Neither have we sold your data to any third party. So feel free to write us any time.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.4),
                  textAlign: TextAlign.values[3],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool contactUsValidation(){
    if(name.text.trim().length==0){
      Utils.showToast('Name is Required');
      return false;
    }
    // else if
    // (!GetUtils.isEmail(email.text)){
    //   Fluttertoast.showToast(msg: 'Email format is not correct');
    //   return false;
    // }
    // else if
    // (email.text.trim().length==0){
    //   Utils.showToast('Email is Required');
    //   return false;
    // }
    else if (phone.text.trim().length == 0){
      Fluttertoast.showToast(msg: 'Phone Number is required');
      return false;
    }
    else if (phone.text.trim().length <= 9){
      Fluttertoast.showToast(msg: 'Enter Valid Phone Number');
      return false;
    }
    else
      return true;
  }
}
