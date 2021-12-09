import 'dart:ui';
import 'dart:isolate';

import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static const HEADER_TOKEN = 'HEADER_TOKEN';
  static SendPort? _uiSendPort;

  String get isolateName => _isolateName;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final prefs = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    String? _headerToken =
        await FirebaseAuth.instance.currentUser?.getIdToken();
    prefs.setString(HEADER_TOKEN, _headerToken ?? 'null');
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
