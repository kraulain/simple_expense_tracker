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

  double today = 0, thisWeek = 0, thisMonth = 0, thisYear = 0, allTime = 0;

  @override
  void initState() {

    super.initState();

    _controller.getTodaysExpenses().then((amount) {
      setState(() {
        today = amount;
      });
    });

    _controller.getThisWeeksExpenses().then((amount) {
      setState(() {
        thisWeek = amount;
      });
    });

    _controller.getThisMonthsExpenses().then((amount) {
      setState(() {
        thisMonth = amount;
      });
    });

    _controller.getThisYearsExpenses().then((amount) {
      setState(() {
        thisYear = amount;
      });
    });

    _controller.getAllTimeExpenses().then((amount) {
      setState(() {
        allTime = amount;
      });
    });
  }


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
      body: allTime == 0 ? Center(child: Text('Loading ...')) : ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.watch_later),
            title: Text('Today: '),
            subtitle: Text('XAF ' + today.toString()),
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('This Week: '),
            subtitle: Text('XAF ' + thisWeek.toString()),
          ),
          ListTile(
            leading: Icon(Icons.today),
            title: Text('This Month: '),
            subtitle: Text('XAF ' + thisMonth.toString()),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('This Year: '),
            subtitle: Text('XAF ' + thisYear.toString()),
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('All Time: '),
            subtitle: Text('XAF ' + allTime.toString()),
          ),
        ],
      ),
    );
  }
}
