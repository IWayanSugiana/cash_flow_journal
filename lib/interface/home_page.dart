import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ini Home'),
            ElevatedButton(
                onPressed: () {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .userLogOut();
                },
                child: Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
