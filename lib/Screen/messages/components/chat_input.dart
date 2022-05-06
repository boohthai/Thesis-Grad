import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';
import 'package:thesis_v01/ResultScreen.dart';

class ButtonPressed extends StatelessWidget {
   ButtonPressed({ Key? key,}) : super(key: key);
  List<String> string_to_list(res) {
      var list = res.substring(1,res.length-1).split("), ");
    //var list = json.decode(res);
      return list;

  }
  final _formKey = GlobalKey<FormState>();
  List<dynamic> result =[];
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
            child:  Text("Predict", style: TextStyle(
              fontSize: 20
            ),),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () async {
              // Uri for back-end
              final url = Uri.parse("http://10.0.2.2:8000/");
              final response = await http
                  .post(url, body: json.encode({'text': [["","Hello, what sub bro?","text","viewed","True"], ["","Oh dame, this is not so good","text","viewed","True"]]}), headers: {
                'Content-Type': "application/json; charset=utf-8",
              });
              print("Status Code: ${response.statusCode}");
              print("Return: ${response.body}");

              if (response.statusCode == 200) {
                final jsonResponse =
                jsonDecode(response.body) as Map<String, dynamic>;
                result = string_to_list(jsonResponse['output']);
                print("Depression Result: $result");
                // setState(() {
                //   depressionResult = depressionResult;
                //   depressionScore = depressionScore;
                // });
              } else {
                print("Request failed with status: ${response.statusCode}");
              }
              Navigator.push (
                context,
                MaterialPageRoute(builder: (context)=> new ResultPage(result))
              );
            },
          ),
        ),
      ),
    );
  }
}