/*
*
* Dao for persisting an expense
*
*/

import 'package:simple_expense_tracker/helpers/db_connect.dart';
import "../entities/expense.dart";

class ExpenseDao {

  DBConnect dbConnect;

  ExpenseDao(this.dbConnect);

  insert(Expense expense) async {
    final db = await dbConnect.database;
    var res = await db.insert("expense", expense.toJson());
    return res;
  }

  selectById(int id) async {
    final db = await dbConnect.database;
    var res =await  db.query("expense", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Expense.fromJson(res.first) : Null ;
  }

  selectAll() async {
    final db = await dbConnect.database;
    var res = await db.query("expense");
    List<Expense> list =
    res.isNotEmpty ? res.map((c) => Expense.fromJson(c)).toList() : [];
    return list;
  }

  update(Expense expense) async {
    final db = await dbConnect.database;
    var res = await db.update("expense", expense.toJson(),
        where: "id = ?", whereArgs: [expense.id]);
    return res;
  }

  delete(int id) async {
    final db = await dbConnect.database;
    db.delete("expense", where: "id = ?", whereArgs: [id]);
  }

}