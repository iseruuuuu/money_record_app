// Package imports:
import 'package:uuid/uuid.dart';

class Money {
  Money({
    this.id,
    required this.buyPrice,
    required this.discountPrice,
    required this.categoryName,
    required this.createdDate,
    required this.colorCode,
  });

  factory Money.fromMap(Map<String, dynamic> json) => Money(
        id: json["id"],
        buyPrice: json["buyPrice"],
        discountPrice: json["discountPrice"],
        categoryName: json["categoryName"],
        createdDate: DateTime.parse(json["createdDate"]).toLocal(),
        colorCode: json["colorCode"],
      );

  String? id;
  int buyPrice;
  int discountPrice;
  String categoryName;
  DateTime createdDate;
  int colorCode;

  String? assignUUID() {
    return id = const Uuid().v4();
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'buyPrice': buyPrice,
        'discountPrice': discountPrice,
        'categoryName': categoryName,
        'createdDate': createdDate.toUtc().toIso8601String(),
        'colorCode': colorCode,
      };
}
