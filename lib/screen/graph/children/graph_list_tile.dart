// Flutter imports:
import 'package:flutter/material.dart';

class GraphListTile extends StatelessWidget {
  const GraphListTile({
    Key? key,
    required this.cellKey,
    required this.onDismissed,
    required this.onTap,
    required this.colorCode,
    required this.categoryName,
    required this.buyPrice,
    required this.discountPrice,
  }) : super(key: key);

  final String cellKey;
  final Function(DismissDirection) onDismissed;
  final Function() onTap;
  final int colorCode;
  final String categoryName;
  final String buyPrice;
  final String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cellKey),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(right: 50),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: onDismissed,
      child: Card(
        child: ListTile(
          onTap: onTap,
          title: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                color: Color(colorCode),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 250,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 300,
                child: Text(
                  '$buyPrice円',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 300,
                child: Text(
                  '$discountPrice円',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
