import 'package:chatapp/globals/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
// late UserLoginModel userLoggedIn;

class SharedPreferenceService {
  // SharedPreferences _sharedPreferences;
  final String _sharedPreferenceUserKey = "username";
  final String _sharedPreferencePwdKey = "password";
  final String _sharedPreferenceEmailKey = "email";

  _getInstance() async {
    return SharedPreferences.getInstance();
  }

  // UserLoginModel saveDataGlobally(Map<String, dynamic> map) {
  //   return UserLoginModel(
  //     username: map['username'],
  //     email: map['email'],
  //     password: map['password'],
  //   );
  // }

  Future<bool> saveUserData(Map<String, dynamic> map) async {
    //UserLoginModel user;
    SharedPreferences _prefs = await _getInstance();
    _prefs.setString(_sharedPreferenceUserKey, map['username']);
    _prefs.setString(_sharedPreferenceEmailKey, map['email']);
    _prefs.setString(_sharedPreferencePwdKey, map['password']);

    getUserData();
    // user = UserLoginModel.formMap(map);
    // userLoggedIn = user;
    // return user;
    return true;
  }

  Future<bool> getUserData() async {
    // UserLoginModel user;
    SharedPreferences _prefs = await _getInstance();
    globalUSERNAME = _prefs.getString(_sharedPreferenceUserKey);
    globalEMAIL = _prefs.getString(_sharedPreferenceEmailKey);
    globalUSERPASSWORD = _prefs.getString(_sharedPreferencePwdKey);

    // Constants.usermap = map;
    // user = UserLoginModel.formMap(map); //saveDataGlobally(map);
    // userLoggedIn = user;
    return true;
  }

  Future<bool> removeUserData() async {
    SharedPreferences _prefs = await _getInstance();
    // Constants.usermap.clear();
    _prefs.remove(_sharedPreferenceUserKey);
    _prefs.remove(_sharedPreferenceEmailKey);
    _prefs.remove(_sharedPreferencePwdKey);
    return true;
  }
}
