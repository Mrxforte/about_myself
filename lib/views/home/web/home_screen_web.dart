import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Color(0xFF080808),
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // custom appbar
              CustomWebAppbarWidget(width: width),

              // row about user  and avatar
              UserInfoAvatarWidget(height: height, width: width),
              // hlist trusted companies
              PreferredSize(
                preferredSize: Size.fromWidth(width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trusted Conpanies",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {},
                          label: Text("Google"),
                          icon: Icon(Icons.facebook),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {},
                          label: Text("Google"),
                          icon: Icon(Icons.facebook),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {},
                          label: Text("Google"),
                          icon: Icon(Icons.facebook),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {},
                          label: Text("Google"),
                          icon: Icon(Icons.facebook),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          onPressed: () {},
                          label: Text("Google"),
                          icon: Icon(Icons.facebook),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoAvatarWidget extends StatelessWidget {
  const UserInfoAvatarWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.7,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Azamat Urozimbetov",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: Text(
                  "Intro text: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                  ),
                  backgroundColor: Color(0xFF3F8E00),
                  fixedSize: Size.fromWidth(350),
                  padding: EdgeInsets.symmetric(vertical: 25),
                ),
                onPressed: () {},
                child: Text(
                  "Let's get started >",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/image.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWebAppbarWidget extends StatelessWidget {
  const CustomWebAppbarWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1B1B1B),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: width,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Home")),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Case Studies")),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Testimonials")),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Recent Works")),
            Spacer(),
            TextButton(onPressed: () {}, child: Text("Get In Touch")),
            Spacer(),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
                IconButton(onPressed: () {}, icon: Icon(Icons.email)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
