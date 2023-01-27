// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Project imports:
import 'package:money_records_app/constants/admob.dart';
import 'package:money_records_app/preference/shared_preference.dart';

class CategoryScreenController extends GetxController {
  RxList<String> categoryList = [''].obs;
  RxString categoryName = ''.obs;
  RxInt color = 0.obs;
  var adContainer = Container().obs;
  final myBanner = BannerAd(
    adUnitId: Platform.isAndroid ? Admob.android : Admob.iOS,
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
    loadCategoryList();
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

  Future<void> loadCategoryList() async {
    categoryList.value =
        await Preference().getListString(PreferenceKey.categoryList);
  }

  void onChanged(String categoryNames) {
    categoryName.value = categoryNames;
  }

  Future<void> addList() async {
    if (categoryName.value != '') {
      final color = (Random().nextDouble() * 0xFFFFFF).toInt();
      final colorCode = '0xFF$color';
      await Preference().setString(categoryName.value, colorCode);
      categoryList.add(categoryName.value);
      await Preference()
          .setListString(PreferenceKey.categoryList, categoryList);
    }
  }

  void onTapBack(int index) {
    Get.back(result: categoryList[index]);
  }

  Future<void> deleteCategory(int index) async {
    categoryList.remove(categoryList[index]);
    await Preference().setListString(PreferenceKey.categoryList, categoryList);
  }
}
