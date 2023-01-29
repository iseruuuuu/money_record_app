// Package imports:
import 'package:get/get.dart';
import 'package:money_records_app/database/db_provider.dart';

// Project imports:
import 'package:money_records_app/screen/calendar/calendar_screen_controller.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';

class TabScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final data = <DateTime>[];

  @override
  void onInit() {
    super.onInit();
    getDate();
  }

  void getDate() {
    data.clear();
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        data.add(value[i].createdDate);
      }
    });
  }

  void onTap(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 1) {
      final controller = Get.put(GraphScreenController());
      controller.loadInit();
    } else if (selectedIndex.value == 2) {
      final controller = Get.put(CalendarScreenController(data: data));
      getDate();
      final now = DateTime.now();
      controller.loadSelectDate(now);
    }
  }
}
