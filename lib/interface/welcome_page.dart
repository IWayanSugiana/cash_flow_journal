import 'package:animate_do/animate_do.dart';
import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/constant/text_style.dart';
import 'package:cash_flow_journal/interface/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = "/WelcomePage";
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppTitle(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideInRight(
                        child: const Greeting(),
                        from: size.width + 10,
                        delay: const Duration(seconds: 1),
                        duration: const Duration(seconds: 2),
                      ),
                      SlideInRight(
                        child: const Padding(
                          padding: EdgeInsets.only(top: 24.0, bottom: 48),
                          child: Message(),
                        ),
                        from: size.width + 10,
                        delay: const Duration(seconds: 2),
                        duration: const Duration(seconds: 2),
                      ),
                    ],
                  ),
                ),
                FadeIn(
                  child: Center(
                    child: SizedBox(
                      width: 175,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        },
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
                  delay: const Duration(seconds: 4),
                  duration: const Duration(seconds: 2),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Cash Flow\nJournal',
          style: textTheme.headline5
              ?.copyWith(fontWeight: FontWeight.w700, color: primaryColor),
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'Ayo mulai perjalanan\njournaling keuanganmu\nbersama ',
          style: textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w200,
            color: const Color.fromRGBO(116, 116, 116, 1),
            fontStyle: FontStyle.italic,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Cash Flow Journal',
              style: textTheme.headline6?.apply(
                color: primaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ]),
    );
  }
}

class Greeting extends StatelessWidget {
  const Greeting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Selamat Datang',
        style: textTheme.headline4
            ?.apply(color: onBackgroundColor, fontWeightDelta: 3),
        children: <TextSpan>[
          TextSpan(
            text: '\ndi ',
            style: textTheme.headline4?.apply(
              color: onBackgroundColor,
            ),
          ),
          TextSpan(
            text: 'Cash Flow Journal.',
            style: textTheme.headline4?.apply(
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
