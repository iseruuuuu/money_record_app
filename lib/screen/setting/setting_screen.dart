// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:money_records_app/constants/color_constant.dart';
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
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBarItem(
        appBar: AppBar(),
        title: '設定',
      ),
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              lightTheme: SettingsThemeData(
                settingsListBackground: ColorConstant.settingsListBackground,
                settingsSectionBackground:
                    ColorConstant.settingsSectionBackground,
              ),
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile.navigation(
                      leading: Icon(
                        Icons.star,
                        color: ColorConstant.yellow,
                      ),
                      title: const Text('レビューを書く'),
                      onPressed: (context) => controller.onTapReview(),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(
                        Icons.mail,
                        color: ColorConstant.lightBlue,
                      ),
                      title: const Text('お問い合わせ'),
                      onPressed: (context) => controller.onTapMail(),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(
                        AntDesign.twitter,
                        color: ColorConstant.blue,
                      ),
                      title: const Text('開発者'),
                      onPressed: (context) => controller.onTapTwitter(),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(
                        Icons.local_police,
                        color: ColorConstant.grey,
                      ),
                      title: const Text('ライセンス'),
                      onPressed: (context) => controller.onTapLicense(),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(
                        MaterialCommunityIcons.github,
                        color: ColorConstant.black,
                      ),
                      title: const Text('Github'),
                      onPressed: (context) => controller.onTapGithub(),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(
                        AntDesign.sharealt,
                        color: ColorConstant.black,
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
