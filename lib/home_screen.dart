// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weathershare/features/screens/add_iot_devices/add_iot_brokers_screen.dart';
import 'package:weathershare/features/screens/log_data/log_data.dart';
import 'package:weathershare/features/screens/map_screen/map_screen.dart';
import 'package:weathershare/features/screens/post_images/post_images_screen.dart';
import 'package:weathershare/features/screens/user_profile/user_screen.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    // Determine if the current theme is light or dark
    bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Use fixed instead of shifting
          iconSize: 30,
          showSelectedLabels:
              false, // Do not show labels when an item is selected
          showUnselectedLabels: false, // Do not show labels at other times
          elevation: 0,
          currentIndex: controller.selectedMenu.value,
          onTap: (index) => controller.selectedMenu.value = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              activeIcon: Icon(Icons.map),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_chart_outlined),
              activeIcon: Icon(Icons.add_chart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: '',
            ),
          ],
          selectedItemColor: isLightTheme
              ? Colors.black
              : Colors.white, // Black in light theme, white in dark
          unselectedItemColor: isLightTheme
              ? Colors.grey
              : Colors.grey[300], // Adjusted for theme
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedMenu = 0.obs;
  final screens = [
    const MapScreen(),
    const LogDataScreen(),
    const PostImagesScreen(),
    const AddIoTBrokersScreen(),
    const UserProfileScreen(),
  ];
}
