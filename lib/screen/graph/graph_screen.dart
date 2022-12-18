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
              onPressed: () =>
                  controller.changeDate(isAdvance: false, month: -1),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Obx(
              () => Text(
                controller.date.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () => controller.changeDate(isAdvance: true, month: 1),
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
              color: const Color(0xFFFCF8EA),
              //TODO 現在、StreamBuilderを使っていないため、取り除くor入れる
              child: StreamBuilder<List<Todo>>(
                stream: bloc.todoStream,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: controller.listLength.value,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: Key(controller.amountIdList[index]),
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          onDismissed: (direction) {
                            bloc.delete(controller.amountIdList[index]);
                            controller.loadInit();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: controller.amountIdList[index],
                                      discountPrice: controller
                                          .amountDiscountPriceList[index],
                                      buyPrice: controller.amountBuyList[index],
                                      category:
                                          controller.amountCategoryList[index],
                                      createdDate: controller
                                          .amountCreatedTimeList[index],
                                    ),
                                  ),
                                );
                              },
                              title: Row(
                                children: [
                                  Text(
                                    controller.amountCategoryList[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                "${controller.amountBuyList[index]}円",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
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
