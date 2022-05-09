import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'ResultScreen.dart' as calculated;
class ChartsDemo extends StatefulWidget {
  final List<String> date;
  final List<dynamic> score;
  ChartsDemo(this.date, this.score) : super();
  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  late final List<charts.Series<dynamic, String>> seriesList;
  static List<charts.Series<Info, String>> _createData(date,score) {
    List<Info> desktopSalesData = [];
    for (int i = 0; i<date.length; i++) {
      print(date[i]);
      print(score[i]);
      desktopSalesData.add(Info(date[i].toString(), score[i]*100));
    }

    return [
      charts.Series<Info, String>(
        id: 'Insights',
        domainFn: (Info info, _) => info.time,
        measureFn: (Info info, _) => info.value,
        data: desktopSalesData,
        fillColorFn: (Info score, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createData(this.widget.date,this.widget.score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: barChart(),
      ),
    );
  }
}

class Info {
  final String time;
  final dynamic value;
  Info(this.time, this.value);
}