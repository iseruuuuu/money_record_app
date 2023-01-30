// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/admob/admob_banner.dart';
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/screen/home/children/home_button.dart';
import 'package:money_records_app/screen/home/children/home_buy_price_text_field.dart';
import 'package:money_records_app/screen/home/children/home_category_item.dart';
import 'package:money_records_app/screen/home/children/home_date_item.dart';
import 'package:money_records_app/screen/home/children/home_save_price_text_field.dart';
import 'package:money_records_app/screen/home/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBarItem(
        appBar: AppBar(),
        title: '収支記録',
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            HomeSavePriceTextField(onChanged: controller.changeDiscountPrice),
            HomeBuyPriceTextField(onChanged: controller.changeBuyPrice),
            Obx(
              () => HomeCategoryItem(
                categoryName: controller.categoryName.value,
                onTap: () => controller.changeCategory(context),
              ),
            ),
            Obx(
              () => HomeDateItem(
                createdTime: controller.createdDate.value,
                onTap: () => controller.changeDateTime(context),
              ),
            ),
            HomeButton(onPressed: controller.onTapStore),
            const Spacer(),
            AdmobBanner().myBannerAd,
          ],
        ),
      ),
    );
  }
}
