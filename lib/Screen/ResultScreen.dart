import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result',
      home: Scaffold (
        appBar: AppBar(
            title: Text('Result'),
          backgroundColor: Colors.green,
        ),
        
        body: Diagnose()
      )
    );
  }
}
class Diagnose extends StatefulWidget {
  const Diagnose({Key? key}) : super(key: key);

  @override
  _DiagnoseState createState() => _DiagnoseState();
}

class _DiagnoseState extends State<Diagnose> {
  static const percent = 0.8;
  static  const percent_display = percent*100;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(40.0),
        ),
        Center(
          child: CircularPercentIndicator(
            radius: 200.0,
            lineWidth: 20.0,
            percent: percent,
            header: new Text("Username", style: TextStyle(
              fontSize: 30,
            ),),
            center: new Text(
              '$percent_display %',
              style: TextStyle (
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.green,
          ),
        )

      ],
    );
  }
}



