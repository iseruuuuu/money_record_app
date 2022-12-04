import 'package:flutter/material.dart';

class GraphListTile extends StatelessWidget {
  const GraphListTile({
    Key? key,
    required this.leading,
    required this.trailing,
  }) : super(key: key);

  final String leading;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Color(0xFF4A67AD)),
        ),
      ),
      child: ListTile(
        leading: Text(
          leading,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing: Text(
          '$trailing円',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
