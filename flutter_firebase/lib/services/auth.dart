import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result?.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email/password
  Future<void> signInWithEmail(String email, String password) async {}

// Register with email/password
  Future<void> registerWithEmail(String email, String password) async {}

// Sign out
  Future<void> signOut() async {}
}
