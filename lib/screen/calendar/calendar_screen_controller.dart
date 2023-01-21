// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/screen/detail/detail_screen.dart';
import '../../database/db_provider.dart';

class CalendarScreenController extends GetxController {
  Rxn<DateTime> now = Rxn<DateTime>();
  Rxn<DateTime?> daySelected = Rxn<DateTime?>();
  final calendarList = <Todo>[].obs;

  List<Todo> get calendarLists => calendarList;

  @override
  void onInit() {
    super.onInit();
    now.value = DateTime.now();
  }

  void loadSelectDate(DateTime selectDate) {
    calendarList.clear();
    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        DateFormat outputFormat = DateFormat('yyyy-MM-dd');
        final createdDate = outputFormat.format(value[i].createdDate);
        final selectedDate = outputFormat.format(selectDate);
        if (createdDate == selectedDate) {
          final newCalendarList = Todo(
            buyPrice: value[i].buyPrice,
            discountPrice: value[i].discountPrice,
            categoryName: value[i].categoryName,
            createdDate: value[i].createdDate,
            colorCode: value[i].colorCode,
          );
          calendarList.add(newCalendarList);
        }
      }
    });
  }

  void onTapDetail(Todo todo) {
    Get.to(
      () => DetailScreen(
        discountPrice: todo.discountPrice,
        buyPrice: todo.buyPrice,
        category: todo.categoryName,
        createdDate: todo.createdDate,
      ),
    );
  }
}
