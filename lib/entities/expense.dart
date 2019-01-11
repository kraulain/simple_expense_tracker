/*
*
* Entity representing an expense
*
*/

import 'dart:convert';

Expense expenseFromJson(String str) {
  final jsonData = json.decode(str);
  return Expense.fromJson(jsonData);
}

String expenseToJson(Expense data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


class Expense {

  int id;
  num amount;
  DateTime dateTime;
  String reason;

  Expense({this.id = 0, this.amount, this.dateTime, this.reason});

  factory Expense.fromJson(Map<String, dynamic> json) => new Expense(
    id: json["id"],
    amount: json["amount"],
    dateTime: json["date_time"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "date_time": dateTime,
    "reason": reason,
  };
}