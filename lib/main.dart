import 'dart:io';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/helper/background_service.dart';
import 'package:cash_flow_journal/helper/page_helper.dart';
import 'package:cash_flow_journal/helper/router_helper.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BackgroundService _backgroundService = BackgroundService();
  _backgroundService.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(authService: AuthService()),
      child: MaterialApp(
        title: 'Cash Flow Journal',
        theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
        home: PageHelper(),
        routes: routes,
      ),
    );
  }
}
