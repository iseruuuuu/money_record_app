// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/text_style_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth - 100,
      height: 50,
      child: ElevatedButton(
        style: StyleConstant.homeButtonStyle,
        onPressed: onPressed,
        child: Text(
          '保存',
          style: StyleConstant.homeStoreButton,
        ),
      ),
    );
  }
}
