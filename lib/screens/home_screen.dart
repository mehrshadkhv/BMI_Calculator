import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/widgets/background_shape_left.dart';
import 'package:bmi_calculator/widgets/background_shape_right.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  double resultBMI = 0;
  String resultText = '';
  double widthGood = 100;
  double widthBad = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'تو چنده ؟ BMI',
          style: TextStyle(fontFamily: 'dana', color: black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 130,
                    child: TextField(
                      controller: weightController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: orangeBackground,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'وزن',
                        hintStyle: TextStyle(
                          color: orangeBackground.withValues(alpha: 0.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: 130,
                    child: TextField(
                      controller: heightController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: orangeBackground,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'قد',
                        hintStyle: TextStyle(
                          color: orangeBackground.withValues(alpha: 0.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  final weight = double.parse(weightController.text);
                  final height = double.parse(heightController.text);
                  setState(() {
                    resultBMI = weight / (height * height);
                    if (resultBMI > 25) {
                      widthBad = 270;
                      widthGood = 50;
                      resultText = 'شما اضافه وزن دارید';
                    } else if (resultBMI >= 18.5 && resultBMI <= 25) {
                      widthBad = 50;
                      widthGood = 270;
                      resultText = 'وزن شما نرمال است';
                    } else {
                      widthBad = 10;
                      widthGood = 10;
                      resultText = 'وزن شما کمتر از حد نرمال است';
                    }
                  });
                },
                child: Text(
                  '! محاسبه کن',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontFamily: 'dana',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                '${resultBMI.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 64.0,
                  fontFamily: 'dana',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0,),
              Text(
                '$resultText',
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: 'dana',
                  fontWeight: FontWeight.bold,
                  color: orangeBackground,
                ),
              ),
              SizedBox(height: 100),
              RightShape(width: widthBad),
              SizedBox(height: 15),
              LeftShape(width: widthGood),
            ],
          ),
        ),
      ),
    );
  }
}
