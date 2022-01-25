import 'package:chatapp/pages/chat_room_page.dart';
import 'package:chatapp/pages/user_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth.currentUser != null
        ? const ChatRoom()
        : const LoginPage();
  }
}
