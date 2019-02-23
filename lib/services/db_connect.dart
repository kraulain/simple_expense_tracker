import 'dart:io';

import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";

class DBConnect {

  static Database _database;

  DBConnect._();
  static final DBConnect db = DBConnect._();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ExpenseDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE expense ("
          "id INTEGER PRIMARY KEY,"
          "amount REAL,"
          "date_time INTEGER,"
          "category TEXT,"
          "details TEXT"
          ")");
    });
  }

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future close() async => db.close();

}