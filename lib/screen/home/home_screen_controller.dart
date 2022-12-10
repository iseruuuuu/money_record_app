import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/preference/shared_preference.dart';
import 'package:money_records_app/screen/home/children/category_screen.dart';

class HomeScreenController extends GetxController {
  RxBool isIncome = false.obs;
  RxInt discountPrice = 0.obs;
  RxInt buyPrice = 0.obs;
  RxString categoryName = ''.obs;
  RxString createdDate = ''.obs;
  late DateTime createdDates;
  RxList<String> categoryList = [''].obs;

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    createdDate.value = DateFormat('yyyy年M月d日').format(now);
    createdDates = now;
    loadCategory();
  }

  Future<void> loadCategory() async {
    categoryList.value =
        await Preference().getListString(PreferenceKey.categoryList);
    if (categoryList.isNotEmpty) {
      categoryName.value = categoryList[0];
    } else {
      categoryName.value = 'カテゴリー選択';
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

  Future<void> changeCategory() async {
    var result = await Get.to(() => const CategoryScreen());
    if (result != null) {
      categoryName.value = result.toString();
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
    final newMoney = Todo(
      buyPrice: buyPrice.value,
      discountPrice: discountPrice.value,
      category: categoryName.value,
      createdDate: createdDates,
    );
    TodoBloc().create(newMoney);
  }
}
