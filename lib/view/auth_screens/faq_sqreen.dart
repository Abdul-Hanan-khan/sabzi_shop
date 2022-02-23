import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/faq_controller.dart';
import 'package:sabzishop/modal/faq_model.dart';

class FAQScreen extends StatelessWidget {
  FAQController faqController = FAQController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
        leadingWidth: 30,
        title: Text('FAQs', style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
          () => faqController.loading.value ? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
            child: Container(
              child: ListView.builder(
                itemCount: faqController.faqs.length,
                shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index){
                return listItem(faqController.faqs[index],index);
              }),
            ),
          ),
      ),
    );
  }
  Widget listItem(Faq faq,index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
          () => Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width*0.8,
                    child: Text(
                      faq.question,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: faqController.expandedIndex.value == index ? ColorPalette.green : Colors.black
                      ),
                    ),
                  ),
                  Obx(
                        ()=> Container(
                      width: Get.width*0.1,
                      child: IconButton(
                        onPressed: (){
                          if(faqController.expandedIndex.value == index)
                            {
                              faqController.expandedIndex.value = faqController.faqs.length;
                            }
                          else
                            {
                              faqController.expandedIndex.value = index;
                            }
                        },
                        icon: Icon(
                          faqController.expandedIndex.value==index?Icons.remove_outlined:Icons.add,
                          color: faqController.expandedIndex.value == index ? ColorPalette.green : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            ()=>faqController.expandedIndex.value==index
                ? Column(
              children: [
                Container(
                  width: Get.width,
                  child: Text(
                    faq.answer,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 5,)
              ],
            )
                : Container(),
          ),
        ],
      ),
    );

  }
}
