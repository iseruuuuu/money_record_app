// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/constants/style_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';

class GraphListTile extends StatelessWidget {
  const GraphListTile({
    Key? key,
    required this.cellKey,
    required this.onDismissed,
    required this.onTap,
    required this.colorCode,
    required this.categoryName,
    required this.buyPrice,
    required this.discountPrice,
  }) : super(key: key);

  final String cellKey;
  final Function(DismissDirection) onDismissed;
  final Function() onTap;
  final int colorCode;
  final String categoryName;
  final String buyPrice;
  final String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cellKey),
      background: Container(
        alignment: Alignment.centerRight,
        color: ColorConstant.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Icon(
            Icons.delete,
            color: ColorConstant.white,
          ),
        ),
      ),
      onDismissed: onDismissed,
      child: Card(
        child: ListTile(
          onTap: onTap,
          title: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                color: Color(colorCode),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: context.screenWidth - 250,
                child: Text(
                  categoryName,
                  style: StyleConstant.blackTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: context.screenWidth - 300,
                child: Text(
                  '$buyPrice円',
                  style: StyleConstant.blackTextStyle,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: context.screenWidth - 300,
                child: Text(
                  '$discountPrice円',
                  style: StyleConstant.greyTextStyle,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
