import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';

class ChatFieldInput extends StatelessWidget {
  const ChatFieldInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Row (
          children: [
            Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding*0.75,

                    ),
                    decoration: BoxDecoration (
                      color: kPrimaryColor,
                      boxShadow: [BoxShadow(
                        offset: Offset(0,4),
                        blurRadius: 32,
                        color: Color(0xFF087949).withOpacity(0.8),
                      ),],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row (
                      children: [
                        Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1?.color?.withOpacity(0.64)
                        ),
                        SizedBox(width: kDefaultPadding/4,),
                        Expanded(child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                        )),
                        ElevatedButton(
                            onPressed: () {},
                          child: Icon(Icons.send_rounded),
                        ),
                      ],
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}