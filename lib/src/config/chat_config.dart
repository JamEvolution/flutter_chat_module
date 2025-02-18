import 'package:flutter/material.dart';

class ChatConfig {
  final Color primaryColor;
  final TextStyle? messageTextStyle;

  const ChatConfig({
    this.primaryColor = Colors.blue,
    this.messageTextStyle,
  });
}
