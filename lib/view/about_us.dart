import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('About Us', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset('assets/image/image6.jpg', fit: BoxFit.contain,)
              ),
              SizedBox(height: 10,),
              Text('Who We Are', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              SizedBox(height: 5,),
              Text('SABZISHOP is the online store for providing an extended range of farm-fresh and organic vegetables in Faisalabad. It is providing a one-click solution to get your desire list of vegetables at your doorstep. It is a platform that frees you from the everyday struggle of selecting and negotiating for acquiring your vegetables The vegetables we are offering are truly fresh and have outsourced from local farmers. We are also providing you free home delivery for each order. Our farmers use natural fertilizers and clean water to grow quality vegetables under natural conditions. We do not support the use of chemical fertilizers, dirty water, and excessive use of pesticides. That’s why our team visits farms and negotiate with local farmers to ensure the vegetables they are providing us are organic in true sense.',
                style: TextStyle(fontSize: 17, color: Colors.grey[600], height: 1.4),
                textAlign: TextAlign.values[3],
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Why Choose Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 5,),
                      Text('Our prices are amazingly low and stable. Our team works hard to bring a combination of good quality at low prices for you. At Sabzi Shop you would never face frequent fluctuation in prices. The price list we provide on our website is truly justified and low from market prices. Visit our website today and get your farm-fresh and organic vegetables at low prices.',
                        style: TextStyle(fontSize: 17, color: Colors.grey[600], height: 1.4),
                        textAlign: TextAlign.values[3],
                      ),
                      SizedBox(height: 20,),
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
                                  child: Icon(Icons.app_registration_outlined, size: 30, color: ColorPalette.green, )
                              ),
                              SizedBox(height: 5,),
                              Text('Creative Team', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: 5,),
                              Text('Our team visits farms and negotiate with local farmers farmers to ensure the vegetables they are providing us are organic in true sense.',
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
                                  child: Icon(Icons.content_copy_outlined, size: 30, color: ColorPalette.green, )
                              ),
                              SizedBox(height: 5,),
                              Text('Low Prices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: 5,),
                              Text('Our prices are amazingly low and stable. Our team works hard to bring a combination of good quality at low prices for you',
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
                                  child: Icon(Icons.email_outlined, size: 30, color: ColorPalette.green, )
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
                      SizedBox(height: 5,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
