import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

class ChatNotifier extends ChangeNotifier {
  final ChatService _chatService;

  ChatNotifier(this._chatService);

  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();
    _messages = await _chatService.fetchMessages();
    _isLoading = false;
    notifyListeners();
  }

  /// Gönderici bilgileri sabit olarak veriliyor; dinamik hale getirilebilir.
  void sendMessage(String content, {required String receiverID}) {
    final String currentUserID = "123456";
    final String currentPhoneNumber = "5555555555";

    final newMessage = ChatMessage(
      senderID: currentUserID,
      senderPhoneNumber: currentPhoneNumber,
      receiverID: receiverID,
      content: content,
      timestamp: DateTime.now(),
    );

    _chatService.sendMessage(newMessage);
    _messages.add(newMessage);
    notifyListeners();
  }
}
