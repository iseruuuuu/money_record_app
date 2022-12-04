import 'package:get/get.dart';

import 'children/category_screen.dart';

class HomeScreenController extends GetxController {
  var isIncome = false.obs;
  var discountPrice = ''.obs;
  var buyPrice = ''.obs;

  void changeIncome(bool isIncomes) {
    isIncome.value = isIncomes;
  }

  void changeDiscountPrice(String discountPrices) {
    discountPrice.value = discountPrices;
  }

  void changeBuyPrice(String buyPrices) {
    buyPrice.value = buyPrices;
  }

  void changeCategory() {
    Get.to(() => const CategoryScreen());
  }
}
