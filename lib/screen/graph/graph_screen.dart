// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_records_app/screen/graph/children/graph_item.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Project imports:
import 'package:money_records_app/screen/graph/children/graph_list_tile.dart';
import 'package:money_records_app/model/chart_data.dart';
import 'package:money_records_app/screen/graph/children/graph_empty_screen.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myBanner = BannerAd(
      adUnitId: Platform.isAndroid
          //android
          ? 'ca-app-pub-3940256099942544/6300978111'
          //ios
          : 'ca-app-pub-3471170179614589/7242925577',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );

    myBanner.load();
    final adWidget = AdWidget(ad: myBanner);
    final adContainer = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );

    final controller = Get.put(GraphScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
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
      body: Obx(
        () => controller.amountCategoryList.isEmpty
            ? const GraphEmptyScreen()
            : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFFF2F2F7),
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
                      color: Colors.black,
                      isFirst: true,
                    ),
                  ),
                  Obx(
                    () => GraphItem(
                      leading: '節約できた金額',
                      trailing: controller.amountSavePrice.value.toString(),
                      color: Colors.grey,
                      isFirst: false,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.listLength.value,
                        itemBuilder: (BuildContext context, int index) {
                          return GraphListTile(
                            cellKey: controller.amountIdList[index],
                            onDismissed: (direction) =>
                                controller.deleteBloc(context, index),
                            onTap: () => controller.onTapDetail(index),
                            colorCode: controller.amountColorCodeList[index],
                            categoryName: controller.amountCategoryList[index],
                            buyPrice:
                                controller.amountBuyList[index].toString(),
                            discountPrice: controller
                                .amountDiscountPriceList[index]
                                .toString(),
                          );
                        },
                      ),
                    ),
                  ),
                  adContainer,
                ],
              ),
      ),
    );
  }
}
