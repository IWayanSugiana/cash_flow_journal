import 'package:cash_flow_journal/interface/login_page.dart';
import 'package:cash_flow_journal/interface/home_page.dart';
import 'package:cash_flow_journal/interface/welcome_page.dart';

final routes = {
  WelcomePage.routeName: (context) => const WelcomePage(),
  LoginPage.routeName: (context) => const LoginPage(),
  HomePage.routeName: (context) => const HomePage(),
};
