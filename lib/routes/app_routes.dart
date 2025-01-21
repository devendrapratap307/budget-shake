// lib/routes/app_routes.dart
import 'package:flutter/material.dart';

import '../ui/screens/chat_room_screen.dart';
import '../ui/screens/login_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const chatList = '/chat-list';
  static const chatRoom = '/chat-room';

  static final routes = <String, WidgetBuilder>{
    login: (_) => LoginScreen(),
    // signup: (_) => SignupScreen(),
    // home: (_) => HomeScreen(),
    // chatList: (_) => ChatListScreen(),
    chatRoom: (_) => ChatScreen(),
  };
}


