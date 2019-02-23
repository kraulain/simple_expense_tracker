import 'package:flutter/material.dart';
import 'package:piggy/controllers/expense_controller.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  ExpenseController _controller = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              //show about app and help view
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.watch_later),
            title: Text('Today: '),
            subtitle: Text('XAF ' + _controller.getTodaysExpenses().toString()),
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('This Week: '),
            subtitle: Text('XAF ' + _controller.getTodaysExpenses().toString()),
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('This Month: '),
            subtitle: Text('XAF ' + _controller.getTodaysExpenses().toString()),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('This Year: '),
            subtitle: Text('XAF ' + _controller.getTodaysExpenses().toString()),
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('All Time: '),
            subtitle: Text('XAF ' + _controller.getTodaysExpenses().toString()),
          ),
        ],
      ),
    );
  }
}
