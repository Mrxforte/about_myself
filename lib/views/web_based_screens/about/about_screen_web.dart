import 'package:flutter/material.dart';

class AboutScreenWeb extends StatelessWidget {
  const AboutScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: Row(
        children: [
          Image.asset("assets/images/android_dev.png"),
          // Column(
          //   children: [
          //     Text("About me"),
          //     Text(
          //       "Voluptate consequat laboris in irure elit veniam cillum sunt mollit esse pariatur officia adipisicing. Dolor dolore dolor ullamco ullamco voluptate laboris culpa occaecat adipisicing ipsum consectetur ea fugiat. Ea ullamco aute sunt non do eiusmod consectetur amet. Eu et esse esse excepteur ex nulla dolor enim labore adipisicing. Ad duis et eiusmod anim reprehenderit aliquip.",
          //     ),
          //     // Flexible(
          //     //   child: ListView.separated(
          //     //     scrollDirection: Axis.horizontal,
          //     //     itemBuilder: (context, index) {
          //     //       return OutlinedButton(
          //     //         onPressed: () {},
          //     //         child: Text("${index}App"),
          //     //       );
          //     //     },
          //     //     separatorBuilder: (context, index) {
          //     //       return SizedBox(width: 5);
          //     //     },
          //     //     itemCount: 7,
          //     //   ),
          //     // ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
