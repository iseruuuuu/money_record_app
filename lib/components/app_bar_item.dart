// Flutter imports:
import 'package:flutter/material.dart';
import 'package:money_records_app/constants/color_constant.dart';

class AppBarItem extends StatelessWidget with PreferredSizeWidget {
  const AppBarItem({
    Key? key,
    required this.title,
    required this.appBar,
  }) : super(key: key);

  final String title;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstant.appBarColor,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
