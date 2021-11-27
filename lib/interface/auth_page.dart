import 'dart:html';

import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/constant/text_style.dart';
import 'package:cash_flow_journal/interface/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatelessWidget {
  static const routeName = "/AuthPage";
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitle(),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: textTheme.headline4?.apply(color: primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: 175,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Mulai',
                          style: textTheme.button,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          onPrimary: onPrimaryColor,
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
