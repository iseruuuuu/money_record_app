import 'package:flutter/material.dart';
import 'package:money_records_app/screen/tab/tab_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabScreen(),
    );
  }
}
