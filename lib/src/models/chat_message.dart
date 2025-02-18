class ChatMessage {
  final String senderID;
  final String senderPhoneNumber;
  final String receiverID;
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.senderID,
    required this.senderPhoneNumber,
    required this.receiverID,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderID: json['senderID'],
      senderPhoneNumber: json['senderPhoneNumber'],
      receiverID: json['receiverID'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'senderPhoneNumber': senderPhoneNumber,
      'receiverID': receiverID,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
