import 'package:flutter/material.dart';

import 'maint_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptosha',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainScreen(),
    );
  }
}