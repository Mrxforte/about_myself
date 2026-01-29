import 'package:flutter/material.dart';

class CustomUserTitleWidget extends StatelessWidget {
  const CustomUserTitleWidget({
    super.key,
    required this.title,
    required this.fontSize,
    required this.bgColor,
  });
  final String title;
  final double fontSize;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w300),
      ),
    );
  }
}
