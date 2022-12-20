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
    loadAmountMoneys();
    loadList();
  }

  void loadList() {
    amountIdList.value = [];
    amountBuyList.value = [];
    amountDiscountPriceList.value = [];
    amountCategoryList.value = [];
    amountCreatedTimeList.value = [];
    monthCount.value = DateTime.now().month;
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i].createdDate.month == DateTime.now().month) {
          amountIdList.add(value[i].id!);
          amountBuyList.add(value[i].buyPrice);
          amountDiscountPriceList.add(value[i].discountPrice);
          amountCategoryList.add(value[i].categoryName);
          amountCreatedTimeList.add(value[i].createdDate);
          listLength.value = amountCreatedTimeList.length;
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

  void changeDate({required bool isAdvance, required int month}) {
    //TODO 整理したい。
    if (isAdvance) {
      monthCount.value++;
    } else {
      monthCount.value--;
    }
    if (monthCount.value == now.month) {
      monthCount.value == now.month;
      setDate(now.month);
    } else if (monthCount.value == now.month + 1) {
      monthCount.value == now.month + 1;
    } else if (monthCount.value == now.month - 1) {
      monthCount.value == now.month - 1;
      setDate(now.month - 1);
    }
    if (monthCount.value == 0) {
      setDate(12);
      monthCount.value = 12;
    }
    if (monthCount.value == 13) {
      setDate(1);
      monthCount.value = 1;
    }
    //TOBE 課金要素に、二ヶ月前以前と二ヶ月後以降の値を取得できるようにする。
  }

  void setDate(int month) {
    final prevMonthLastDay = DateTime(now.year, month);
    final outputFormat = DateFormat('yyyy年 MM月');
    date.value = outputFormat.format(prevMonthLastDay);
    reloadList(month);
  }

  void reloadList(int month) {
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
          listLength.value++;
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
}
