import 'package:flutter/material.dart';
import 'package:piggy/views/details_page.dart';
import 'package:piggy/views/new_expense_page.dart';
import 'package:piggy/views/settings_page.dart';
import 'package:piggy/views/summary_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    SummaryPage(title: 'Summary'),
    DetailsPage(),
    NewExpensePage(),
    SummaryPage(title: 'Reports'),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        fixedColor: Colors.green[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Summary'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('Details'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('New'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart),
            title: Text('Reports'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
