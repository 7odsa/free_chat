import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_chat/feats/auth/data/models/user_dm.dart';

class FirestoreHelpres {
  final db = FirebaseFirestore.instance;
  final kUsersCollectionName = 'users';

  Future<void> addNewUser(UserDM user) async {
    await db.collection(kUsersCollectionName).doc(user.id).set({
      'name': user.username,
      'imagePath': user.imagePath,
      'email': user.email,
    });
  }

  Future<UserDM?> getUser(String userID) async {
    final doc = await db.collection(kUsersCollectionName).doc(userID).get();
    final data = doc.data();

    final user = UserDM(
      id: userID,
      username: data!['name'],
      email: data['email'],
      imagePath: data['imagePath'],
    );
    return user;
  }
}
