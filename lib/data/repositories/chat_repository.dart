// lib/data/repositories/chat_repository.dart

import '../../cores/services/websocket_service.dart';
import '../models/chat_message.dart';

class ChatRepository {
  final WebSocketService _webSocketService;

  ChatRepository(this._webSocketService);

  Stream<ChatMessage> receiveMessages() {
    return _webSocketService.messages.map((data) {
      return ChatMessage.fromJson(data);
    });
  }

  void sendMessage(ChatMessage message) {
    _webSocketService.sendMessage(message.toJson() as String);
  }

  void connectToWebSocket(String url) {
    _webSocketService.connect(url);
  }

  void disconnectWebSocket() {
    _webSocketService.disconnect();
  }
}
