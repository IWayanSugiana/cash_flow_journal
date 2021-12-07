import 'dart:ui';
import 'dart:isolate';

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
    // final AuthService authService = AuthService();
    // final prefs = await SharedPreferences.getInstance();

    // String? _headerToken =
    //     await FirebaseAuth.instance.currentUser?.getIdToken();
    // prefs.setString(HEADER_TOKEN, _headerToken ?? 'null');
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
