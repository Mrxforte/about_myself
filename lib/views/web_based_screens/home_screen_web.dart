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
          CustomUserTitleWidget(
            bgColor: Colors.black12,
            fontSize: 30,
            title: "Azamat",
          ),
        ],
      ),
    );
  }
}
