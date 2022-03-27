import 'dart:io';

List<List<dynamic>> csvToFields(filepath) {
  File f = File(filepath);
  print("Converting CSV to list...");

  // Read csv file and transform it to field using CsvToListConverter object
  final lines = f.readAsLinesSync();
  lines.removeAt(0);
  var fields = List<List<String>>.empty(growable: true);
  for (var line in lines) {
    fields.add(line.split(','));
  }

  return fields;
}

void main() {
  final messages = csvToFields("../data/user_chat_data.csv");

  for (var msg in messages) {
    print(msg);
  }
}
