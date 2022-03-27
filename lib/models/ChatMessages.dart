import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/convert_csv.dart';

enum MessageType { text, audio, image, video, undefined }
enum MessageStatus { not_sent, not_view, viewed, undefined }

class ChatMessage {
  final String text;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
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
  String text = field[0];
  String messageType = field[1];
  String messageStatus = field[2];
  String isSender = field[3];
  return ChatMessage(
      text: text,
      messageType: messageTypeConverter(messageType),
      messageStatus: messageStatusConverter(messageStatus),
      isSender: isSender == '1' ? true : false);
}

List<ChatMessage> csvToMessages(filepath) {
  var chatMessages = List<ChatMessage>.empty(growable: true);
  var fields = csvToFields(filepath);

  for (var field in fields) {
    var message = createMessage(field);
    chatMessages.add(message);
  }

  return chatMessages;
}

List<ChatMessage> demeChatMessages =
    csvToMessages('../data/user_chat_data.csv');
