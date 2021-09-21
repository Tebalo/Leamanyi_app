import 'package:flutter/material.dart';
import 'package:leamanyi_app/text_Interface/MyCustomForm.dart';
import 'package:leamanyi_app/text_Interface/MyHomePage.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leamanyi',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      //home: MyHomePage(title: 'Leamanyi(Part of Speech)'),
      home: MyCustomForm(),
    );
  }
}

