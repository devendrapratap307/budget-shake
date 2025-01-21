// lib/core/services/websocket_service.dart
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  Stream<dynamic> get messages => _channel!.stream;

  void sendMessage(String message) {
    _channel!.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
