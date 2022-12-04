import 'package:flutter/material.dart';
import 'package:money_records_app/screen/calendar/calendar_screen.dart';
import 'package:money_records_app/screen/graph/graph_screen.dart';
import 'package:money_records_app/screen/home/home_screen.dart';
import 'package:money_records_app/screen/setting/setting_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const GraphScreen(),
        const CalendarScreen(),
        const SettingScreen(),
      ][selectedIndex],
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
          //TODO 色の調整を行う
          backgroundColor: Colors.white,
          //TODO 色の調整を行う
          selectedItemColor: Colors.orange,
          //TODO 色の調整を行う
          unselectedItemColor: Colors.black,
          iconSize: 30,
          currentIndex: selectedIndex,
          onTap: (index) => onTap(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '入力'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: 'グラフ'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'カレンダー'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
