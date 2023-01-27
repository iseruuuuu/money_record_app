// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:money_records_app/constants/admob.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/chart_data.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/screen/detail/detail_screen.dart';

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
  RxList<int> amountColorCodeList = [0].obs;
  var adContainer = Container().obs;
  final myBanner = BannerAd(
    adUnitId: Platform.isAndroid ? Admob.android : Admob.iOS,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
    ),
  );

  void loadInit() {
    final outputFormat = DateFormat('yyyy年 MM月');
    date.value = outputFormat.format(now);
    loadAmountMoneys();
    loadList();
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

  void loadList() {
    resetList();
    monthCount.value = DateTime.now().month;
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i].createdDate.month == DateTime.now().month) {
          addList(value, i);
        }
      }
    });
  }

  void addList(List<Todo> value, int i) {
    amountIdList.add(value[i].id!);
    amountBuyList.add(value[i].buyPrice);
    amountDiscountPriceList.add(value[i].discountPrice);
    amountCategoryList.add(value[i].categoryName);
    amountCreatedTimeList.add(value[i].createdDate);
    amountColorCodeList.add(value[i].colorCode);
    listLength.value = amountCreatedTimeList.length;
    final newData = ChartData(
      value[i].categoryName,
      value[i].buyPrice.toDouble(),
      Color(value[i].colorCode),
    );
    chartData
      ..add(newData)
      ..sort((a, b) => a.x.compareTo(b.x));
  }

  void resetList() {
    amountIdList.value = [];
    amountBuyList.value = [];
    amountDiscountPriceList.value = [];
    amountCategoryList.value = [];
    amountCreatedTimeList.value = [];
    amountSavePrice.value = 0;
    amountBuyPrice.value = 0;
    chartData.value = [];
    listLength.value = 0;
    amountColorCodeList.value = [];
  }

  void changeDate({required bool isAdvance, required int month}) {
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
      setDate(now.month + 1);
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
    resetList();
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i].createdDate.month == month) {
          addList(value, i);
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

  void onTapDetail(int index) {
    Get.to(
      () => DetailScreen(
        discountPrice: amountDiscountPriceList[index],
        buyPrice: amountBuyList[index],
        category: amountCategoryList[index],
        createdDate: amountCreatedTimeList[index],
      ),
    );
  }

  void deleteBloc(BuildContext context, int index) {
    final bloc = Provider.of<TodoBloc>(context, listen: false);
    bloc.delete(amountIdList[index]);
    loadInit();
  }
}
