import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var isIncome = false.obs;

  void changeIncome(bool isIncomes) {
    isIncome.value = isIncomes;
  }
}
