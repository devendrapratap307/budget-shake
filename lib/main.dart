// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:outlayshake/routes/app_routes.dart';
//
// import 'blocs/auth/auth_bloc.dart';
// import 'blocs/chat/chat_bloc.dart';
// import 'cores/services/firebase_service.dart';
// import 'cores/services/websocket_service.dart';
// import 'data/repositories/auth_repository.dart';
// import 'data/repositories/chat_repository.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FirebaseService.initialize();
//
//   final webSocketService = WebSocketService();
//   final chatRepository = ChatRepository(webSocketService);
//   final authRepository = AuthRepository();
//
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => ChatBloc(chatRepository)),
//         BlocProvider(create: (_) => AuthBloc(authRepository)),
//       ],
//       child: MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Unique Chat App',
//       initialRoute: AppRoutes.login,
//       routes: AppRoutes.routes,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outlayshake/data/repositories/auth_repository.dart';
import 'package:outlayshake/ui/screens/chat_room_screen.dart';
import 'package:outlayshake/ui/screens/header_screen.dart';

import 'blocs/chat/chat_bloc.dart';
import 'cores/services/websocket_service.dart';
import 'data/repositories/chat_repository.dart';

void main() {
  final webSocketService = WebSocketService();
  final chatRepository = ChatRepository(webSocketService);
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => ChatBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Outlake',
      initialRoute: '/',
      routes: {
        '/': (context) => const HeaderScreen(),
        '/chat-room': (context) => ChatScreen(), // Define the chat room screen here
      },
    );
  }
}
