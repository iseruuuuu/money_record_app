import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.id,
    required this.discountPrice,
    required this.buyPrice,
    required this.category,
    required this.createdDate,
  }) : super(key: key);

  final String id;
  final int discountPrice;
  final int buyPrice;
  final String category;
  final DateTime createdDate;

  //TODO デザインを修正する
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('節約できた金額'),
            trailing: Text('$discountPrice円'),
          ),
          ListTile(
            title: const Text('支払った金額'),
            trailing: Text('$buyPrice円'),
          ),
          ListTile(
            title: const Text('種類'),
            trailing: Text(category),
          ),
          ListTile(
            title: const Text('日付'),
            trailing: Text(createdDate.toString()),
          ),
        ],
      ),
    );
  }
}
