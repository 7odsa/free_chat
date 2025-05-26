import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseHelpers {
  static Future<bool> createNewUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print("ERROR   $e");
      return false;
    }
    return true;
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('LOOOOOOOOOOOOOOOOOOOOOOOOL signedIN');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print('a77777777777777777777777777a ');
      return false;
    }
    return true;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
