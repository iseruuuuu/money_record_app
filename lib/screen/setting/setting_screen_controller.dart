// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:money_records_app/constants/admob.dart';
import 'package:money_records_app/screen/setting/children/license_screen.dart';

class SettingScreenController extends GetxController {
  RxString version = ''.obs;
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
    loadVersion();
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

  Future<void> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  Future<void> onTapReview() async {
    await EasyLoading.show(status: 'loading....');
    await Future.delayed(const Duration(seconds: 2));
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await EasyLoading.dismiss();
      await inAppReview.requestReview();
    }
  }

  Future<void> onTapMail() async {
    final url = Uri.parse('https://forms.gle/rfnKQfemq4rwrjYr5');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> onTapTwitter() async {
    final url = Uri.parse('twitter://user?screen_name=isekiryu');
    final secondUrl = Uri.parse('https://twitter.com/isekiryu');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else if (await canLaunchUrl(secondUrl)) {
      await launchUrl(secondUrl);
    } else {
      openErrorDialog();
    }
  }

  void openErrorDialog() {
    PanaraInfoDialog.show(
      Get.context!,
      title: 'Error',
      message: "You can't open twitter link.\n"
          'Try again.',
      buttonText: 'OK',
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false,
      onTapDismiss: Get.back,
    );
  }

  void onTapLicense() {
    Get.to(const LicenseScreen());
  }

  Future<void> onTapGithub() async {
    final Uri url = Uri.parse('https://github.com/iseruuuuu');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void onTapShare() {
    Share.share('シェアをするよ');
  }
}
