import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/chat_config.dart';
import '../models/chat_message.dart';
import '../notifiers/chat_notifier.dart';
import '../services/chat_service.dart';

/// Gelişmiş tasarımlı ChatView (StatefulWidget kullanılarak scroll kontrolü sağlanıyor)
class ChatView extends StatefulWidget {
  /// Sohbetin hangi kullanıcıyla yapıldığını belirtmek için alıcı ID'si
  final String receiverID;

  /// İsteğe bağlı tema ve stil ayarları
  final ChatConfig? config;

  const ChatView({
    super.key,
    required this.receiverID,
    this.config,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ScrollController _scrollController;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  /// Mesaj listesi güncellendiğinde en son mesaja kaydırır
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatNotifier>(
      create: (_) {
        final notifier = ChatNotifier(ChatService());
        notifier.loadMessages();
        return notifier;
      },
      child: Scaffold(
        body: Consumer<ChatNotifier>(
          builder: (context, notifier, child) {
            // Her frame sonunda scroll kontrolü için en sona kaydırıyoruz
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _scrollToBottom());
            return Column(
              children: [
                Expanded(
                  child: notifier.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: notifier.messages.length,
                          itemBuilder: (context, index) {
                            final message = notifier.messages[index];
                            // Burada, mevcut kullanıcı ID'si sabit "123456" olarak veriliyor.
                            // Gerçek uygulamada dinamik olarak alınmalı.
                            final bool isSentByMe =
                                message.senderID == "123456";
                            return ChatBubble(
                              message: message,
                              isSentByMe: isSentByMe,
                              config: widget.config,
                            );
                          },
                        ),
                ),
                _buildMessageInput(context),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Mesaj girişi için input alanı ve gönder butonu
  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Mesajınızı yazın...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              final text = _textController.text.trim();
              if (text.isNotEmpty) {
                Provider.of<ChatNotifier>(context, listen: false)
                    .sendMessage(text, receiverID: widget.receiverID);
                _textController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

/// Mesajların baloncuk şeklinde gösterildiği widget
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isSentByMe;
  final ChatConfig? config;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByMe,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isSentByMe
        ? (config?.primaryColor ?? Theme.of(context).colorScheme.primary)
            .withValues(alpha: 0.8)
        : Colors.grey.shade300;
    final textColor = isSentByMe ? Colors.white : Colors.black87;
    final alignment =
        isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final borderRadius = isSentByMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          // Karşı taraf mesajı ise gönderici bilgisi üstte gösterilir
          if (!isSentByMe)
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                message.senderPhoneNumber,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              message.content,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
          // Zaman bilgisi küçükçe altında gösterilir
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              "${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
