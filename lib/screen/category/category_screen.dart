// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/screen/category/category_screen_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: const Text('カテゴリー編集'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Text',
                hintStyle: const TextStyle(fontSize: 18),
                suffixIcon: IconButton(
                  onPressed: controller.addList,
                  icon: const Icon(Icons.add, size: 25),
                ),
                contentPadding: const EdgeInsets.only(top: 14, left: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              onChanged: controller.onChanged,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: controller.categoryList.isNotEmpty
                ? Obx(
                    () => ListView.builder(
                      itemCount: controller.categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final categoryList = controller.categoryList;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            child: ListTile(
                              onTap: () => controller.onTapBack(index),
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        controller.deleteCategory(index),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                      categoryList[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
