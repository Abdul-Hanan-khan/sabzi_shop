import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabzishop/Settings/color_palates.dart';
import 'package:sabzishop/controller/bottom_bar.dart';

class BottomNavigateBar extends StatelessWidget {
  BottomBarController bottomController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetX<BottomBarController>(
        builder: (controller) {
          return  BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: controller.currentBNBIndex.value,
            onTap: controller.indexChanged,
            selectedItemColor: ColorPalette.green,
            unselectedItemColor: Colors.black54,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shop_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_offer_outlined),
                label: 'Deals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                label: 'Account',
              ),
            ],
          );
        }
    );
  }
}