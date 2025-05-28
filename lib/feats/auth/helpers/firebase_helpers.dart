import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseHelpers {
  static final _firebase = FirebaseAuth.instance;
  static Future<String?> createNewUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final id = credential.user!.uid;
      return id;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print("ERROR   $e");
      return null;
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      final credential = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('LOOOOOOOOOOOOOOOOOOOOOOOOL signedIN');

      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print('a77777777777777777777777777a ');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _firebase.signOut();
  }
}
