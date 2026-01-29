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
    );
  }
}
