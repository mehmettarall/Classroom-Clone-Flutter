import 'package:firebase_auth/firebase_auth.dart';

import '../data/custom_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _convertUser(User? user) {
    if (user == null) {
      return null;
    } else {
      return CustomUser(uid: user.uid, email: user.email);
    }
  }

  Stream<CustomUser?> get streamUser {
    return _auth.authStateChanges().map((User? user) => _convertUser(user));
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future registerStudent(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _convertUser(user);
    } catch (e) {
      print("Error in registering");
      return null;
    }
  }

  Future loginStudent(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _convertUser(user);
    } catch (e) {
      print("Error in login");
      return null;
    }
  }
}
