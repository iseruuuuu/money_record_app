// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/screen/detail/detail_screen.dart';

class CalendarScreenController extends GetxController {
  CalendarScreenController({required this.data});

  final List<DateTime> data;
  Rxn<DateTime> now = Rxn<DateTime>();
  Rxn<DateTime?> daySelected = Rxn<DateTime?>();
  final calendarList = <Money>[].obs;
  List<int> event = [];

  @override
  void onInit() {
    super.onInit();
    now.value = DateTime.now();
  }

  List<int> getEvent(DateTime date) {
    return loadEvent(date);
  }

  List<int> loadEvent(DateTime date) {
    event.clear();
    for (var i = 0; i < data.length; i++) {
      if (data[i].day == date.day && data[i].month == date.month) {
        event.add(0);
      }
    }
    return event;
  }

  void loadSelectDate(DateTime selectDate) {
    calendarList.clear();
    DBProvider.db.getAllMoney().then((value) {
      for (var i = 0; i < value.length; i++) {
        DateFormat outputFormat = DateFormat('yyyy-MM-dd');
        final createdDate = outputFormat.format(value[i].createdDate);
        final selectedDate = outputFormat.format(selectDate);
        if (createdDate == selectedDate) {
          final newCalendarList = Money(
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

  void onTapDetail(Money todo) {
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
