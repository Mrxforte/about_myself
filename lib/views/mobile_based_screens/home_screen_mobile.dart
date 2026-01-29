import 'package:about_myself/views/widgets/custom_user_title_widget.dart';
import 'package:about_myself/views/widgets/my_drawer_widget.dart';
import 'package:about_myself/views/wrapper/custom_tab_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({super.key});

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
                      children: [
                        CustomUserTitleWidget(
                          bgColor: Colors.black12,
                          fontSize: 16,
                          title: "Hello I am",
                        ),
                        SizedBox(height: 20),
                        CustomUserTitleWidget(
                          bgColor: Colors.black12,
                          fontSize: 30,
                          title: "Azamat",
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
        ],
      ),
    );
  }
}
