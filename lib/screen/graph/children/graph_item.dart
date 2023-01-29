// Flutter imports:
import 'package:flutter/material.dart';
import 'package:money_records_app/constants/color_constant.dart';

class GraphItem extends StatelessWidget {
  const GraphItem({
    Key? key,
    required this.leading,
    required this.trailing,
    required this.color,
    required this.isFirst,
  }) : super(key: key);

  final String leading;
  final String trailing;
  final Color color;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorConstant.white,
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: ColorConstant.appBarColor,
          ),
          top: isFirst
              ? BorderSide(
                  width: 2,
                  color: ColorConstant.appBarColor,
                )
              : BorderSide.none,
        ),
      ),
      child: ListTile(
        leading: Text(
          leading,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        trailing: Text(
          '$trailing円',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: color,
          ),
        ),
      ),
    );
  }
}
