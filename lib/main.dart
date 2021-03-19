import 'package:flutter/material.dart';

import 'home_page.dart';


void main() {
  runApp(MyApp());
}

/// Main class that displays app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}
