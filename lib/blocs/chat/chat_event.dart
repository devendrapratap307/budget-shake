// // // lib/blocs/chat/chat_event.dart
// //
// // import '../../data/models/chat_message.dart';
// //
// // abstract class ChatEvent {}
// //
// // class ConnectToWebSocket extends ChatEvent {
// //   final String url;
// //   ConnectToWebSocket(this.url);
// // }
// //
// // class SendMessage extends ChatEvent {
// //   final ChatMessage message;
// //   SendMessage(this.message);
// // }
// //
// // class ReceiveMessage extends ChatEvent {
// //   final ChatMessage message;
// //   ReceiveMessage(this.message);
// // }
//
import 'package:equatable/equatable.dart';
import '../../data/models/chat_message.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessage extends ChatEvent {
  final String sender;
  final String message;

  SendMessage(this.sender, this.message);

  @override
  List<Object> get props => [sender, message];
}

class LoadMessages extends ChatEvent {}

class ReceiveMessage extends ChatEvent {
  final ChatMessage chatMessage;
  ReceiveMessage(this.chatMessage);

  @override
  List<Object> get props => [chatMessage];
}



// import 'package:freezed_annotation/freezed_annotation.dart';
//
//
// @freezed
// class ChatState with _$ChatState {
//   const factory ChatState.initial() = ChatInitial;
//   const factory ChatState.loading() = ChatLoading;
//   const factory ChatState.loaded(List<ChatMessage> messages) = ChatLoaded;
//   const factory ChatState.error(String message) = ChatError;
// }

