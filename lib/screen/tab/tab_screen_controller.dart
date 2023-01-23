// Package imports:
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';

// Project imports:
import 'package:money_records_app/screen/calendar/calendar_screen_controller.dart';
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TabScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    checkUpdate();
  }

  void checkUpdate() async {
    final newVersion = NewVersion(
      iOSId: 'com.moneyRecordsApp',
      iOSAppStoreCountry: 'JP',
    );
    final status = await newVersion.getVersionStatus();
    final packageInfo = await PackageInfo.fromPlatform();
    if (status != null && status.storeVersion != packageInfo.buildNumber) {
      String storeVersion = status.storeVersion;
      newVersion.showUpdateDialog(
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'アップデートが必要です',
        dialogText: 'Ver.$storeVersionが公開されています。\n最新バージョンのアップデートをお願いします。',
        updateButtonText: 'アップデート',
        dismissButtonText: 'あとで',
      );
    }
  }

  void onTap(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 1) {
      final controller = Get.put(GraphScreenController());
      controller.loadInit();
    } else if (selectedIndex.value == 2) {
      final controller = Get.put(CalendarScreenController());
      final now = DateTime.now();
      controller.loadSelectDate(now);
    }
  }
}
