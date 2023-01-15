// Dart imports:
import 'dart:math';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/preference/shared_preference.dart';

class CategoryScreenController extends GetxController {

  RxList<String> categoryList = [''].obs;
  RxString categoryName = ''.obs;
  RxInt color = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategoryList();
  }

  Future<void> loadCategoryList() async {
    categoryList.value =
        await Preference().getListString(PreferenceKey.categoryList);
  }

  void onChanged(String categoryNames) {
    categoryName.value = categoryNames;
  }

  Future<void> addList() async {
    final color = (Random().nextDouble() * 0xFFFFFF).toInt();
    final colorCode = '0xFF$color';
    await Preference().setString(categoryName.value, colorCode);
    categoryList.add(categoryName.value);
    await Preference().setListString(PreferenceKey.categoryList, categoryList);
  }

  void onTapBack(int index) {
    Get.back(result: categoryList[index]);
  }

  Future<void> deleteCategory(int index) async {
    categoryList.remove(categoryList[index]);
    await Preference().setListString(PreferenceKey.categoryList, categoryList);
  }
}
