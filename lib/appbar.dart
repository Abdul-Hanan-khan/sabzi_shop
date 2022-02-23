import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget  implements PreferredSizeWidget{
  @override
  PreferredSizeWidget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 60),
      child: Container(
        child: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset('assets/image/sabzishopicon.png'),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ],
        ),
      ),
    );
  }






  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

