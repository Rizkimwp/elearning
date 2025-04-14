import 'package:elearning/app/components/modals/nav_item.dart';
import 'package:elearning/app/modules/home/views/home_view.dart';
import 'package:elearning/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.activePages,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.12,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
              selectedIndex: controller.selectedIndex,
              onTap: (index) => controller.changePage(index),
            ),
            NavItem(
              icon: Icons.book,
              label: 'Modul',
              index: 1,
              selectedIndex: controller.selectedIndex,
              onTap: (index) => controller.changePage(index),
            ),
            NavItem(
              icon: Icons.message,
              label: 'Diskusi',
              index: 2,
              selectedIndex: controller.selectedIndex,
              onTap: (index) => controller.changePage(index),
            ),
            NavItem(
              icon: Icons.account_circle,
              label: 'Profile',
              index: 3,
              selectedIndex: controller.selectedIndex,
              onTap: (index) => controller.changePage(index),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your search action here
        },
        child: const Icon(Icons.search, ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
