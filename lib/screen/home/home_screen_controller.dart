// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

// Project imports:
import 'package:money_records_app/constants/admob_constant.dart';
import 'package:money_records_app/database/db_bloc.dart';
import 'package:money_records_app/model/money.dart';
import 'package:money_records_app/preference/shared_preference.dart';
import 'package:money_records_app/screen/category/category_screen.dart';

class HomeScreenController extends GetxController {
  RxBool isIncome = false.obs;
  RxInt discountPrice = 0.obs;
  RxInt buyPrice = 0.obs;
  RxString categoryName = ''.obs;
  RxString createdDate = ''.obs;
  late DateTime createdDates;
  RxList<String> categoryList = [''].obs;
  RxInt colorCode = 0.obs;
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
    loadAppTracking();
    final now = DateTime.now();
    createdDate.value = DateFormat('yyyy年M月d日').format(now);
    createdDates = now;
    loadAdmob();
  }

  Future<void> loadAppTracking() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
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

  void changeIncome({required bool isIncomes}) {
    isIncome.value = isIncomes;
  }

  void changeDiscountPrice(String discountPrices) {
    discountPrice.value = int.parse(discountPrices);
  }

  void changeBuyPrice(String buyPrices) {
    buyPrice.value = int.parse(buyPrices);
  }

  Future<void> changeCategory(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final result = await Get.to(() => const CategoryScreen());
    if (result != null) {
      categoryName.value = result.toString();
      final color = await Preference().getString(categoryName.value);
      colorCode.value = int.parse(color);
    }
  }

  Future<void> changeDateTime(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final date = DateTime.now();
    final picked = await showDatePicker(
        context: Get.context!,
        initialDate: date,
        firstDate: DateTime(2016),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      createdDate.value = DateFormat('yyyy年M月d日').format(picked);
      createdDates = picked;
    }
  }

  void onTapStore() {
    if (buyPrice.value != 0 &&
        discountPrice.value != 0 &&
        categoryName.value != '') {
      final newMoney = Money(
        buyPrice: buyPrice.value,
        discountPrice: discountPrice.value,
        categoryName: categoryName.value,
        createdDate: createdDates,
        colorCode: colorCode.value,
      );
      Bloc().create(newMoney);
      openDialog(isError: false);
    } else {
      openDialog(isError: true);
    }
  }

  void openDialog({required bool isError}) {
    PanaraInfoDialog.show(
      Get.context!,
      title: isError ? 'Error' : 'Success',
      message: isError
          ? 'One of them is empty.\n'
              'Please check and Try again.'
          : 'You can post contents.\n'
              'please check it.',
      buttonText: 'OK',
      panaraDialogType:
          isError ? PanaraDialogType.error : PanaraDialogType.success,
      barrierDismissible: false,
      onTapDismiss: Get.back,
    );
  }
}
