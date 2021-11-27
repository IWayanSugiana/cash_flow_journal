import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/interface/auth_page.dart';
import 'package:cash_flow_journal/interface/welcome_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Flow Journal',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        AuthPage.routeName: (context) => const AuthPage(),
      },
    );
  }
}
