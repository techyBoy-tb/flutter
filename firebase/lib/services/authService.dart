import 'package:firebase/models/CustomUser.dart';
import 'package:firebase/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _getCustomUser(User? user) {
    return CustomUser(uid: user!.uid);
  }

  // Auth change user stream
  Stream<CustomUser?>? get user {
    return _auth.authStateChanges().map(_getCustomUser);
  }

  // Sign in Anon
  Future<CustomUser?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return CustomUser(uid: result.user!.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email/password
  Future<CustomUser?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return CustomUser(uid: result.user!.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Register with email/password
  Future<CustomUser?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      CustomUser user = CustomUser(uid: result.user!.uid);
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'New coffee user', 100);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return;
    }
  }
}
