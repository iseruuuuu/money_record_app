import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'children/category_screen.dart';

class HomeScreenController extends GetxController {
  var isIncome = false.obs;
  var discountPrice = ''.obs;
  var buyPrice = ''.obs;
  var categoryName = ''.obs;
  var createdDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    createdDate.value = DateFormat('M月d日').format(now);

    //TODO カテゴリー名前をリストの１番目にする
  }

  void changeIncome(bool isIncomes) {
    isIncome.value = isIncomes;
  }

  void changeDiscountPrice(String discountPrices) {
    discountPrice.value = discountPrices;
  }

  void changeBuyPrice(String buyPrices) {
    buyPrice.value = buyPrices;
  }

  void changeCategory() async {
    var result = await Get.to(() => const CategoryScreen());
    categoryName.value = result.toString();
  }

  void changeDateTime() async {
    DateTime date = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      createdDate.value = DateFormat('M月d日').format(picked);
    }
  }
}
