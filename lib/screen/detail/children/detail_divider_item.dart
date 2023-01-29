// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/color_constant.dart';

class DetailDividerItem extends StatelessWidget {
  const DetailDividerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 3,
      color: ColorConstant.appBarColor,
    );
  }
}
