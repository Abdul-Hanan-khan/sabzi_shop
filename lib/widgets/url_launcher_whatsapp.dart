import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherWhatsapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Image.asset('assets/image/whatsapp.png',width: 50,height: 50,),
        onTap: (){
          openwhatsapp(context);
        },
      ),
    );
  }
  openwhatsapp(BuildContext context) async{
    var whatsapp ="+923001114636";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=Hello there, I am contacting from your app. ";
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));
    }
  }
}
