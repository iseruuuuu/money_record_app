// Dart imports:
import 'dart:core';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:money_records_app/database/db_provider.dart';
import 'package:money_records_app/model/money.dart';

class TodoBloc {
  TodoBloc() {
    getTodos();
  }

  final _todoController = BehaviorSubject<List<Todo>>();

  Stream<List<Todo>> get todoStream => _todoController.stream;

  Future<void> getTodos() async {
    _todoController.sink.add(await DBProvider.db.getAllTodos());
  }

  dispose() {
    _todoController.close();
  }

  void create(Todo todo) {
    todo.assignUUID();
    DBProvider.db.createTodo(todo);
    getTodos();
  }

  void update(Todo todo) {
    DBProvider.db.updateTodo(todo);
    getTodos();
  }

  void delete(String id) {
    DBProvider.db.deleteTodo(id);
    getTodos();
  }
}
