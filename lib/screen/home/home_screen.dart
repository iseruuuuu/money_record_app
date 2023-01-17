// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
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
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: const Text(
          '収支記録',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            HomeSavePriceTextField(onChanged: controller.changeDiscountPrice),
            HomeBuyPriceTextField(onChanged: controller.changeBuyPrice),
            Obx(
              () => HomeCategoryItem(
                categoryName: controller.categoryName.value,
                onTap: controller.changeCategory,
              ),
            ),
            Obx(
              () => HomeDateItem(
                createdTime: controller.createdDate.value,
                onTap: controller.changeDateTime,
              ),
            ),
            HomeButton(onPressed: controller.onTapStore),
            const Spacer(),
            adContainer,
          ],
        ),
      ),
    );
  }
}
