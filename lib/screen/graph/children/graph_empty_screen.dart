// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:money_records_app/constants/style_constant.dart';

class GraphEmptyScreen extends StatelessWidget {
  const GraphEmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            '入力画面で追加をしてください',
            style: StyleConstant.emptyTextStyle,
          ),
          const SizedBox(height: 15),
          const Icon(Icons.maps_ugc_outlined, size: 90),
          const Spacer(),
        ],
      ),
    );
  }
}
