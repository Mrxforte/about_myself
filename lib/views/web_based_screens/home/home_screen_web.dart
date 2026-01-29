import 'package:about_myself/views/web_based_screens/about/about_screen_web.dart';
import 'package:about_myself/views/widgets/custom_user_title_widget.dart';
import 'package:about_myself/views/widgets/my_drawer_widget.dart';
import 'package:about_myself/views/wrapper/custom_tab_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 3),
            CustomTabItemWidget(title: "Home"),
            Spacer(),
            CustomTabItemWidget(title: "About"),
            Spacer(),
            CustomTabItemWidget(title: "Blog"),
            Spacer(),
            CustomTabItemWidget(title: "Info"),
            Spacer(),
            CustomTabItemWidget(title: "Contacts"),
            Spacer(),
          ],
        ),
      ),
      body: ListView(
        children: [
          // main  content of the app
          // row with hello name  and user avatar
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomUserTitleWidget(
                          bgColor: Colors.tealAccent,
                          fontSize: 20,
                          title: "Hello I am",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Azamat", style: TextStyle(fontSize: 25)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Android Developer",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        // contact  info widgets with icon
                        TextButton.icon(
                          onPressed: () {},
                          label: Text(
                            "urazimbetovazamat6@gmsil.com",
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.email),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: Text(
                            "+79998868535",
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.call),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: Text(
                            "Russia",
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.location_on),
                        ),
                      ],
                    ),

                    CircleAvatar(
                      radius: 200,
                      backgroundImage: AssetImage("images/image.png"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // About Screen
          AboutScreenWeb(),
        ],
      ),
    );
  }
}
