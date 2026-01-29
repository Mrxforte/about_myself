import 'package:flutter/material.dart';

class CustomTabItemWidget extends StatefulWidget {
  const CustomTabItemWidget({super.key, required this.title});
  final String title;
  @override
  State<CustomTabItemWidget> createState() => _CustomTabItemWidgetState();
}

class _CustomTabItemWidgetState extends State<CustomTabItemWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: AnimatedDefaultTextStyle(
        style: isSelected ? TextStyle(fontSize: 20) : TextStyle(fontSize: 19),
        duration: Duration(milliseconds: 100),
        child: Text(widget.title),
      ),
      onEnter: (event) {
        setState(() {
          isSelected = true;
        });
      },
      onExit: (event) {
        setState(() {
          isSelected = false;
        });
      },
    );
  }
}
