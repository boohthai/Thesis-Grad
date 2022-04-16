import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class ResultPage extends StatefulWidget {
  final List<dynamic> processedResult;
  const ResultPage(this.processedResult);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {

    // print(result[0]);
    return MaterialApp(
      title: 'Result',
      home: Scaffold (
        appBar: AppBar(
            title: Text('Result'),
          backgroundColor: Colors.green,
        ),
        body: new Diagnose(this.widget.processedResult),
      )
    );
  }
}
class Diagnose extends StatefulWidget {
  final List<dynamic> result;
  const Diagnose(this.result);
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {

  @override
  Widget build(BuildContext context) {
    List<dynamic> result = this.widget.result;
    dynamic new_result = ProcessResults(result);
    int dep = new_result[0];
    double scr = new_result[1];
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40.0),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05, horizontal: MediaQuery.of(context).size.width*0.3),
            decoration: BoxDecoration(
              color: Color(0xFFa4def9),
              border: Border.all(
                color: Colors.black,
                width: 1
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("TOTAL: $dep", style: TextStyle(fontSize: 20),),
          ),
        ),
        SizedBox(height: 50),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05, horizontal: MediaQuery.of(context).size.width*0.3),
            decoration: BoxDecoration(
              color: Color(0xFFa4def9),
              border: Border.all(
                  color: Colors.black,
                  width: 1
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("SCORE", style: TextStyle(fontSize: 20),),
          ),
        ),
        SizedBox(height: 50),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05, horizontal: MediaQuery.of(context).size.width*0.3),
            decoration: BoxDecoration(
              color: Color(0xFFa4def9),
              border: Border.all(
                  color: Colors.black,
                  width: 1
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text("AVG: $scr", style: TextStyle(fontSize: 20),),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
  dynamic ProcessResults(List<dynamic> string) {
    final depression = List<int>.filled(this.widget.result.length, 0);
    final score = List<double>.filled(this.widget.result.length, 0);
    var total = 0; var temp = 0.0;
    for (int i = 0; i< string.length; i++){
      String substring = string[i].substring(1,string[i].length-1);
      depression[i] = int.parse(substring[0]);
      if (depression[i] == 1) {
        total = total + 1;
      }
      score[i] = double.parse(substring.substring(3));
      temp = temp + score[i];
    }
    return [total,temp/string.length];
  }
}



