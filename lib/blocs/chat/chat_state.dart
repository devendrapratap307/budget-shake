// // lib/blocs/chat/chat_state.dart
//
// import '../../data/models/chat_message.dart';
//
// abstract class ChatState {}
//
// class ChatInitial extends ChatState {}
//
// class ChatLoading extends ChatState {}
//
// class ChatLoaded extends ChatState {
//   final List<ChatMessage> messages;
//
//   ChatLoaded(this.messages);
// }
//
// class ChatError extends ChatState {
//   final String error;
//
//   ChatError(this.error);
// }

import 'package:equatable/equatable.dart';
import '../../data/models/chat_message.dart';

abstract class ChatState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);

  @override
  List<Object> get props => [error];
}

