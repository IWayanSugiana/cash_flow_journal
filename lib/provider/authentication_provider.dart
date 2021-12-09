import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService authService;

  AuthenticationProvider({required this.authService}) {
    _getStatusAuth();
  }

  late ResultState _state;
  late bool _status;

  ResultState get state => _state;
  bool get status => _status;

  _getStatusAuth() {
    _state = ResultState.isLoading;
    notifyListeners();
    _status = authService.getStatusAuth();
    _state = ResultState.hasData;
    notifyListeners();
  }

  Future<String?> userSignIn(String email, String password) async {
    final result = await authService.signIn(email, password);
    _getStatusAuth();
    return result;
  }

  Future<void> userLogOut() async {
    await authService.userSignOut();
    _getStatusAuth();
  }
}
