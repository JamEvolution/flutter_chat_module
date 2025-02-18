import 'package:chat_module/chat_module.dart'; // Paket dışa açılan API
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Module Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatExamplePage(),
    );
  }
}

class ChatExamplePage extends StatelessWidget {
  const ChatExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatView(receiverID: "654321"),
    );
  }
}
