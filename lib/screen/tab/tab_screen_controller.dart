// Package imports:
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';

// Project imports:
import 'package:money_records_app/screen/graph/graph_screen_controller.dart';

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
    if (status != null && status.canUpdate) {
      String storeVersion = status.storeVersion;
      newVersion.showUpdateDialog(
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'アップデートが必要です',
        dialogText: 'Ver.$storeVersionが公開されています。\n最新バージョンのアップデートをお願いします。',
        updateButtonText: 'アップデート',
        allowDismissal: false,
      );
    }
  }

  void onTap(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 1) {
      final controller = Get.put(GraphScreenController());
      controller.loadInit();
    }
  }
}
