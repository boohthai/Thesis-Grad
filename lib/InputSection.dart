// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:thesis_v01/ResultScreen.dart';
import 'package:thesis_v01/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:thesis_v01/Screen/messages/ChatScreen.dart';

class MyForm extends StatelessWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Input section';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(appTitle),
        ),
        body: const MessageScreen(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Display variables
  String text = "";
  String depressionResult = "";
  String depressionScore = "";
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // TextFormField(
            //   keyboardType: TextInputType.multiline,
            //   maxLines: null,
            //   // The validator receives the text that the user has entered.
            //   onChanged: (value) {
            //     setState(() {
            //       text = value;
            //     });
            //   },
            //   decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white.withOpacity(0.3),
            //       hintText: 'Write something to classify...',
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black87, width: 2),
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black87, width: 2),
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //       )),
            // ),

            SizedBox(height: 30),
            Center(
              //padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.yellowAccent,
                  size: 30,
                ),
                label: Text(
                  'Predict Text',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.apply(color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () async {
                  // Uri for back-end
                  final url = Uri.parse("http://10.0.2.2:8000/");
                  final response = await http
                      .post(url, body: json.encode({'text': text}), headers: {
                    'Content-Type': "application/json; charset=utf-8",
                  });
                  print("Status Code: ${response.statusCode}");
                  print("Return Date: ${response.body}");

                  if (response.statusCode == 200) {
                    final jsonResponse =
                        jsonDecode(response.body) as Map<String, dynamic>;
                    depressionResult = jsonResponse['depression'];
                    depressionScore = jsonResponse['score'];
                    print("Depression Result: $depressionResult");
                    print("Depression Score: $depressionScore");

                    setState(() {
                      depressionResult = depressionResult;
                      depressionScore = depressionScore;
                    });
                  } else {
                    print("Request failed with status: ${response.statusCode}");
                  }

                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  // Navigator.push (
                  //   context,
                  //   MaterialPageRoute(builder: (context)=> const ResultPage(),)
                  // );
                },
              ),
            ),
            SizedBox(height: 10),
            Text("Text: $text",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 5),
            Text("Depression: $depressionResult",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 5),
            Text("Score: $depressionScore",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
