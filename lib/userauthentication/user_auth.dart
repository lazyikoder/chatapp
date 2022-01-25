import 'package:chatapp/services/database_method.dart';
import 'package:chatapp/services/shared_preference_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> userLoginWithEmailAndPassword(
      String userLoginEmail, String userLoginPassword) async {
    SharedPreferenceService _sharedPreferenceService =
        SharedPreferenceService();
    bool isUserLoggedIn = false;
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: userLoginEmail, password: userLoginPassword);
      User? user = userCredential.user;
      if (user != null) {
        Map<String, dynamic> usermap = {
          "username": user.displayName as String,
          "email": userLoginEmail,
          "password": userLoginPassword,
        };
        // Constants.usermap = usermap;
        // print("For Debugg..");
        isUserLoggedIn = await _sharedPreferenceService.saveUserData(usermap);
        // globalUSERNAME = user.displayName ?? "";
        // globalEMAIL = userLoginEmail;
        // globalUSERPASSWORD = userLoginPassword;
        // isUserLoggedIn = true;
        // ignore: avoid_print
        print("User login successfully...");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return isUserLoggedIn;
  }

  Future<bool> userSignUpWithEmailAndPassword(
      Map<String, dynamic> userSignUpInfo) async {
    bool isUserLoggedIn = false;
    try {
      SharedPreferenceService _sharedPreferenceService =
          SharedPreferenceService();
      DataBaseMethod dataBaseMethod = DataBaseMethod();
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: userSignUpInfo['email'],
              password: userSignUpInfo['password']);
      User? user = userCredential.user;
      if (user != null) {
        userSignUpInfo.addAll({
          "status": "unavailable",
        });
        user.updateDisplayName(userSignUpInfo['name']);
        await dataBaseMethod.storeUserDataOnSignUp(userSignUpInfo, user.uid);

        isUserLoggedIn = await _sharedPreferenceService.saveUserData(
          {
            "username": userSignUpInfo['name'],
            "email": userSignUpInfo['email'],
            "password": userSignUpInfo['password'],
          },
        );
        // globalUSERNAME = userSignUpInfo['name'];
        // globalEMAIL = userSignUpInfo['email'];
        // globalUSERPASSWORD = userSignUpInfo['password'];
        // print("User created successfully...");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return isUserLoggedIn;
  }

  Future<bool> userLogOut() async {
    bool isUserLogOut = false;
    try {
      SharedPreferenceService preferenceService = SharedPreferenceService();
      preferenceService.removeUserData();
      _firebaseAuth.signOut();
      isUserLogOut = true;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return isUserLogOut;
  }
}
