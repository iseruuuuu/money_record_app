import 'package:flutter/material.dart';
import 'package:money_records_app/model/money.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

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
            trailing: Text('${todo.discountPrice}円'),
          ),
          ListTile(
            title: const Text('支払った金額'),
            trailing: Text('${todo.discountPrice}円'),
          ),
          ListTile(
            title: const Text('種類'),
            trailing: Text(todo.category),
          ),
          ListTile(
            title: const Text('日付'),
            trailing: Text(todo.createdDate.toString()),
          ),
        ],
      ),
    );
  }
}
