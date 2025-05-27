import 'package:free_chat/feats/auth/data/models/user_dm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _prefs = null;
  static Future<SharedPreferences> _getSharedpref() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  static void setUser(UserDM user) async {
    final prefs = await _getSharedpref();

    prefs.setString('id', user.id);
    prefs.setString('email', user.email);
    prefs.setString('imagePath', user.imagePath);
    prefs.setString('username', user.username);

    // ! For Now
  }

  static Future<UserDM?> getUser() async {
    final prefs = await _getSharedpref();

    final id = prefs.getString('id');
    final email = prefs.getString('email');
    final imagePath = prefs.getString('imagePath');
    final username = prefs.getString('username');

    if (id != null && email != null && username != null && imagePath != null) {
      return UserDM(
        id: id,
        username: username,
        email: email,
        imagePath: imagePath,
      );
    } else {
      return null;
    }
  }

  static Future<void> removeUser() async {
    final prefs = await _getSharedpref();
    prefs.clear();
  }
}
