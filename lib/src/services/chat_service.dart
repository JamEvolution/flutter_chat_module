import '../models/chat_message.dart';
import '../models/user.dart';

class ChatService {
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      User(
        userID: "123456",
        userPhoneNumber: "5555555555",
        userName: "Murat",
      ),
      User(
        userID: "654321",
        userPhoneNumber: "5555555554",
        userName: "Yunus",
      ),
    ];
  }

  Future<List<ChatMessage>> fetchMessages() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ChatMessage(
        senderID: "123456",
        senderPhoneNumber: "5555555555",
        receiverID: "654321",
        content: "Merhaba!",
        timestamp: DateTime.now(),
      ),
      ChatMessage(
        senderID: "654321",
        senderPhoneNumber: "5555555554",
        receiverID: "123456",
        content: "Selam!",
        timestamp: DateTime.now(),
      ),
    ];
  }

  void sendMessage(ChatMessage message) {
    // Burada API çağrısı veya sunucuya gönderim yapılabilir.
    print("Sending message: ${message.toJson()}");
  }
}
