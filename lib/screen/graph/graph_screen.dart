// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Project imports:
import 'package:money_records_app/admob/admob_banner.dart';
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';
import 'package:money_records_app/model/chart_data.dart';
import 'package:money_records_app/screen/graph/children/graph_empty_screen.dart';
import 'package:money_records_app/screen/graph/children/graph_item.dart';
import 'package:money_records_app/screen/graph/children/graph_list_tile.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GraphScreenController());
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.appBarColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => controller.changeDate(
                isAdvance: false,
                month: -1,
              ),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            Obx(
              () => Text(
                controller.selectedDate.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () => controller.changeDate(
                isAdvance: true,
                month: 1,
              ),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.graphList.isEmpty
            ? const GraphEmptyScreen()
            : Column(
                children: [
                  Container(
                    width: context.screenWidth,
                    color: ColorConstant.backgroundColor,
                    height: 230,
                    child: Obx(
                      () => SfCircularChart(
                        series: <CircularSeries<dynamic, dynamic>>[
                          PieSeries<ChartData, String>(
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false),
                            dataSource: controller.chartData.toList(),
                            pointColorMapper: (ChartData data, _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => GraphItem(
                      leading: '合計',
                      trailing: controller.amountBuyPrice.value.toString(),
                      color: ColorConstant.black,
                      isFirst: true,
                    ),
                  ),
                  Obx(
                    () => GraphItem(
                      leading: '節約できた金額',
                      trailing: controller.amountSavePrice.value.toString(),
                      color: ColorConstant.grey,
                      isFirst: false,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.graphList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final graph = controller.graphList[index];
                          return GraphListTile(
                            cellKey: controller.amountIdList[index],
                            onDismissed: (direction) =>
                                controller.deleteBloc(context, index),
                            onTap: () => controller.onTapDetail(index),
                            colorCode: graph.colorCode,
                            categoryName: graph.categoryName,
                            buyPrice: graph.buyPrice.toString(),
                            discountPrice: graph.discountPrice.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  AdmobBanner().myBannerAd,
                ],
              ),
      ),
    );
  }
}
