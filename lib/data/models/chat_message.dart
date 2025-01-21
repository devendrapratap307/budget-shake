// // lib/data/models/chat_message.dart
// class ChatMessage {
//   final String sender;
//   final String message;
//   final DateTime timestamp;
//
//   ChatMessage({
//     required this.sender,
//     required this.message,
//     required this.timestamp,
//   });
//
//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     return ChatMessage(
//       sender: json['sender'],
//       message: json['message'],
//       timestamp: DateTime.parse(json['timestamp']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'sender': sender,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String sender,
    required String message,
    required DateTime timestamp,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

