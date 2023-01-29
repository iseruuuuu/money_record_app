// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/text_style_constant.dart';

class HomeDateItem extends StatelessWidget {
  const HomeDateItem({
    Key? key,
    required this.createdTime,
    required this.onTap,
  }) : super(key: key);

  final String createdTime;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 50),
      child: ListTile(
        onTap: onTap,
        shape: StyleConstant.homeBorder,
        tileColor: Colors.white,
        leading: Text(
          '日付',
          style: StyleConstant.homeTextStyle,
        ),
        trailing: Text(
          createdTime,
          style: StyleConstant.alreadyTextStyle,
        ),
      ),
    );
  }
}
