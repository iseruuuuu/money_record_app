// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';

// Project imports:
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/screen/setting/setting_screen_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBarItem(
        appBar: AppBar(),
        title: '設定',
      ),
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              lightTheme: const SettingsThemeData(
                settingsListBackground: Color(0xFFF2F2F7),
                settingsSectionBackground: Colors.white,
              ),
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      title: const Text('レビューを書く'),
                      onPressed: (context) => controller.onTapReview(),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.mail,
                        color: Colors.lightBlue,
                      ),
                      title: const Text('お問い合わせ'),
                      onPressed: (context) => controller.onTapMail(),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        AntDesign.twitter,
                        color: Colors.blue,
                      ),
                      title: const Text('開発者'),
                      onPressed: (context) => controller.onTapTwitter(),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.local_police,
                        color: Colors.grey,
                      ),
                      title: const Text('ライセンス'),
                      onPressed: (context) => controller.onTapLicense(),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        MaterialCommunityIcons.github,
                        color: Colors.black,
                      ),
                      title: const Text('Github'),
                      onPressed: (context) => controller.onTapGithub(),
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        AntDesign.sharealt,
                        color: Colors.black,
                      ),
                      title: const Text('友達に教える'),
                      onPressed: (context) => controller.onTapShare(),
                    ),
                    SettingsTile.navigation(
                      title: const Text('バージョン'),
                      trailing: Obx(
                        () => Text(controller.version.value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          controller.adContainer.value,
        ],
      ),
    );
  }
}
