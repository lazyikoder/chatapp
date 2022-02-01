import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivity {
  CheckConnectivity._();

  static final _instance = CheckConnectivity._();
  static CheckConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);

    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class CheckConnectivity extends StatefulWidget {
//   const CheckConnectivity({Key? key}) : super(key: key);

//   @override
//   _CheckConnectivityState createState() => _CheckConnectivityState();
// }

// class _CheckConnectivityState extends State<CheckConnectivity> {
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   @override
//   void initState() {
//     initConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(updateConnectionState);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Network Status"),
//         ),
//         body: const Center(child: Text("FlutterAnt.com")));
//   }

//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print("Error Occurred: ${e.toString()} ");
//       return;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//     return updateConnectionState(result);
//   }

//   Future<void> updateConnectionState(ConnectivityResult result) async {
//     if (result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.wifi) {
//       showStatus(result, true);
//     } else {
//       showStatus(result, false);
//     }
//   }

//   void showStatus(ConnectivityResult result, bool status) {
//     final snackBar = SnackBar(
//         content:
//             Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
//         backgroundColor: status ? Colors.green : Colors.red);
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
