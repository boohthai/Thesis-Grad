// import 'dart:convert';
// import 'dart:io';
//
// import 'package:csv/csv.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';

import 'package:thesis_v01/controllers/convert_csv.dart';
import 'package:intl/intl.dart';

enum MessageType { text, audio, image, video, undefined }
enum MessageStatus {not_sent, not_view, viewed, undefined }

class ChatMessage {
  final DateTime timestamp;
  final String text;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    required this.timestamp,
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

MessageType messageTypeConverter(String type) {
  switch (type) {
    case 'text':
      return MessageType.text;
    case 'audio':
      return MessageType.audio;
    case 'video':
      return MessageType.video;
    case 'image':
      return MessageType.image;
    default:
      return MessageType.undefined;
  }
}

MessageStatus messageStatusConverter(String type) {
  switch (type) {
    case 'not sent':
      return MessageStatus.not_sent;
    case 'not viewed':
      return MessageStatus.not_view;
    case 'viewed':
      return MessageStatus.viewed;
    default:
      return MessageStatus.undefined;
  }
}

ChatMessage createMessage(field) {
  //DateTime timestamp = field[0];
  DateTime timestamp = new DateFormat("yyyy/mm/dd hh:mm:ss").parse(field[0]);
  String text = field[1];
  String messageType = field[2];
  String messageStatus = field[3];
  int isSender = field[4];
  return ChatMessage(
      timestamp: timestamp,
      text: text,
      messageType: messageTypeConverter(messageType),
      messageStatus: messageStatusConverter(messageStatus),
      isSender: isSender ==  1 ? true : false);
}

Future<List<ChatMessage>> csvToMessages(filepath) async{
  var chatMessages = List<ChatMessage>.empty(growable: true);
  var fields = await csvToFields(filepath);
  print(fields);
  for (var field in fields) {
    var message = createMessage(field);
    chatMessages.add(message);
  }
  return chatMessages;
}



