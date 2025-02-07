
import 'package:bus/bottom.dart';
import 'package:bus/calculator.dart';
import 'package:bus/card.dart';
import 'package:bus/home.dart';
import 'package:bus/trackcomplaint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor:Colors.blue
      ),
      home:const Cardconsession(),

    );
  }
}
