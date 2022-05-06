import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';
import 'package:thesis_v01/Screen/messages/components/chat_input.dart';
import 'package:thesis_v01/models/ChatMessages.dart';
import 'package:intl/intl.dart';
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<ChatMessage>>(
          future: csvToMessages("assets/conv_db.csv"), // async work
          builder: (BuildContext context, AsyncSnapshot<List<ChatMessage>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Text('Loading....');
              default:
                if (snapshot.hasError)
                { print(snapshot);
                return Text('Error: ${snapshot.error}');}
                else
                { print(snapshot.data);
                //return Text('Loadng');
                return  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Message(
                          message: snapshot.data![index],
                        )));
                }
            }
          },
        ),
        ButtonPressed(), //Press button to see the result
      ],
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var time = DateFormat.yMMMMd('en-US').format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children:[
          Row(
          mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            SizedBox(
                width: size.width*2/3,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding * 0.75,
                    horizontal: kDefaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(message.isSender ? 1 : 0.08),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    message.text,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 16,
                      color: message.isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ),
            ),
          ],
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment:
              message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(time.toString(),
                  style: TextStyle( fontSize: 12, fontStyle: FontStyle.italic,),) ,
                ),
              ],
            ),
          )
      ],
      ),
    );
  }
}