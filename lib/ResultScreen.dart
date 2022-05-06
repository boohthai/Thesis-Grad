import 'dart:io';
import 'CardWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:thesis_v01/controllers/convert_csv.dart';
import 'models/ChatMessages.dart';
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
          centerTitle: true,
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
    int dep = new_result[0];
    double scr = new_result[1];
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
            ChartsDemo(new_result[2]),
            ChartsDemo([]),
            ChartsDemo([]),
          ]),
        )

      ],
    );
  }
  dynamic ProcessResults(List<dynamic> string) {
    final depression = List<int>.filled(this.widget.result.length, 0);
    final score = List<double>.filled(this.widget.result.length, 0);
    final time = List<DateTime>.empty();
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
    return [total,temp/string.length, score];
  }
}




