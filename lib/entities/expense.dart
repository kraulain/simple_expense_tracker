/*
*
* Entity representing an expense
*
*/

class Expense {

  int id;
  num amount;
  DateTime dateTime;
  String reason;

  Expense({this.id = 0, this.amount, this.dateTime, this.reason});
}