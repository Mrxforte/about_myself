import 'package:about_myself/views/home/web/home_screen_web.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About myself',
      home: HomeScreenWeb(),
      debugShowCheckedModeBanner: false,
    );
  }
}
