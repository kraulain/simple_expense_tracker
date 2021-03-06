import 'package:flutter/material.dart';
import 'package:piggy/views/home_page.dart';
import 'package:preferences/preferences.dart';

void main() async{
  await PrefService.init(prefix: 'pref_');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piggy',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme
            .of(context)
            .textTheme
            .apply(
          bodyColor: Colors.black,
          displayColor: Colors.pink[600],
        ),
        // This colors the [InputOutlineBorder] when it is selected
        primaryColor: Colors.pink[500],
        textSelectionHandleColor: Colors.green[500],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: HomePage(),
    );
  }
}
