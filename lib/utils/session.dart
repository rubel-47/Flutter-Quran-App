import 'package:nb_utils/nb_utils.dart';
import 'package:qrf/model/user/user..dart';

import 'constant.dart';

class SessionManager {
  //set login to true or false
  Future<void> setIsLogin(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PREFS_ISLOGIN, isLogin);
  }

  //fcm token
  Future<bool> getIsLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(PREFS_ISLOGIN) ?? false;
  }

//set data into shared preferences like this
  Future<void> saveUserInfo(UserData response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
/*     prefs.setBool(PREFS_ISLOGIN, true);
 */
    prefs.setInt(PREFS_USERID, response.id ?? 0);
    prefs.setString(PREFS_NAME, response.name ?? "");
    prefs.setString(PREFS_EMAIL, response.email ?? "");
    prefs.setString(PREFS_MOBILE, response.mobile ?? "");
    prefs.setString(PREFS_ADDRESS, response.address ?? "");
  }

//get value from shared preferences
  Future<UserData> getUserInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String _name, _email, _mobile, _address;
    int _userId;

    _userId = pref.getInt(PREFS_USERID) ?? 0;
    _name = pref.getString(PREFS_NAME) ?? "";
    _email = pref.getString(PREFS_EMAIL) ?? "";
    _mobile = pref.getString(PREFS_MOBILE) ?? "";
    _address = pref.getString(PREFS_ADDRESS) ?? "";

    UserData login = UserData(
        id: _userId,
        name: _name,
        email: _email,
        mobile: _mobile,
        address: _address);

    return login;
  }
}
