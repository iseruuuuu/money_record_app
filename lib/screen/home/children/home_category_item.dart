// Flutter imports:
import 'package:flutter/material.dart';

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
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF4A67AD)),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: Colors.white,
        leading: const Text(
          'カテゴリー',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          maxLines: 1,
        ),
        trailing: Text(
          categoryName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
