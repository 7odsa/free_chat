import 'package:free_chat/feats/auth/data/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/data/helpers/firestore_helpres.dart';
import 'package:free_chat/feats/auth/data/helpers/shared_pref.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';

class SigninRepo {
  static Future<UserDM?> signinRepo({
    required String email,
    required String password,
  }) async {
    final userId = await FirebaseHelpers.signIn(email, password);
    if (userId == null) return null;

    final user = await FirestoreHelpres().getUser(userId);

    if (user == null) return user;
    SharedPref.setUser(user);

    return user;
  }
}
