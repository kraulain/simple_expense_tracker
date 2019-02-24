import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piggy/controllers/expense_controller.dart';
import 'package:piggy/entities/expense.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ExpenseController _expenseController = ExpenseController();
  var formatter = new DateFormat('dd-MM-yyyy');

  List<Expense> expenses = new List();

  @override
  void initState() {
    super.initState();

    _expenseController.getAllExpenses().then((expenses) {
      setState(() {
        this.expenses = expenses.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('All Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //show about app and help view
            },
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(child: Image(image: AssetImage("lib/assets/piggy.gif")))
          : ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 6.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Date: " +
                                    formatter.format(expenses[index].dateTime),
                                textAlign: TextAlign.left,
                              ),
                              Text("Amount: XAF " +
                                  expenses[index].amount.toString()),
                              Text("Category: " + expenses[index].category),
                              Text("Details: " + expenses[index].details),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.edit),
                            tooltip: 'Edit',
                            color: Colors.green[600],
                            onPressed: () {
                              //TODO: launch new expense route with current values
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            tooltip: 'Delete',
                            color: Colors.red,
                            onPressed: () {
                              _confirmDeleteDialog(expenses[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                  ],
                );
              },
            ),
    );
  }

  void _confirmDeleteDialog(Expense expense) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirm Delete Action"),
          content: new Text("Are you sure you want to delete this expense?" +
              "\nThis action is irreversible"),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text(
                'Yes, Delete',
                style: TextStyle(color: Colors.black),
              ),
              color: Colors.pink[500],
              onPressed: () {
                deleteExpense(expense);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void deleteExpense(Expense expense) {
    _expenseController.deleteExpense(expense).then((count) {
      _expenseController.getAllExpenses().then((expenses) {
        setState(() {
          this.expenses = expenses.reversed.toList();
        });
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('Expense deleted Succesfully'),
        backgroundColor: Colors.green[600],
      ));
    });
  }
}
