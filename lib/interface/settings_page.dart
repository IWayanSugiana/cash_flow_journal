import 'package:cash_flow_journal/interface/login_page.dart';
import 'package:cash_flow_journal/interface/widget/custom_app_bar.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: 'Settings'),
          Text('Profile'),
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1501196354995-cbb51c65aaea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80"),
            radius: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthenticationProvider>(context, listen: false);
              await authProvider.userLogOut();
              if (authProvider.status != true) {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              }
            },
            child: Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
