import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_screen_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryScreenController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: const Text('カテゴリー編集'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Text',
                hintStyle: const TextStyle(fontSize: 18),
                suffixIcon: GestureDetector(
                    onTap: controller.addList,
                    child: const Icon(Icons.add, size: 25)),
                contentPadding: const EdgeInsets.only(top: 14, left: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              onChanged: (value) => controller.onChanged(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => controller.onTapBack(index),
                  title: Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('食費'),
                    ],
                  ),
                  trailing: const Icon(Icons.sort),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
