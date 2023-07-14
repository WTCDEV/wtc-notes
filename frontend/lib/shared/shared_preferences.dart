import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static Future<void> saveUserData(String username) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', username);
  }

  static Future<String?> readUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('username');
  }

  static Future<void> saveIdUser(int id_user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('id_user', id_user);
  }

  static Future<int?> readIdUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('id_user');
  }

}
