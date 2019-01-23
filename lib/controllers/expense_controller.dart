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

  todaysExpenses() async {
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

  thisWeeksExpenses() async {
    var now = new DateTime.now();

    num amount = 0.0;

    List<Expense> allExpenses = await expenseDao.selectAll();
    for(var i=0; i<allExpenses.length; i++){
      var difference = allExpenses[i].dateTime.difference(now);
      if(difference.inDays <= 7){
        amount += allExpenses[i].amount;
      }
    }

    return amount;
  }

}