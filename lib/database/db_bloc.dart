// Dart imports:
import 'dart:core';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/money.dart';

class Bloc {
  Bloc() {
    getMoneys();
  }

  final _controller = BehaviorSubject<List<Money>>();

  Stream<List<Money>> get stream => _controller.stream;

  Future<void> getMoneys() async {
    _controller.sink.add(await DBProvider.db.getAllMoneys());
  }

  dispose() {
    _controller.close();
  }

  void create(Money money) {
    money.assignUUID();
    DBProvider.db.createMoney(money);
    getMoneys();
  }

  void update(Money money) {
    DBProvider.db.updateMoney(money);
    getMoneys();
  }

  void delete(String id) {
    DBProvider.db.deleteMoney(id);
    getMoneys();
  }
}
