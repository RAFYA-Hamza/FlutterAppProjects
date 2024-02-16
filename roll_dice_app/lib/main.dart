import 'package:flutter/material.dart';
import 'package:roll_dice_app/gradient_container.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GredientContainer.purple(),
      ),
    );
  }
}
