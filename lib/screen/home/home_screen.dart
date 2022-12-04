import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_records_app/components/elevated_buttons.dart';
import 'home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A67AD),
        elevation: 0,
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.5,
                child: ElevatedButtons(
                  title: '収支',
                  isTap: !controller.isIncome.value,
                  onTap: () => controller.changeIncome(false),
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.5,
                child: ElevatedButtons(
                  title: '収入',
                  isTap: controller.isIncome.value,
                  onTap: () => controller.changeIncome(true),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 2),
                child: TextField(
                  onChanged: (value) => controller.changeDiscountPrice(value),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: '値引きの金額',
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextField(
                  onChanged: (value) => controller.changeBuyPrice(value),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: '購入金額',
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: const Text('カテゴリー'),
                    trailing: Text(controller.categoryName.value),
                    onTap: () => controller.changeCategory(),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(bottom: 42),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: const Text('日付'),
                    trailing: Text(controller.createdDate.value),
                    onTap: () => controller.changeDateTime(),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF4A67AD),
                    onPrimary: const Color(0xFF4A67AD),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //TODO 保存する処理を記載する。
                  },
                  child: const Text(
                    '保存',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
