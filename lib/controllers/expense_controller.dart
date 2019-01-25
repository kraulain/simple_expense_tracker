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

  expensesToday() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String todaysDate = formatter.format(now);

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
      if(todaysDate == formatter.format(allExpenses[i].dateTime)){
        amount += allExpenses[i].amount;
      }
    }

    return amount;
  }

  expensesThisWeek() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
      var difference = now.difference(allExpenses[i].dateTime);
      if(difference.inDays <= 7){
        amount += allExpenses[i].amount;
      }
    }

    return amount;
  }

  expensesThisMonth() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
      if(allExpenses[i].dateTime.month == now.month && allExpenses[i].dateTime.year == now.year){
        amount += allExpenses[i].amount;
      }
    }

    return amount;
  }

  expensesThisYear() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
      if(allExpenses[i].dateTime.year == now.year){
        amount += allExpenses[i].amount;
      }
    }

    return amount;
  }

  expensesAllTime() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
        amount += allExpenses[i].amount;
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
    List<Expense> allExpenses = await expenseDao.selectAll();
    List<String> categories;
    for(var i=0; i<allExpenses.length; i++){
      categories.add(allExpenses[i].category);
    }

    return categories;
  }

}