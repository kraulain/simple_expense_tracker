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
  int dateTimeMillis;
  String category;
  String details;
  DateTime dateTime;

  Expense({this.id = 0, this.amount, this.dateTimeMillis, this.category, this.details, this.dateTime}){
    if(this.dateTimeMillis != null){
      this.dateTime = convertMillisecondsToDateTime(dateTimeMillis);
    }else if (this.dateTime != null){
      this.dateTimeMillis = convertDateTimeToMilliseconds(dateTime);
    }
  }

  factory Expense.fromJson(Map<String, dynamic> json) => new Expense(
    id: json["id"],
    amount: json["amount"],
    dateTimeMillis: json["date_time"],
    details: json["details"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "date_time": dateTimeMillis,
    "details": details,
    "category": category,
  };

  int convertDateTimeToMilliseconds(DateTime dateTime){
    return dateTime.millisecondsSinceEpoch;
  }

  DateTime convertMillisecondsToDateTime(int millis) {
    return new DateTime.fromMillisecondsSinceEpoch(millis);
  }
}