import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/chart_data.dart';

class GraphScreenController extends GetxController {
  DateTime now = DateTime.now();
  RxString date = ''.obs;
  RxInt amountBuyPrice = 0.obs;
  RxInt amountSavePrice = 0.obs;
  RxList<ChartData> chartData = <ChartData>[].obs;

  @override
  void onInit() {
    super.onInit();
    final outputFormat = DateFormat('yyyy年 MM月');
    date.value = outputFormat.format(now);
    getDate();
    getMoney();
  }

  void changeDate({required bool isAdvance}) {
    if (isAdvance) {
      final prevMonthLastDay = DateTime(now.year, now.month + 1);
      final outputFormat = DateFormat('yyyy年 MM月');
      date.value = outputFormat.format(prevMonthLastDay);
    } else {
      final prevMonthLastDay = DateTime(now.year, now.month - 1);
      final outputFormat = DateFormat('yyyy年 MM月');
      date.value = outputFormat.format(prevMonthLastDay);
    }

    //TODO データを変える
  }

  void getMoney() {
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        amountBuyPrice += value[i].buyPrice;
        amountSavePrice += value[i].discountPrice;
      }
    });
  }

  void getDate() {
    //TODO 同じカテゴリーをまとめて表示する。
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        final newData = ChartData(
          value[i].category,
          value[i].buyPrice.toDouble(),
          Colors.yellowAccent,
        );
        chartData.add(newData);
      }
    });
  }
}
