import 'package:flutter/material.dart';
import 'package:piggy/controllers/expense_controller.dart';
import 'package:piggy/entities/expense.dart';

class NewExpensePage extends StatefulWidget {
  NewExpensePage({Key key}) : super(key: key);

  @override
  _NewExpensePageState createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  ExpenseController _expenseController = ExpenseController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('New Expense'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //show about app and help view
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter the amount spent',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category',
                hintText: 'Ex: Transport, Telephone, Rent ',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              maxLines: 5,
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: 'Details',
                hintText: 'Detailed description of what you spent on.',
              ),
            ),
            SizedBox(height: 12.0),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    clearTextFields();
                  },
                ),
                RaisedButton(
                  color: Colors.pink[500],
                  child: Text('RECORD'),
                  onPressed: () {
                    if (validateInputs()) {
                      Expense expense = Expense(
                          amount: double.parse(_amountController.text),
                          category: _categoryController.text,
                          details: _detailsController.text,
                          dateTime: new DateTime.now());
                      _expenseController.newExpense(expense).then((newExpense) {
                        clearTextFields();
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text('Expense Recorded Succesfully'),
                          backgroundColor: Colors.green[600],
                        ));
                      });
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text('Invalid Inputs'),
                        backgroundColor: Colors.green[600],
                      ));
                    }
                    //TODO: change tab
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void clearTextFields() {
    _amountController.clear();
    _categoryController.clear();
    _detailsController.clear();
  }

  bool validateInputs() {
    if (_amountController.text.isNotEmpty &&
        double.tryParse(_amountController.text) != null) {
      if (_categoryController.text.isNotEmpty) {
        return true;
      }
    }

    return false;
  }
}
