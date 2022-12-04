import 'package:flutter/material.dart';

class ElevatedButtons extends StatelessWidget {
  const ElevatedButtons({
    Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
    required this.isTap,
  }) : super(key: key);

  final Color backgroundColor;
  final Color textColor;
  final String title;
  final bool isTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: backgroundColor,
        elevation: isTap ? 100 : 0,
      ),
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
