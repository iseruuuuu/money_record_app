import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:money_records_app/screen/setting/children/license_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
    //TODO アプリないレビューをできるか確認する
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
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
      // 最初のURLが開けなかった場合かつセカンドURLが有って開けた場合
      await launch(secondUrl);
    } else {
      // 任意のエラー処理
    }
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
    //TODO あとでAppleStoreのリンクを設定する。
    Share.share('シェアをするよ');
  }
}
