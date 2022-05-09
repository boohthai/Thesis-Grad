//import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

// List<List<dynamic>> csvToFields(filepath) {
//   File f = File(filepath);
//   print("Converting CSV to list...");
//
//   // Read csv file and transform it to field using CsvToListConverter object
//   final lines = f.readAsLinesSync();
//   lines.removeAt(0);
//   var fields = List<List<String>>.empty(growable: true);
//   for (var line in lines) {
//     fields.add(line.split(','));
//   }
//
//   return fields;
// }
Future<List<List<dynamic>>> csvToFields(filepath) async {
  final _rawData = await rootBundle.loadString(filepath);
  List<List<dynamic>> _listData =
  const CsvToListConverter().convert(_rawData);
  return _listData;
}
void main() async{
  final messages = await csvToFields("assets/user_chat_data.csv");
  for (var msg in messages) {
    print(msg);
  }
}