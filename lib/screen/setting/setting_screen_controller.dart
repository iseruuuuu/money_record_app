// Package imports:
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:money_records_app/screen/setting/children/license_screen.dart';

class SettingScreenController extends GetxController {
  RxString version = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadVersion();
  }

  void loadVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }

  void onTapReview() async {
    EasyLoading.show(status: 'loading....');
    await Future.delayed(const Duration(seconds: 2));
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      EasyLoading.dismiss();
      inAppReview.requestReview();
    }
  }

  Future<void> onTapMail() async {
    final Uri url = Uri.parse('https://forms.gle/rfnKQfemq4rwrjYr5');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> onTapTwitter() async {
    const url = 'twitter://user?screen_name=isekiryu';
    const secondUrl = 'https://twitter.com/isekiryu';
    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(secondUrl)) {
      await launch(secondUrl);
    } else {
      openErrorDialog();
    }
  }

  void openErrorDialog() {
    PanaraInfoDialog.show(
      Get.context!,
      title: "Error",
      message: "You can't open twitter link.\n"
          "Try again.",
      buttonText: "OK",
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false,
      onTapDismiss: () {
        Get.back();
      },
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
