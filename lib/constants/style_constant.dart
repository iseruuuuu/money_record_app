// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/color_constant.dart';

class StyleConstant {
  static TextStyle appbarTextStyle = TextStyle(
    color: ColorConstant.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle homeStoreButton = TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorConstant.white,
    fontSize: 18,
  );

  static ButtonStyle homeButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: ColorConstant.white,
    backgroundColor: ColorConstant.appBarColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );

  static TextStyle homeTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: ColorConstant.grey,
  );

  static TextStyle alreadyTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: ColorConstant.black,
  );

  static ShapeBorder homeBorder = RoundedRectangleBorder(
    side: const BorderSide(color: Color(0xFF4A67AD)),
    borderRadius: BorderRadius.circular(5),
  );

  static TextStyle emptyTextStyle = TextStyle(
    color: ColorConstant.black,
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );

  static BorderSide graphBorder = BorderSide(
    width: 2,
    color: ColorConstant.appBarColor,
  );

  static TextStyle blackTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: ColorConstant.black,
  );

  static TextStyle greyTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: ColorConstant.grey,
  );
}
