import 'package:flutter/material.dart';
import 'package:twitter_demo/view/screen.dart';
import 'package:twitter_demo/view/start_up/login_page.dart';
import 'package:twitter_demo/view/time_line/time_line_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
