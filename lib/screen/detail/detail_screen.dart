// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/admob/admob.dart';
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/constants/style_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';
import 'package:money_records_app/screen/detail/children/detail_divider_item.dart';

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
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: AppBarItem(
          appBar: AppBar(),
          title: '',
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(
                '支払った金額',
                style: StyleConstant.alreadyTextStyle,
              ),
              trailing: SizedBox(
                width: context.screenWidth - 200,
                child: Text(
                  '$buyPrice円',
                  style: StyleConstant.blackTextStyle,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: Text(
                '節約できた金額',
                style: StyleConstant.alreadyTextStyle,
              ),
              trailing: SizedBox(
                width: context.screenWidth - 200,
                child: Text(
                  '$discountPrice円',
                  style: StyleConstant.greyTextStyle,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: Text(
                '種類',
                style: StyleConstant.alreadyTextStyle,
              ),
              trailing: SizedBox(
                width: context.screenWidth - 120,
                child: Text(
                  category,
                  style: StyleConstant.blackTextStyle,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const DetailDividerItem(),
            ListTile(
              title: Text(
                '日付',
                style: StyleConstant.alreadyTextStyle,
              ),
              trailing: Text(
                '${createdDate.year}年${createdDate.month}月${createdDate.day}日',
                style: StyleConstant.blackTextStyle,
              ),
            ),
            const DetailDividerItem(),
            const Spacer(),
            GoogleAdInfo().myBannerAd,
          ],
        ),
      ),
    );
  }
}
