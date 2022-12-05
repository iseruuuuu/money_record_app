import 'package:get/get.dart';

import '../../../preference/shared_preference.dart';

class CategoryScreenController extends GetxController {
  //TODO リストを作る

  RxList<String> categoryList = [''].obs;
  var categoryName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategoryList();
  }

  void loadCategoryList() async {
    categoryList.value =
        await Preference().getListString(PreferenceKey.categoryList);
  }

  void onChanged(String categoryNames) {
    categoryName.value = categoryNames;
  }

  void addList() async {
    categoryList.add(categoryName.value);
    await Preference().setListString(PreferenceKey.categoryList, categoryList);
  }

  void onTapBack(int index) {
    Get.back(result: categoryList[index]);
  }

  void deleteCategory(int index) async {
    categoryList.remove(categoryList[index]);
    await Preference().setListString(PreferenceKey.categoryList, categoryList);
  }
}
