import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_records_app/screen/setting/setting_screen_controller.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: const Text(
          '設定',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      title: const Text('レビューを書く'),
                      onPressed: (context) => controller.onTapReview,
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
        ],
      ),
    );
  }
}
