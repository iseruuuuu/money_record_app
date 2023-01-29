// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';

// Project imports:


class DetailScreenController extends GetxController {
  var adContainer = Container().obs;
  final myBanner = BannerAd(
    adUnitId: Platform.isAndroid ? AdmobConstant.android : AdmobConstant.iOS,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
      },
    ),
  );

  @override
  void onInit() {
    super.onInit();
    loadAdmob();
  }

  void loadAdmob() {
    myBanner.load();
    final adWidget = AdWidget(ad: myBanner);
    adContainer.value = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(Get.context!).size.width,
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );
  }
}
