//import 'package:sabzishop/Utils/AppSettings.dart';
//import 'package:sabzishop/Utils/styles.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
//
//class MyTypeAheadField extends StatelessWidget {
//  TextEditingController controller;
//  String label;
//  bool obsecureText =false;
//  IconButton suffixIcon;
//  ValueChanged<String> onChanged;
//  ValueChanged<String> onSaved;
//  ValueChanged<String> onSubmit;
//  ValueChanged<String> suggestionsCallback;
//  Function onEditingComplete;
//  GestureTapCallback onTap;
//  bool enabled=true;
//  int maxLines;
//  List items;
//  List suggestionList;
//  bool readOnly;
//  bool cursor;
//  TextInputType keyboardType;
//  SuggestionsBoxController suggestionsBoxController;
//
//  MyTypeAheadField({
//    @required this.controller,
//    @required this.label,
//    this.obsecureText,
//    this.onChanged,
//    this.suffixIcon,
//    this.onEditingComplete,
//    this.enabled,
//    this.onTap,
//    this.maxLines,
//    this.items,
//    this.onSubmit,
//    this.suggestionsBoxController,
//    this.keyboardType,
//    this.readOnly,
//    this.cursor
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 45,
//      child: TypeAheadFormField(
//        suggestionsBoxController: suggestionsBoxController,
//        hideOnEmpty: true,
//        textFieldConfiguration: TextFieldConfiguration(
//          keyboardType: keyboardType,
//          maxLines: maxLines??1,
//          enabled: enabled,
//          onSubmitted: (value){
//            if(value!=null)
//              controller.text=suggestionList[0];
//            onSubmit==null?null: onSubmit(value);
//          },
//          onTap: onTap,
//          onEditingComplete: onEditingComplete,
//          onChanged:onChanged,
//          controller: controller,
//          obscureText: obsecureText??false,
//          cursorColor: AppColors.primaryColor2,
//          style: Styles.textFieldTextStyle(),
//          decoration: InputDecoration(
//
//            suffixIcon: suffixIcon,
//            fillColor: AppColors.primaryColor2,
//            focusColor: AppColors.primaryColor2,
//            hoverColor: AppColors.primaryColor2,
//            labelText: label,
//            labelStyle: TextStyle(
//                color: AppColors.primaryColor2
//            ),
//            disabledBorder:OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: AppColors.primaryColor2
//                )
//            ),
//            enabledBorder: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: AppColors.primaryColor2
//                )
//            ),
//            focusedBorder:  OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: AppColors.primaryColor2
//                )
//            ),
//            border: OutlineInputBorder(
//                borderSide: BorderSide(
//                    color: AppColors.primaryColor2
//                )
//            ),
//            // hintText: label,
//            hintStyle: TextStyle(
//                color: AppColors.primaryColor2
//            ),
//          ),
//        ),
//        suggestionsCallback: (pattern) {
//
//          return suggestionList= getSuggestions(pattern);
//        },
//        itemBuilder: (context, suggestion) {
//          return ListTile(
//            title: Text(suggestion),
//          );
//        },
//        transitionBuilder: (context, suggestionsBox, controller) {
//          return suggestionsBox;
//        },
//        onSuggestionSelected: (suggestion) {
//          controller.text = suggestion;
//        },
//        validator: (value) {
//          if (value.isEmpty) {
//            return 'Please select a value';
//          }
//          if(!items.contains(value))
//            return 'Please Select a valid value';
//          return "";
//        },
//        onSaved: onSaved,
//      ),
//    );
//  }
//
//  List getSuggestions(String pattern) {
//    if(pattern !=""||pattern!=null)
//      return items
//          .where((string) => string.toLowerCase().contains(pattern.toLowerCase()))
//          .toList();
//    else
//      {
//      return [];
//      }
//    return null;
//  }
//}
