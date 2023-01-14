// Dart imports:
import 'dart:io';

// Package imports:
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Project imports:
import 'package:money_records_app/model/money.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static late Database _database;
  static const _tableName = "Todo";

  Future<Database> get database async {
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TodoDB.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    return await db.execute(
      "CREATE TABLE $_tableName ("
      "id TEXT PRIMARY KEY,"
      "buyPrice INTEGER,"
      "discountPrice INTEGER,"
      "categoryName TEXT,"
      "createdDate TEXT,"
      "colorCode INTEGER"
      ")",
    );
  }

  createTodo(Todo todo) async {
    final db = await database;
    var res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  getAllTodos() async {
    final db = await database;
    var todo = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );
    List<Todo> list =
        todo.isNotEmpty ? todo.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    var todo = await db.query(
      _tableName,
      orderBy: 'id DESC',
    );
    List<Todo> list =
    todo.isNotEmpty ? todo.map((c) => Todo.fromMap(c)).toList() : [];
    return list;
  }

  updateTodo(Todo todo) async {
    final db = await database;
    var res = await db.update(_tableName, todo.toMap(),
        where: "id = ?", whereArgs: [todo.id]);
    return res;
  }

  deleteTodo(String id) async {
    final db = await database;
    var res = db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
