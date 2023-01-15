// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import 'package:money_records_app/screen/calendar/calendar_screen_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarScreenController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: Obx(
              () => TableCalendar(
                //TODO 言語を日本語にしたい。
                // locale: 'ja_JP',
                focusedDay: controller.now.value!,
                firstDay: DateTime.utc(2022, 12, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(controller.daySelected.value, day);
                },
                onDaySelected: (selected, focused) {
                  if (!isSameDay(controller.daySelected.value, selected)) {
                    controller.daySelected.value = selected;
                    controller.now.value = focused;
                    controller.loadSelectDate(selected);
                  }
                },
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.calendarList.length,
                itemBuilder: (context, index) {
                  final event = controller.calendarList[index];
                  return Card(
                    //TODO リストのデザインを一新する。
                    child: GestureDetector(
                      onTap: () => controller.onTapDetail(event),
                      child: ListTile(
                        title: Text(event.categoryName),
                        subtitle: Text(event.createdDate.toString()),
                        leading: Text(event.buyPrice.toString()),
                        trailing: Text(event.discountPrice.toString()),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
