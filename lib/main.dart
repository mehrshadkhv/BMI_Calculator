import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/screens/home_screen.dart';
import 'package:bmi_calculator/widgets/background_shape_left.dart';
import 'package:bmi_calculator/widgets/background_shape_right.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'dana'),
      home: HomeScreen(),
    );
  }
}
