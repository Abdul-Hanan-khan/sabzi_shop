import 'package:cached_map/cached_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/view/home_screen_and_tabs/homepage.dart';
import 'package:sabzishop/view/my_google_map.dart';

import 'auth_prompt_screen.dart';

class SliderScreen extends StatefulWidget {
  SliderScreen({Key key}) : super(key: key);

  @override
  SliderScreenState createState() => new SliderScreenState();
}

// ------------------ Custom config ------------------
class SliderScreenState extends State<SliderScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage:"assets/image/slider/slider1.jpeg",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage:"assets/image/slider/slider2.jpeg",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        backgroundOpacity: 0,
        backgroundImage:"assets/image/slider/slider3.jpeg",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
  }

  void onDonePress() {
   Mapped.saveFileDirectly(file: {
     "slider" : true
   }, cachedFileName: "slider");
   Get.off(()=>MyGoogleMap());
   // Get.dialog(AuthPromptScreen());
  }

  Widget renderNextBtn() {
    return Icon(Icons.navigate_next_rounded);
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: ColorPalette.green,
    );
  }

  Widget renderSkipBtn() {
    return Text('Skip');
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>( ColorPalette.green.shade100,),
      overlayColor: MaterialStateProperty.all<Color>(ColorPalette.green.shade100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: ColorPalette.green.shade100,
      colorActiveDot: ColorPalette.green.shade600,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}

