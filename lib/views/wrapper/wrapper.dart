import 'package:about_myself/views/mobile_based_screens/home_screen_mobile.dart';
import 'package:about_myself/views/web_based_screens/home/home_screen_web.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return HomeScreenWeb();
        } else {
          return HomeScreenMobile();
        }
      },
    );
  }
}
