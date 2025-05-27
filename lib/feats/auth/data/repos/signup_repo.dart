import 'dart:io';

import 'package:free_chat/feats/auth/data/helpers/firebase_helpers.dart';
import 'package:free_chat/feats/auth/data/helpers/firestore_helpres.dart';
import 'package:free_chat/feats/auth/data/helpers/helpers.dart';
import 'package:free_chat/feats/auth/data/helpers/shared_pref.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';
// import 'package:path/path.dart' as path;

abstract class SignupRepo {
  static Future<UserDM?> signUp({
    required String email,
    required String password,
    required String username,
    required File image,
  }) async {
    final userId = await FirebaseHelpers.createNewUser(
      email: email,
      password: password,
    );
    if (userId == null) return null;

    // save image in dir and get the path
    File imageFile = await saveImageInAppDir(userId, image);

    print(imageFile.path);

    final user = UserDM(
      id: userId,
      username: username,
      email: email,
      imagePath: imageFile.path,
    );
    SharedPref.setUser(user);

    FirestoreHelpres().addNewUser(user);

    return user;
  }
}
