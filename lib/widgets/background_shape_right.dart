import 'package:flutter/material.dart';

class RightShape extends StatelessWidget {
  final double width;
  const RightShape({super.key, this.width = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('شاخص  منفی', style: TextStyle(color: Colors.red)),
        SizedBox(width: 5.0),
        Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          ),
        ),
      ],
    );
  }
}
