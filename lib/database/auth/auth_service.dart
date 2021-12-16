import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cash_flow_journal/helper/background_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const HEADER_TOKEN = 'HEADER_TOKEN';

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      String? _headerToken =
          await FirebaseAuth.instance.currentUser?.getIdToken();
      prefs.setString(HEADER_TOKEN, _headerToken ?? 'null');
      tokenScheduling();
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
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final prefs = await SharedPreferences.getInstance();
      String? _headerToken =
          await FirebaseAuth.instance.currentUser?.getIdToken();
      prefs.setString(HEADER_TOKEN, _headerToken ?? 'null');
      tokenScheduling();
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

  bool getStatusAuth() {
    if (firebaseAuth.currentUser?.uid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getHeaderToken() async {
    final prefs = await SharedPreferences.getInstance();
    final _headerToken = prefs.getString(HEADER_TOKEN);
    return _headerToken;
  }

  Future<void> userSignOut() async {
    await AndroidAlarmManager.cancel(5);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(HEADER_TOKEN);
    await firebaseAuth.signOut();
  }

  Future tokenScheduling() async {
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 30),
      5,
      BackgroundService.callback,
      startAt: DateTime.now(),
      exact: true,
      wakeup: true,
    );
  }
}
