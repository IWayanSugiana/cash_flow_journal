import 'package:cash_flow_journal/api/auth/service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService authService;

  AuthenticationProvider({required this.authService}) {
    _getUserAuthentication();
  }

  late ResultState _state;

  ResultState get state => _state;

  void _getUserAuthentication() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final status = authService.getUserStatus();
    if (status) {
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.noData;
      notifyListeners();
    }
  }

  Future<String?> userSignIn(String email, String password) async {
    final result = await authService.signIn(email, password);
    _getUserAuthentication();
    return result;
  }

  Future<void> userLogOut() async {
    await authService.userSignOut();
    _getUserAuthentication();
  }
}
