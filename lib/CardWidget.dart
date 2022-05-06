import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'ResultScreen.dart' as calculated;
class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo(List) : super();

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //
  late final List<charts.Series<dynamic, String>> seriesList;

  static List<charts.Series<Info, String>> _createRandomData() {

    final random = Random();
    final desktopSalesData = [
      Info('Mon', random.nextInt(100)),
      Info('Tue', random.nextInt(100)),
      Info('Wed', random.nextInt(100)),
      Info('Thu', random.nextInt(100)),
      Info('Fri', random.nextInt(100)),
      Info('Sat', random.nextInt(100)),
      Info('Sun', random.nextInt(100)),
    ];

    return [
      charts.Series<Info, String>(
        id: 'Insights',
        domainFn: (Info info, _) => info.time,
        measureFn: (Info info, _) => info.value,
        data: desktopSalesData,
        fillColorFn: (Info sales, _) {
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
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(40.0),
        child: barChart(),
      ),
    );
  }
}

class Info {
  final String time;
  final int value;
  Info(this.time, this.value);
}