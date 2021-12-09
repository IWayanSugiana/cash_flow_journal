import 'package:cash_flow_journal/interface/home_page.dart';
import 'package:cash_flow_journal/interface/welcome_page.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageHelper extends StatelessWidget {
  const PageHelper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.status) {
          return HomePage();
        } else {
          return WelcomePage();
        }
      },
    );
  }
}
