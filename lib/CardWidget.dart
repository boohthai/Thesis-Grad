import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  final String title = "Charts Demo";

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

    // final tabletSalesData = [
    //   Sales('2015', random.nextInt(100)),
    //   Sales('2016', random.nextInt(100)),
    //   Sales('2017', random.nextInt(100)),
    //   Sales('2018', random.nextInt(100)),
    //   Sales('2019', random.nextInt(100)),
    // ];
    //
    // final mobileSalesData = [
    //   Sales('2015', random.nextInt(100)),
    //   Sales('2016', random.nextInt(100)),
    //   Sales('2017', random.nextInt(100)),
    //   Sales('2018', random.nextInt(100)),
    //   Sales('2019', random.nextInt(100)),
    // ];

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
      // charts.Series<Sales, String>(
      //   id: 'Sales',
      //   domainFn: (Sales sales, _) => sales.year,
      //   measureFn: (Sales sales, _) => sales.sales,
      //   data: tabletSalesData,
      //   fillColorFn: (Sales sales, _) {
      //     return charts.MaterialPalette.green.shadeDefault;
      //   },
      // ),
      // charts.Series<Sales, String>(
      //   id: 'Sales',
      //   domainFn: (Sales sales, _) => sales.year,
      //   measureFn: (Sales sales, _) => sales.sales,
      //   data: mobileSalesData,
      //   fillColorFn: (Sales sales, _) {
      //     return charts.MaterialPalette.teal.shadeDefault;
      //   },
      //)
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
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