import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/preference/shared_preference.dart';
import 'package:money_records_app/screen/home/children/category_screen/category_screen.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class HomeScreenController extends GetxController {
  RxBool isIncome = false.obs;
  RxInt discountPrice = 0.obs;
  RxInt buyPrice = 0.obs;
  RxString categoryName = ''.obs;
  RxString createdDate = ''.obs;
  late DateTime createdDates;
  RxList<String> categoryList = [''].obs;
  RxInt colorCode = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppTracking();
    final now = DateTime.now();
    createdDate.value = DateFormat('yyyy年M月d日').format(now);
    createdDates = now;
  }

  void loadAppTracking() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  void changeIncome(bool isIncomes) {
    isIncome.value = isIncomes;
  }

  void changeDiscountPrice(String discountPrices) {
    discountPrice.value = int.parse(discountPrices);
  }

  void changeBuyPrice(String buyPrices) {
    buyPrice.value = int.parse(buyPrices);
  }

  void changeCategory() async {
    var result = await Get.to(() => const CategoryScreen());
    if (result != null) {
      categoryName.value = result.toString();
      var color = await Preference().getString(categoryName.value);
      colorCode.value = int.parse(color);
    }
  }

  Future<void> changeDateTime() async {
    final date = DateTime.now();
    final picked = await showDatePicker(
        context: Get.context!,
        initialDate: date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      createdDate.value = DateFormat('yyyy年M月d日').format(picked);
      createdDates = picked;
    }
  }

  void onTapStore() {
    //todo warningを消す。
    if (buyPrice.value != '' &&
        discountPrice.value != '' &&
        categoryName.value != '') {
      final newMoney = Todo(
        buyPrice: buyPrice.value,
        discountPrice: discountPrice.value,
        categoryName: categoryName.value,
        createdDate: createdDates,
        colorCode: colorCode.value,
      );
      TodoBloc().create(newMoney);
      openDialog(isError: false);
    } else {
      openDialog(isError: true);
    }
  }

  void openDialog({required bool isError}) {
    PanaraInfoDialog.show(
      Get.context!,
      title: isError ? "Error" : "Success",
      message: isError
          ? "One of them is empty.\n"
              "Please check and Try again."
          : "You can post contents.\n"
              "please check it.",
      buttonText: "OK",
      panaraDialogType:
          isError ? PanaraDialogType.error : PanaraDialogType.success,
      barrierDismissible: false,
      onTapDismiss: () {
        Get.back();
      },
    );
  }
}
