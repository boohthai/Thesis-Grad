import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';
class ButtonPressed extends StatelessWidget {
   ButtonPressed({
    Key? key,
  }) : super(key: key);
  List<dynamic> string_to_list(res) {
    var list = res.substring(1,res.length-1).split("), ");
    return list;
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
            child: Container(
              //padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                child:  Text("Predict"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () async {
                  // Uri for back-end
                  final url = Uri.parse("http://10.0.2.2:8000/");
                  final response = await http
                      .post(url, body: json.encode({'text': [["Hello, what sub bro?","text","viewed","1"], ["Oh dame, this is not so good","text","viewed","1"]]}), headers: {
                    'Content-Type': "application/json; charset=utf-8",
                  });
                  print("Status Code: ${response.statusCode}");
                  print("Return Date: ${response.body}");

                  if (response.statusCode == 200) {
                    final jsonResponse =
                    jsonDecode(response.body) as Map<String, dynamic>;
                    var result = string_to_list(jsonResponse['output']);
                    print("Depression Result: $result");
                    // setState(() {
                    //   depressionResult = depressionResult;
                    //   depressionScore = depressionScore;
                    // });
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
      ),
    );
  }
}