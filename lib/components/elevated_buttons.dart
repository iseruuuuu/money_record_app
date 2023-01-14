// Flutter imports:
import 'package:flutter/material.dart';

class ElevatedButtons extends StatelessWidget {
  const ElevatedButtons({
    Key? key,
    required this.title,
    required this.isTap,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isTap ? Colors.white : const Color(0xFF4261AD),
        onPrimary: isTap ? Colors.white : const Color(0xFF4261AD),
        elevation: isTap ? 100 : 0,
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: isTap ? const Color(0xFFD18448) : Colors.white,
        ),
      ),
    );
  }
}
