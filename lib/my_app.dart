// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/screen/tab/tab_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'money_records_app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.light),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ja")],
      locale: const Locale('ja', 'JP'),
      home: Provider<Bloc>(
        create: (context) => Bloc(),
        dispose: (context, bloc) => bloc.dispose(),
        builder: EasyLoading.init(),
        child: const TabScreen(),
      ),
    );
  }
}
