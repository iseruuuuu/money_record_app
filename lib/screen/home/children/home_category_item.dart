// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/style_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({
    Key? key,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  final String categoryName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        onTap: onTap,
        shape: StyleConstant.homeBorder,
        tileColor: Colors.white,
        leading: Text(
          'カテゴリー',
          style: StyleConstant.homeTextStyle,
          maxLines: 1,
        ),
        trailing: SizedBox(
          width: context.screenWidth - 160,
          child: Text(
            categoryName,
            style: StyleConstant.alreadyTextStyle,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
