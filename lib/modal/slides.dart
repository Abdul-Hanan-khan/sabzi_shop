class Slides {
  String initialSlide1;
  String initialSlide2;
  String initialSlide3;

  Slides({this.initialSlide1, this.initialSlide2, this.initialSlide3});

  Slides.fromJson(Map<String, dynamic> json) {
    initialSlide1 = json['initial_slide_1'];
    initialSlide2 = json['initial_slide_2'];
    initialSlide3 = json['initial_slide_3'];
  }
}