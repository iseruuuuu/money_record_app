// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:money_records_app/constants/admob_constant.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/screen/detail/detail_screen.dart';

class CalendarScreenController extends GetxController {
  CalendarScreenController({required this.data});

  final List<DateTime> data;
  Rxn<DateTime> now = Rxn<DateTime>();
  Rxn<DateTime?> daySelected = Rxn<DateTime?>();
  final calendarList = <Todo>[].obs;
  List<int> event = [];
  var adContainer = Container().obs;
  final myBanner = BannerAd(
    adUnitId: Platform.isAndroid ? AdmobConstant.android : AdmobConstant.iOS,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
    ),
  );

  @override
  void onInit() {
    super.onInit();
    now.value = DateTime.now();
    loadAdmob();
  }

  void loadAdmob() {
    myBanner.load();
    final adWidget = AdWidget(ad: myBanner);
    adContainer.value = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(Get.context!).size.width,
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );
  }

  List<int> getEvent(DateTime date) {
    return loadEvent(date);
  }

  List<int> loadEvent(DateTime date) {
    event.clear();
    for (var i = 0; i < data.length; i++) {
      if (data[i].day == date.day && data[i].month == date.month) {
        event.add(0);
      }
    }
    return event;
  }

  void loadSelectDate(DateTime selectDate) {
    calendarList.clear();
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        DateFormat outputFormat = DateFormat('yyyy-MM-dd');
        final createdDate = outputFormat.format(value[i].createdDate);
        final selectedDate = outputFormat.format(selectDate);
        if (createdDate == selectedDate) {
          final newCalendarList = Todo(
            buyPrice: value[i].buyPrice,
            discountPrice: value[i].discountPrice,
            categoryName: value[i].categoryName,
            createdDate: value[i].createdDate,
            colorCode: value[i].colorCode,
          );
          calendarList.add(newCalendarList);
        }
      }
    });
  }

  void onTapDetail(Todo todo) {
    Get.to(
      () => DetailScreen(
        discountPrice: todo.discountPrice,
        buyPrice: todo.buyPrice,
        category: todo.categoryName,
        createdDate: todo.createdDate,
      ),
    );
  }
}
