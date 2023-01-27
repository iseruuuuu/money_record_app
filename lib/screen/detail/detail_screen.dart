// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/screen/detail/children/detail_divider_item.dart';
import 'package:money_records_app/screen/detail/detail_screen_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.discountPrice,
    required this.buyPrice,
    required this.category,
    required this.createdDate,
  }) : super(key: key);

  final int discountPrice;
  final int buyPrice;
  final String category;
  final DateTime createdDate;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailScreenController());
    final deviceSize = MediaQuery.of(context).size.width;
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F7),
        appBar: AppBarItem(
          appBar: AppBar(),
          title: '',
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text(
                '支払った金額',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 200,
                child: Text(
                  '$buyPrice円',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '節約できた金額',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 200,
                child: Text(
                  '$discountPrice円',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '種類',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: SizedBox(
                width: deviceSize - 120,
                child: Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: const Text(
                '日付',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: Text(
                '${createdDate.year}年${createdDate.month}月${createdDate.day}日',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const DetailDividerItem(),
            const Spacer(),
            controller.adContainer.value,
          ],
        ),
      ),
    );
  }
}
