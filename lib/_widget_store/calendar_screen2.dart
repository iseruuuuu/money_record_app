// Dart imports:
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:table_calendar/table_calendar.dart';

// Project imports:
import 'package:money_records_app/database/db_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime now = DateTime.now();
  DateTime? _selected;
  late Map<DateTime, List> _eventsList;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _eventsList = {};
    getData();
  }

  void getData() {
    _selected = now;

    DBProvider.db.getAllTodo().then((value) {
      for (var i = 0; i < value.length; i++) {
        //TODO 2つを無理繰り入れないとなぜか追加できない
        // _eventsList = {
        //   value[0].createdDate: [value[0].categoryName],
        // };
        _eventsList[value[i].createdDate]?.add(value[i].categoryName);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);
    List getEvent(DateTime day) {
      return events[day] ?? [];
    }

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
            //TODO 言語を日本語にしたい。
            child: TableCalendar(
              eventLoader: getEvent,
              firstDay: DateTime.utc(2022, 12, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selected, day);
              },
              onDaySelected: (selected, focused) {
                if (!isSameDay(_selected, selected)) {
                  setState(() {
                    _selected = selected;
                    now = focused;
                  });
                }
              },
              focusedDay: now,
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFFCF8EA),
              child: ListView(
                shrinkWrap: true,
                children: getEvent(_selected!).map((event) {
                  return ListTile(
                    title: Text(event.toString()),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
