import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // REGISTER
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Register Error: $e");
      return null;
    }
  }

  // SIGN IN
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // CHANGE PASSWORD
  Future<bool> changePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
      return true;
    } catch (e) {
      print("Password Update Error: $e");
      return false;
    }
  }

  // CURRENT USER
  User? get currentUser => _auth.currentUser;
}