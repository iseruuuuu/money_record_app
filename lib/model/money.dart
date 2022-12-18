import 'package:uuid/uuid.dart';

class Todo {
  String? id;
  int buyPrice;
  int discountPrice;
  String categoryName;
  DateTime createdDate;

  Todo({
    this.id,
    required this.buyPrice,
    required this.discountPrice,
    required this.categoryName,
    required this.createdDate,
  });

  assignUUID() {
    id = const Uuid().v4();
  }

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        buyPrice: json["buyPrice"],
        discountPrice: json["discountPrice"],
        categoryName: json["categoryName"],
        createdDate: DateTime.parse(json["createdDate"]).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "buyPrice": buyPrice,
        "discountPrice": discountPrice,
        "categoryName": categoryName,
        "createdDate": createdDate.toUtc().toIso8601String(),
      };
}
