// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/screen/calendar/calendar_screen.dart';
import 'package:money_records_app/screen/graph/graph_screen.dart';
import 'package:money_records_app/screen/home/home_screen.dart';
import 'package:money_records_app/screen/setting/setting_screen.dart';
import 'package:money_records_app/screen/tab/tab_screen_controller.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabScreenController());
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: [
          const HomeScreen(),
          const GraphScreen(),
          CalendarScreen(data: controller.data),
          const SettingScreen(),
        ][controller.selectedIndex.value],
        bottomNavigationBar: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0,
                color: Colors.white,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF4A67AD),
            unselectedItemColor: Colors.black,
            iconSize: 30,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onTap,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.maps_ugc_outlined), label: '入力'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph), label: 'グラフ'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'カレンダー'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
