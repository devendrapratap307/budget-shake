// lib/core/services/firebase_service.dart

import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}

