import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/graph/graph_list_tile.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime now = DateTime.now();
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
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
            //TODO 2 weeksを消したい
            //TODO 言語を日本語にしたい。
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 12, 1),
              lastDay: DateTime.utc(2100, 12, 31),
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
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const GraphListTile(
                  leading: '本',
                  trailing: '1000',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
