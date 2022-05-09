import 'dart:io';
import 'CardWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:thesis_v01/controllers/convert_csv.dart';
import 'models/ChatMessages.dart';
import 'dart:math';
class ResultPage extends StatefulWidget {
  final List<dynamic> processedResult;
  final List<String> dateseries;
  const ResultPage(this.dateseries, this.processedResult);
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
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Diagnose(this.widget.dateseries, this.widget.processedResult),
      )
    );
  }
}
class Diagnose extends StatefulWidget {
  final List<dynamic> result;
  final List<dynamic> date;
  const Diagnose(this.date, this.result);
  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> with SingleTickerProviderStateMixin{
  final colorstheme = Color(0xff4b4b87);
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<dynamic> result = this.widget.result;
    dynamic new_result = ProcessResults(result);
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey[300]),
          child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelColor: Colors.white,
              unselectedLabelColor: colorstheme,
              labelStyle: TextStyle(fontSize: 20),
              labelPadding:
              EdgeInsets.only(left: 45, right: 45, top: 10, bottom: 10),
              indicator: BoxDecoration(
                  color: colorstheme,
                  borderRadius: BorderRadius.circular(20)),
              controller: _tabController,
              tabs: [
                Text('Day'),
                Text('Week'),
                Text('Month'),
              ]),
        ),
        Expanded(
          child: TabBarView(
              controller: _tabController, children: [
            ChartsDemo(new_result[1],new_result[2]),
            ChartsDemo([],new_result[2]),
            ChartsDemo([],new_result[2]),
          ]),
        )

      ],
    );
  }
  dynamic ProcessResults(List<dynamic> string) {
    final depression = List<int>.filled(this.widget.result.length, 0);
    var score = List<double>.filled(this.widget.result.length, 0);
    final dateList = this.widget.date;
    List<int> store = [];
    var total = 0; var temp = 0.0;
    for (int i = 0; i< string.length; i++){
      String substring = string[i].substring(1,string[i].length);
      if (substring.contains(")")) {
        substring = substring.substring(0,substring.indexOf(")"));
      }
      depression[i] = int.parse(substring[0]);
      if (depression[i] == 1) {
        total = total + 1;
      }
      if (substring.substring(3).contains("e-")) {
        int pos = substring.substring(3).indexOf('e-');
        int x = int.parse(substring.substring(3).substring(pos+1));
        score[i] = double.parse(substring.substring(3));
      }
      else {
        score[i] = double.parse(substring.substring(3));
      }
       temp = temp + score[i];
    }
    var i = 0;
    var index = i+1;
    while (index<dateList.length) {
      if (dateList[i]==dateList[index]) {
        index++;
      }
      else{
        store.add(index);
        i = index;
        index = i + 1;
      }
     }
     store.add(dateList.length-1);
     print(store);
     print(score);
     List<String> neededDate = [dateList[0]];
     List<dynamic> avg = []; index =0;
      for (int i = 0; i<store.length; i++){
        var count = 0.0;
        if (i!=store.length-1)
         {
           neededDate.add(dateList[store[i]]);
         }
        for (int j = index; j<store[i]; j++){
          count = count + score[j];
        }
        avg.add(count/store[i]);
        index = store[i];
     }
     print(avg);
     print(neededDate);
    return [total,neededDate, avg];
  }
}




