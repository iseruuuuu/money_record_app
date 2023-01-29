// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/constants/style_constant.dart';

class HomeSavePriceTextField extends StatelessWidget {
  const HomeSavePriceTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20, right: 20, left: 20),
      child: TextField(
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstant.appBarColor,
            ),
          ),
          labelText: '節約できた値段',
          labelStyle: StyleConstant.homeTextStyle,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
