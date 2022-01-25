import 'dart:async';

import 'package:chatapp/globals/global_variables.dart';
import 'package:chatapp/pages/chat_room_page.dart';
import 'package:chatapp/pages/user_login_page.dart';
import 'package:chatapp/services/check_connection.dart';
import 'package:chatapp/services/shared_preference_service.dart';
import 'package:chatapp/userauthentication/user_auth.dart';
import 'package:flutter/material.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({Key? key}) : super(key: key);

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  final Authentication _authentication = Authentication();
  late SharedPreferenceService _sharedPreferenceService;
  // late CheckConnectivity _checksConnectivity;
  bool isDataAvailable = false;
  Map internetConnection = {};
  @override
  void initState() {
    super.initState();
    _sharedPreferenceService = SharedPreferenceService();
    // _checkConnectivity = CheckConnectivity.instance;
    // _checkConnectivity.initialise();
    // _checkConnectivity.myStream.listen((source) {
    //   setState(() {
    //     internetConnection = source;
    //   });
    // });

    Timer(const Duration(seconds: 5), () {});
    isUserDataAvailable();
  }

  void isUserDataAvailable() async {
    isDataAvailable = await _sharedPreferenceService.getUserData();
    // print("For debugg...");
    if (isDataAvailable) {
      if (globalEMAIL != null || globalUSERPASSWORD != null) {
        _authentication.userLoginWithEmailAndPassword(
          globalEMAIL!,
          globalUSERPASSWORD!,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatRoom(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
