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

  num getTodaysExpenses() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String todaysDate = formatter.format(now);

    num amount = 0.0;

//    List<Expense> expenses = await expenseDao.selectAll();
    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        if (todaysDate == formatter.format(expenses[i].dateTime)) {
          amount += expenses[i].amount;
        }
      }
    });

    return amount;
  }

  num getThisWeeksExpenses() {
    var now = new DateTime.now();

    num amount = 0.0;

    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        var difference = now.difference(expenses[i].dateTime);
        if (difference.inDays <= 7) {
          amount += expenses[i].amount;
        }
      }
    });

    return amount;
  }

  num getThisMonthsExpenses() {
    var now = new DateTime.now();

    num amount = 0.0;

    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        if (expenses[i].dateTime.month == now.month &&
            expenses[i].dateTime.year == now.year) {
          amount += expenses[i].amount;
        }
      }
    });

    return amount;
  }

  num getThisYearsExpenses() {
    var now = new DateTime.now();

    num amount = 0.0;

    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        if (expenses[i].dateTime.year == now.year) {
          amount += expenses[i].amount;
        }
      }
    });

    return amount;
  }

  num getAllTimeExpenses() {
    var now = new DateTime.now();

    num amount = 0.0;

    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        amount += expenses[i].amount;
      }
    });

    return amount;
  }

  Expense newExpense(Expense expense) {
    Expense newExpense;

    expenseDao.insert(expense).then((e) {
      newExpense = e;
    });
    return newExpense;
  }

  List<Expense> getAllExpenses() {
    List<Expense> expenses;

    expenseDao.selectAll().then((e) {
      expenses = e;
    });

    return expenses;
  }

  int editExpense(Expense expense) {
    int updateCount;

    expenseDao.update(expense).then((count) {
      updateCount = count;
    });

    return updateCount;
  }

  int deleteExpense(Expense expense) {
    int deleteCount;

    expenseDao.delete(expense.id).then((count) {
      deleteCount = count;
    });

    return deleteCount;
  }

  List<String> getAllExpenseCategories() {
    List<String> categories;

    expenseDao.selectAll().then((expenses) {
      for (var i = 0; i < expenses.length; i++) {
        categories.add(expenses[i].category);
      }
    });

    return categories;
  }
}
