import 'package:get/get.dart';

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
}
