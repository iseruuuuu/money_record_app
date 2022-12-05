import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../preference/shared_preference.dart';
import 'children/category_screen.dart';

class HomeScreenController extends GetxController {
  var isIncome = false.obs;
  var discountPrice = 0.obs;
  var buyPrice = 0.obs;
  var categoryName = ''.obs;
  var createdDate = ''.obs;
  RxList<String> categoryList = [''].obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    createdDate.value = DateFormat('yyyy年M月d日').format(now);
    loadCategory();
  }

  void loadCategory() async {
    categoryList.value =
        await Preference().getListString(PreferenceKey.categoryList);
    categoryName.value = categoryList[0];
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
    }
  }

  void changeDateTime() async {
    DateTime date = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      createdDate.value = DateFormat('yyyy年M月d日').format(picked);
    }
  }

  void onTapStore() {}
}
