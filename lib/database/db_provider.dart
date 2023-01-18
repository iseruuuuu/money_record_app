// Package imports:
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Project imports:
import 'package:money_records_app/model/money.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static late Database todoDatabases;
  static const _tableName = 'Todo';

  Future<Database> get database async {
    return todoDatabases = await initDB();
  }

  Future<Database> initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'TodoDB.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future<void> _createTable(Database db, int version) async {
    return db.execute(
      'CREATE TABLE $_tableName ('
      'id TEXT PRIMARY KEY,'
      'buyPrice INTEGER,'
      'discountPrice INTEGER,'
      'categoryName TEXT,'
      'createdDate TEXT,'
      'colorCode INTEGER'
      ')',
    );
  }

  Future<int> createTodo(Todo todo) async {
    final db = await database;
    final res = await db.insert(_tableName, todo.toMap());
    return res;
  }

  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final todo = await db.query(
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

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    final res = await db.update(_tableName, todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
    return res;
  }

  Future<int> deleteTodo(String id) async {
    final db = await database;
    final res = db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
