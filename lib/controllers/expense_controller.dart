/*
*
* Controller to hold expense business logic
*
*/

import 'package:simple_expense_tracker/dao/expense_dao.dart';
import 'package:simple_expense_tracker/services/db_connect.dart';

class ExpenseController {

  ExpenseDao expenseDao;

  ExpenseController(){
    final DBConnect dBConnect = DBConnect.db;
    this.expenseDao = ExpenseDao(dBConnect);
  }

}