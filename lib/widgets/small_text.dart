import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  const SmallText({
    Key? key,
    required this.text,
    this.color,
    this.height=1.2,
    this.size = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: 
          TextStyle(height: height, color: color, fontWeight: FontWeight.w400, fontSize: size),
    );
  }
}
