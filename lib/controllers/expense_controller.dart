/*
*
* Controller to hold expense business logic
*
*/

import 'package:intl/intl.dart';
import 'package:simple_expense_tracker/dao/expense_dao.dart';
import 'package:simple_expense_tracker/entities/expense.dart';
import 'package:simple_expense_tracker/services/db_connect.dart';

class ExpenseController {

  ExpenseDao expenseDao;

  ExpenseController(){
    final DBConnect dBConnect = DBConnect.db;
    this.expenseDao = ExpenseDao(dBConnect);
  }

  getTodaysExpenses() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String todaysDate = formatter.format(now);

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for(var i=0; i<expenses.length; i++){
      if(todaysDate == formatter.format(expenses[i].dateTime)){
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  getThisWeeksExpenses() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for(var i=0; i<expenses.length; i++){
      var difference = now.difference(expenses[i].dateTime);
      if(difference.inDays <= 7){
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  getThisMonthsExpenses() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for(var i=0; i<expenses.length; i++){
      if(expenses[i].dateTime.month == now.month && expenses[i].dateTime.year == now.year){
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  getThisYearsExpenses() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for(var i=0; i<expenses.length; i++){
      if(expenses[i].dateTime.year == now.year){
        amount += expenses[i].amount;
      }
    }

    return amount;
  }

  getAllTimeExpenses() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> expenses = await expenseDao.selectAll();
    for(var i=0; i<expenses.length; i++){
        amount += expenses[i].amount;
    }

    return amount;
  }

  newExpense(Expense expense) async {
    return await expenseDao.insert(expense);
  }

  getAllExpenses() async {
    return await expenseDao.selectAll();
  }

  editExpense(Expense expense) async {
    return await expenseDao.update(expense);
  }

  deleteExpense(Expense expense) async {
    return await expenseDao.delete(expense.id);
  }

  getAllExpenseCategories() async {
    List<Expense> expenses = await expenseDao.selectAll();
    List<String> categories;
    for(var i=0; i<expenses.length; i++){
      categories.add(expenses[i].category);
    }

    return categories;
  }

}