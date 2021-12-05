import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/helper/router_helper.dart';
import 'package:cash_flow_journal/interface/home_page.dart';
import 'package:cash_flow_journal/interface/welcome_page.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider(authService: AuthService()))
      ],
      child: MaterialApp(
        title: 'Cash Flow Journal',
        theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const WelcomePage();
            }
          },
        ),
        routes: routes,
      ),
    );
  }
}
