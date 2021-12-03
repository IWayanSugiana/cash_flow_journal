import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const HEADER_TOKEN = 'HEADER_TOKEN';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _setHeaderToken();
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _setHeaderToken();
      return 'Login Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future _setHeaderToken() async {
    final prefs = await SharedPreferences.getInstance();

    String? _headerToken =
        await FirebaseAuth.instance.currentUser?.getIdToken();
    prefs.setString(HEADER_TOKEN, _headerToken!);
  }

  Future<String?> getHeaderToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(HEADER_TOKEN);
  }

  bool getUserStatus() {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> userSignOut() async {
    await firebaseAuth.signOut();
  }
}
