import 'package:flutter/material.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // custom appbar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                width: width,
                height: 60,
                child: Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text("Home")),
                    TextButton(onPressed: () {}, child: Text("Case Studies")),
                    TextButton(onPressed: () {}, child: Text("Testimonials")),
                    TextButton(onPressed: () {}, child: Text("Recent Works")),
                    TextButton(onPressed: () {}, child: Text("Get In Touch")),
                  ],
                ),
              ),
              // row about user  and avatar
              // hlist trusted companies
            ],
          ),
        ),
      ),
    );
  }
}
