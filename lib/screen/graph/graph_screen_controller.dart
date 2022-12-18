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
  RxList<String> amountIdList = [''].obs;
  RxList<int> amountBuyList = [0].obs;
  RxList<int> amountDiscountPriceList = [0].obs;
  RxList<String> amountCategoryList = [''].obs;
  RxList<DateTime> amountCreatedTimeList = [DateTime.now()].obs;
  RxInt listLength = 0.obs;
  RxInt monthCount = 1.obs;

  void loadInit() {
    final outputFormat = DateFormat('yyyy年 MM月');
    date.value = outputFormat.format(now);
    loadChartDate();
    loadAmountMoneys();
    loadList();
    DBProvider.db.getAllTodo().then((value) {
      listLength.value = value.length;
    });
  }

  void loadList() {
    amountIdList.value = [];
    amountBuyList.value = [];
    amountDiscountPriceList.value = [];
    amountCategoryList.value = [];
    amountCreatedTimeList.value = [];
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i].createdDate.month == DateTime.now().month) {
          amountIdList.add(value[i].id!);
          amountBuyList.add(value[i].buyPrice);
          amountDiscountPriceList.add(value[i].discountPrice);
          amountCategoryList.add(value[i].categoryName);
          amountCreatedTimeList.add(value[i].createdDate);
        }
      }
    });
  }

  void changeDate({required bool isAdvance, required int month}) {
    //TODO if文からSwitch文に変えてあげる
    monthCount.value += month;
    if (monthCount > 2) {
      monthCount.value = 2;
    }
    if (monthCount < 0) {
      monthCount.value = 0;
    }
    if (monthCount.value == 0) {
      final prevMonthLastDay = DateTime(now.year, now.month - 1);
      final outputFormat = DateFormat('yyyy年 MM月');
      date.value = outputFormat.format(prevMonthLastDay);
      reloadList(now.month - 1);
    } else if (monthCount.value == 1) {
      final prevMonthLastDay = DateTime(now.year, now.month);
      final outputFormat = DateFormat('yyyy年 MM月');
      date.value = outputFormat.format(prevMonthLastDay);
      reloadList(now.month);
    } else if (monthCount.value == 2) {
      final prevMonthLastDay = DateTime(now.year, now.month + 1);
      final outputFormat = DateFormat('yyyy年 MM月');
      date.value = outputFormat.format(prevMonthLastDay);
      reloadList(now.month + 1);
    }
    //TOBE 課金要素に、二ヶ月前以前と二ヶ月後以降の値を取得できるようにする。
  }

  void reloadList(int month) {
    //TODO　リストだけが更新ができていない。
    amountIdList.value = [];
    amountBuyList.value = [];
    amountDiscountPriceList.value = [];
    amountCategoryList.value = [];
    amountCreatedTimeList.value = [];
    amountSavePrice.value = 0;
    amountBuyPrice.value = 0;
    chartData.value = [];
    listLength.value = 0;
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i].createdDate.month == month) {
          listLength.value = value.length;
          amountIdList.add(value[i].id!);
          amountBuyList.add(value[i].buyPrice);
          amountDiscountPriceList.add(value[i].discountPrice);
          amountCategoryList.add(value[i].categoryName);
          amountCreatedTimeList.add(value[i].createdDate);
          amountBuyPrice += value[i].buyPrice;
          amountSavePrice += value[i].discountPrice;
          final newData = ChartData(
            value[i].categoryName,
            value[i].buyPrice.toDouble(),
            Colors.yellowAccent,
          );
          chartData.add(newData);
        }
      }
    });
  }

  void loadAmountMoneys() {
    amountSavePrice.value = 0;
    amountBuyPrice.value = 0;
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        amountBuyPrice += value[i].buyPrice;
        amountSavePrice += value[i].discountPrice;
      }
    });
  }

  void loadChartDate() {
    chartData.value = [];
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        final newData = ChartData(
          value[i].categoryName,
          value[i].buyPrice.toDouble(),
          Colors.yellowAccent,
        );
        chartData.add(newData);
      }
    });
  }
}
