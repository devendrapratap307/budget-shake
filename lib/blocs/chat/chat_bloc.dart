// // lib/blocs/chat/chat_bloc.dart
// import 'dart:async';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/models/chat_message.dart';
// import '../../data/repositories/chat_repository.dart';
// import 'chat_event.dart';
// import 'chat_state.dart';
//
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final ChatRepository _chatRepository;
//   StreamSubscription<ChatMessage>? _messageSubscription;
//
//   ChatBloc(this._chatRepository) : super(ChatInitial()) {
//     on<ConnectToWebSocket>(_onConnectToWebSocket);
//     on<SendMessage>(_onSendMessage);
//     on<ReceiveMessage>(_onReceiveMessage);
//   }
//
//   void _onConnectToWebSocket(ConnectToWebSocket event, Emitter<ChatState> emit) async {
//     emit(ChatLoading());
//     try {
//       _chatRepository.connectToWebSocket(event.url);
//       _messageSubscription = _chatRepository.receiveMessages().listen((message) {
//         add(ReceiveMessage(message));
//       });
//       emit(ChatLoaded([]));
//     } catch (e) {
//       emit(ChatError(e.toString()));
//     }
//   }
//
//   void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
//     _chatRepository.sendMessage(event.message);
//   }
//
//   void _onReceiveMessage(ReceiveMessage event, Emitter<ChatState> emit) {
//     if (state is ChatLoaded) {
//       final updatedMessages = List<ChatMessage>.from((state as ChatLoaded).messages)
//         ..add(event.message);
//       emit(ChatLoaded(updatedMessages));
//     }
//   }
//
//   @override
//   Future<void> close() {
//     _messageSubscription?.cancel();
//     _chatRepository.disconnectWebSocket();
//     return super.close();
//   }
// }


import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/models/chat_message.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore firestore;
  final WebSocketChannel channel;
  late StreamSubscription _socketSubscription;
  bool _isSocketConnected = false;

  // WebSocket server URL
  final String socketUrl = 'http://localhost:7076/ws';

  // Constructor
  ChatBloc(this.firestore)
      : channel = WebSocketChannel.connect(Uri.parse('http://localhost:7076/ws')),
        super(ChatInitial()) {
    // Listen for WebSocket messages
    _socketSubscription = channel.stream.listen((message) {
      // Assuming the WebSocket message is in a format like this: {"sender": "user1", "message": "hello"}
      final chatMessage = ChatMessage.fromJson(message as Map<String, dynamic>);
      add(ReceiveMessage(chatMessage));  // Add the message to the BLoC event
    });

    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        final snapshot = await firestore.collection('messages').orderBy('timestamp').get();
        final messages = snapshot.docs
            .map((doc) => ChatMessage.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(ChatLoaded(messages));
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        final chatMessage = ChatMessage(
          id: DateTime.now().toString(), // Use a timestamp for unique ID
          sender: event.sender,
          message: event.message,
          timestamp: DateTime.now(),
        );

        // Add message to Firestore
        await firestore.collection('messages').add(chatMessage.toJson());

        // Send message via WebSocket
        channel.sink.add(chatMessage.toJson());

        // Emit updated state to load messages
        add(LoadMessages());
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    // Listen for messages from WebSocket and add them to the state
    on<ReceiveMessage>((event, emit) {
      if (state is ChatLoaded) {
        final currentState = state as ChatLoaded;
        final updatedMessages = List<ChatMessage>.from(currentState.messages)..add(event.chatMessage);
        emit(ChatLoaded(updatedMessages));
      }
    });
  }

  // Close the WebSocket connection when the BLoC is disposed
  @override
  Future<void> close() {
    _socketSubscription.cancel();
    return super.close();
  }
}


