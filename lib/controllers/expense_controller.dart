/*
*
* Controller to hold expense business logic
*
*/

import 'package:intl/intl.dart';
import 'package:piggy/dao/expense_dao.dart';
import 'package:piggy/entities/expense.dart';
import 'package:piggy/services/db_connect.dart';

class ExpenseController {
  ExpenseDao expenseDao;

  ExpenseController() {
    final DBConnect dBConnect = DBConnect.db;
    this.expenseDao = ExpenseDao(dBConnect);
  }

  Future<num> getTodaysExpenses() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String todaysDate = formatter.format(now);

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for (var i = 0; i < expenses.length; i++) {
      if (todaysDate == formatter.format(expenses[i].dateTime)) {
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  Future<num> getThisWeeksExpenses() async{
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for (var i = 0; i < expenses.length; i++) {
      var difference = now.difference(expenses[i].dateTime);
      if (difference.inDays <= 7) {
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  Future<num> getThisMonthsExpenses() async{
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i].dateTime.month == now.month &&
          expenses[i].dateTime.year == now.year) {
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  Future<num> getThisYearsExpenses() async{
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
      for (var i = 0; i < expenses.length; i++) {
        if (expenses[i].dateTime.year == now.year) {
          amount += expenses[i].amount;
        }
      }

    return amount;
  }

  Future<num> getAllTimeExpenses() async{
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
      for (var i = 0; i < expenses.length; i++) {
        amount += expenses[i].amount;
      }

    return amount;
  }

  Future<Expense> newExpense(Expense expense) async{
    Expense newExpense = await expenseDao.insert(expense);
    return newExpense;
  }

  Future<List<Expense>> getAllExpenses() async{
    List<Expense> expenses = await expenseDao.selectAll();
    return expenses;
  }

  Future<int> editExpense(Expense expense) async{
    int updateCount = await expenseDao.update(expense);
    return updateCount;
  }

  Future<int> deleteExpense(Expense expense) async{
    int deleteCount = await expenseDao.delete(expense.id);
    return deleteCount;
  }

  Future<List<String>> getAllExpenseCategories() async{
    List<String> categories;

    List<Expense> expenses = await expenseDao.selectAll();
      for (var i = 0; i < expenses.length; i++) {
        categories.add(expenses[i].category);
      }
    return categories;
  }

}
