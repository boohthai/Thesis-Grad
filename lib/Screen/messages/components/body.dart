import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';
import 'package:thesis_v01/Screen/messages/components/chat_input.dart';
import 'package:thesis_v01/models/ChatMessages.dart';
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
              child: ListView.builder (
                itemCount: demeChatMessages.length,
                itemBuilder: (context, index) => Message(message: demeChatMessages[index],)
              )
          ),
          ChatFieldInput(),
        ],
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key, required this.message,
  }) : super(key: key);

  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children:[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding*0.75,
              horizontal: kDefaultPadding/2,
               ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(message.isSender ? 1: 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message.text,
              style: TextStyle (
                color: message.isSender
                ? Colors.white : Colors.black,
              ),

            )),

    ],
    );
  }
}


