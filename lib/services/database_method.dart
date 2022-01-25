// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod {
  // late FirebaseFirestore _firebaseFirestore;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> storeUserDataOnSignUp(
    Map<String, dynamic> userInfo,
    String userDocId,
  ) async {
    bool isDataStore = false;
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userDocId)
          .set(userInfo)
          .then(
            (value) => isDataStore = true,
          );
      // ignore: avoid_print
      print("Data Stored Successfully...");
    } catch (e) {
      // ignore: avoid_print
      print(
        e.toString(),
      );
    }
    return isDataStore;
  }

  Future onUserSearch(String search) async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: search)
          .get();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future createChatRoom(String chatRoomId, chatRoomMap) async {
    try {
      FirebaseFirestore.instance
          .collection("ChatRoom")
          .doc(chatRoomId)
          .set(chatRoomMap);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future addMessagesList(String chatRoomId, messageMap) async {
    await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future getMessagesList(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy(
          "time",
          descending: false,
        )
        .snapshots();
  }

  Future getChatRoomList(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
