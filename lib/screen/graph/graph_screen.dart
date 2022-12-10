import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_records_app/components/graph/graph_list_tile.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/model/chart_data.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/screen/detail/detail_screen.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GraphScreenController());
    final bloc = Provider.of<TodoBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => controller.changeDate(isAdvance: false),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Obx(
              () => Text(
                controller.date.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () => controller.changeDate(isAdvance: true),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Obx(
              () => SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    dataSource: controller.chartData.value,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => GraphListTile(
              leading: '合計',
              trailing: controller.amountBuyPrice.value.toString(),
            ),
          ),
          Obx(
            () => GraphListTile(
              leading: '節約できた金額',
              trailing: controller.amountSavePrice.value.toString(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: StreamBuilder<List<Todo>>(
                stream: bloc.todoStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Todo todo = snapshot.data![index];
                        return Dismissible(
                          key: Key(todo.id!),
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          onDismissed: (direction) {
                            bloc.delete(todo.id!);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      todo: todo,
                                    ),
                                  ),
                                );
                              },
                              title: Row(
                                children: [
                                  //TODO アイコンをランダムで載せる
                                  Text(todo.category),
                                ],
                              ),
                              trailing: Text(
                                "${todo.buyPrice}円",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
