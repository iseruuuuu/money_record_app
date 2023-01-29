// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:money_records_app/constants/color_constant.dart';
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/extension/deviceSize.dart';
import 'package:money_records_app/screen/calendar/calendar_screen_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<DateTime> data;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalendarScreenController(data: data));
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBarItem(
        appBar: AppBar(),
        title: 'カレンダー',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: context.screenWidth,
              height: 350,
              child: Obx(
                () => TableCalendar(
                  locale: 'ja_JP',
                  eventLoader: (date) => controller.getEvent(date),
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
                            width: context.screenWidth / 2,
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
                                width: context.screenWidth - 300,
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
                                width: context.screenWidth - 300,
                                child: Text(
                                  '${event.discountPrice}円',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.grey,
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
          controller.adContainer.value,
        ],
      ),
    );
  }
}
