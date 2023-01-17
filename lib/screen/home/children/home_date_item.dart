// Flutter imports:
import 'package:flutter/material.dart';

class HomeDateItem extends StatelessWidget {
  const HomeDateItem({
    Key? key,
    required this.createdTime,
    required this.onTap,
  }) : super(key: key);

  final String createdTime;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
        bottom: 50,
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF4A67AD)),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: Colors.white,
        leading: const Text(
          '日付',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          createdTime,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
