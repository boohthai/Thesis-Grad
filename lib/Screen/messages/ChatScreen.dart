import 'package:flutter/material.dart';
import 'package:thesis_v01/main.dart';
import 'package:thesis_v01/constants.dart';
import 'package:thesis_v01/Screen/messages/components/body.dart';
import 'package:thesis_v01/ResultScreen.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Body()
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
          ),
          SizedBox(width: kDefaultPadding * 0.75,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thai Thanh Tai",
                style:  TextStyle(fontSize: 18),
              ),
              Text("Active", style: TextStyle(fontSize: 13))
            ],
          )
        ],
      ),
    );
  }
}