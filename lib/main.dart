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
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              RightShape(width: 180),
              RightShape(width: 190),
              RightShape(width: 210),
              LeftShape(width: 200),
              LeftShape(width: 210),
              LeftShape(width: 220),
            ],
          ),
        ),
      ),
    );
  }
}
