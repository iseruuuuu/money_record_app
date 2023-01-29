// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:money_records_app/admob/admob.dart';
import 'package:money_records_app/components/app_bar_item.dart';
import 'package:money_records_app/constants/color_constant.dart';
import 'package:money_records_app/constants/style_constant.dart';
import 'package:money_records_app/extension/deviceSize.dart';
import 'package:money_records_app/screen/category/category_screen_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryScreenController());
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: AppBarItem(
          appBar: AppBar(),
          title: 'カテゴリー編集',
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
                width: context.screenWidth,
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
              Obx(
                () => Expanded(
                  child: controller.categoryList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final categoryList = controller.categoryList;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Card(
                                child: ListTile(
                                  onTap: () => controller.onTapBack(index),
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            controller.deleteCategory(index),
                                        icon: Icon(
                                          Icons.delete,
                                          color: ColorConstant.red,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.screenWidth - 100,
                                        child: Text(
                                          categoryList[index],
                                          style: StyleConstant.blackTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ),
              ),
              const Spacer(),
              GoogleAdInfo().myBannerAd,
            ],
          ),
        ),
      ),
    );
  }
}
