import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/screen/tab/tab_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'money_records_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Provider<TodoBloc>(
        create: (context) => TodoBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        builder: EasyLoading.init(),
        child: const TabScreen(),
      ),
    );
  }
}
