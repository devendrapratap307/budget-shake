import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_event.dart';
import '../../blocs/chat/chat_state.dart';
import '../../data/models/chat_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Fallback values if arguments are null
    final roomName = args?['roomName'] ?? 'Unknown Room';
    final tabIndex = args?['tabIndex'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room - $roomName'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  'Welcome to $roomName',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tab: $tabIndex',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true, // Show latest messages at the bottom
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      bool isSender = message.sender == 'User1'; // Customize this check

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                        child: Align(
                          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              color: isSender ? Colors.deepPurple[200] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.sender,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: isSender ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  message.message,
                                  style: TextStyle(fontSize: 16, color: isSender ? Colors.white : Colors.black87),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _formatTimestamp(message.timestamp),
                                  style: TextStyle(fontSize: 12, color: isSender ? Colors.white70 : Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return const Center(child: Text('No messages'));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    onSubmitted: (text) {
                      final message = ChatMessage(
                        sender: 'User1',
                        message: text,
                        timestamp: DateTime.now(), id: '',
                      );
                      // context.read<ChatBloc>().add(SendMessage(message as String));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    final message = ChatMessage(
                      sender: "User1",
                      message: "Example message", // Get the text from the TextField
                      timestamp: DateTime.now(), id: "",
                    );
                    // context.read<ChatBloc>().add(SendMessage(message as String);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 25,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour;
    final minute = timestamp.minute;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../blocs/chat/chat_bloc.dart';
// import '../../blocs/chat/chat_event.dart';
// import '../../blocs/chat/chat_state.dart';
//
// class ChatScreen extends StatelessWidget {
//   ChatScreen({super.key});
//   final TextEditingController _messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ChatBloc(context as ChatState)..add(LoadMessages()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Chat App"),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   if (state is ChatLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is ChatLoaded) {
//                     return ListView.builder(
//                       itemCount: state.messages.length,
//                       itemBuilder: (context, index) {
//                         final message = state.messages[index];
//                         return ListTile(
//                           title: Text(message.sender),
//                           subtitle: Text(message.message),
//                           trailing: Text(
//                             message.timestamp.toLocal().toString(),
//                           ),
//                         );
//                       },
//                     );
//                   } else if (state is ChatError) {
//                     return Center(child: Text("Error: ${state.error}"));
//                   }
//                   return const SizedBox();
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: "Enter a message",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () {
//                       final message = _messageController.text.trim();
//                       if (message.isNotEmpty) {
//                         BlocProvider.of<ChatBloc>(context).add(SendMessage("User", message));
//                         _messageController.clear();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
