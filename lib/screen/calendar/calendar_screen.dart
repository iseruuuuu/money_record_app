// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/screen/calendar/calendar_screen_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBarItem(
        appBar: AppBar(),
        title: 'カレンダー',
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 350,
            child: Obx(
              () => TableCalendar(
                locale: 'ja_JP',
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      child: GestureDetector(
                        onTap: () => controller.onTapDetail(event),
                        child: ListTile(
                          leading: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              event.categoryName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 300,
                                child: Text(
                                  '${event.buyPrice}円',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 300,
                                child: Text(
                                  '${event.discountPrice}円',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
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
