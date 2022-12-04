import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_records_app/components/graph/graph_list_tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/chart_data.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  String date = '';
  DateTime now = DateTime.now();
  DateTime dateTime = DateTime.now();

  //TODO 金額のデータをあとで入れる
  final List<ChartData> chartData = [
    ChartData('David', 25, Colors.red),
    ChartData('Steve', 38, Colors.grey),
    ChartData('Jack', 34, Colors.yellowAccent),
    ChartData('Others', 52, Colors.black87),
  ];

  @override
  void initState() {
    super.initState();
    DateFormat outputFormat = DateFormat('yyyy年 MM月');
    date = outputFormat.format(now);
    dateTime = now;
    print(dateTime);
  }

  void changeDate(bool isAdvance) {
    //TODO あとで日付を変える(未完成)
    if (isAdvance) {
      final prevMonthLastDay = DateTime(dateTime.year, dateTime.month + 1);
      DateFormat outputFormat = DateFormat('yyyy年 MM月');
      date = outputFormat.format(prevMonthLastDay);

      print(prevMonthLastDay);
    } else {
      final prevMonthLastDay = DateTime(dateTime.year, dateTime.month - 1);
      DateFormat outputFormat = DateFormat('yyyy年 MM月');
      date = outputFormat.format(prevMonthLastDay);

      print(prevMonthLastDay);
    }

    setState(() {});
    //TODO データを変える
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => changeDate(false),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Text(
              date,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => changeDate(true),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                )
              ],
            ),
          ),
          const GraphListTile(
            leading: '合計',
            trailing: '10000000',
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
