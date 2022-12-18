import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';

class TabScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;

  void onTap(int index) {
    selectedIndex.value = index;
    if(selectedIndex.value == 1) {
      final controller = Get.put(GraphScreenController());
      controller.loadInit();
    }
  }
}
