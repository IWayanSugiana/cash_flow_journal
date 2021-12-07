import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService authService;

  AuthenticationProvider({required this.authService});

  late ResultState _state;

  ResultState get state => _state;

  Future<String?> userSignIn(String email, String password) async {
    final result = await authService.signIn(email, password);
    return result;
  }

  Future<void> userLogOut() async {
    await authService.userSignOut();
  }
}
