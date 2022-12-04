import 'package:get/get.dart';

class CategoryScreenController extends GetxController {
  //TODO リストを作る

  var categoryName = ''.obs;

  void onChanged(String categoryNames) {
    categoryName.value = categoryNames;
  }

  void addList() {
    //TODO カテゴリー追加する
  }

  void onTapBack(int index) {
    //TODO 選択したリストを渡してあげる
    Get.back(result: '飲食店');
  }
}
