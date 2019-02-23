/*
*
* Dao for persisting an expense
*
*/

import 'package:piggy/services/db_connect.dart';
import "package:piggy/entities/expense.dart";

class ExpenseDao {
  DBConnect dbConnect;

  ExpenseDao(this.dbConnect);

  Future<Expense> insert(Expense expense) async {
    final db = await dbConnect.database;
    expense.id = await db.insert("expense", expense.toJson());
    return expense;
  }

  Future<Expense> selectById(int id) async {
    final db = await dbConnect.database;
    var res = await db.query("expense", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Expense.fromJson(res.first) : Null;
  }

  Future<List<Expense>> selectAll() async {
    final db = await dbConnect.database;
    var res = await db.query("expense");
    List<Expense> list =
        res.isNotEmpty ? res.map((c) => Expense.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> update(Expense expense) async {
    final db = await dbConnect.database;
    var res = await db.update("expense", expense.toJson(),
        where: "id = ?", whereArgs: [expense.id]);
    return res;
  }

  Future<int> delete(int id) async {
    final db = await dbConnect.database;
    db.delete("expense", where: "id = ?", whereArgs: [id]);
  }

}
