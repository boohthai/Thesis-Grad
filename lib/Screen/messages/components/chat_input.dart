import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:thesis_v01/constants.dart';
import 'package:thesis_v01/ResultScreen.dart';
import 'package:thesis_v01/models/ChatMessages.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
List<List<dynamic>> data = [];
class ButtonPressed extends StatefulWidget {
  const ButtonPressed();
  @override
  State<ButtonPressed> createState() => _ButtonPressedState();
}

class _ButtonPressedState extends State<ButtonPressed> {
  List<String> string_to_list(res) {
      var list = res.substring(1,res.length-1).split("), ");
      return list;
  }
  final _formKey = GlobalKey<FormState>();
  List<dynamic> result =[];
  List<String> dateseries = [];
  loadAsset() async {
    final myData = await rootBundle.loadString("assets/conv_db.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    data = csvTable;
    for (int i = 0; i<data.length; i++) {
      if (data[i][4] == 1) {
        dateseries.add(data[i][0]);
      }
    }
   // print(dateseries);
  }
  @override
  Widget build(BuildContext context) {
    loadAsset();
    return Container (
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding/2),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Container(
          child: ElevatedButton(
            child:  Text("Predict", style: TextStyle(
              fontSize: 20
            ),),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () async {
              final url = Uri.parse("http://10.0.2.2:8000/");
              final response = await http
                  .post(url, body: json.encode({'text': []}), headers: {
                'Content-Type': "application/json; charset=utf-8",
              });
              //print("Status Code: ${response.statusCode}");
              //print("Return: ${response.body}");

              if (response.statusCode == 200) {
                final jsonResponse =  jsonDecode(response.body) as Map<String, dynamic>;
                result = string_to_list(jsonResponse['output']);
                print("Depression Result: $result");
              } else {
                print("Request failed with status: ${response.statusCode}");
              }
              Navigator.push (
                context,
                MaterialPageRoute(builder: (context)=> new ResultPage(dateseries,result))
              );
            },
          ),
        ),
      ),
    );
  }
}