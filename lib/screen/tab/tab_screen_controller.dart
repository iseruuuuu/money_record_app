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

    final newVersion = NewVersion(
      androidId: '',
      iOSId: 'com.moneyRecordsApp',
      iOSAppStoreCountry: 'JP', //AppStoreの登録している国コード(日本の場合JP)
    );

    newVersion.showAlertIfNecessary(context: Get.context!);
  }

  void onTap(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 1) {
      final controller = Get.put(GraphScreenController());
      controller.loadInit();
    }
  }
}
