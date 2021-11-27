import 'package:cash_flow_journal/constant/colors.dart';
import 'package:cash_flow_journal/constant/text_style.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = "/WelcomePage";
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Cash Flow Journal",
            style: textTheme.headline5
                ?.apply(color: primaryColor, fontWeightDelta: 3),
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Greeting(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Message(),
                    ),
                  ],
                ),
              ),
              Center(
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
              )
            ],
          ),
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
        text: 'Ayo mulai perjalanan\n',
        style: textTheme.headline6?.apply(
          color: onBackgroundColor,
          fontWeightDelta: -2,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'journaling ',
            style: textTheme.headline6?.apply(
              color: onBackgroundColor,
              fontStyle: FontStyle.italic,
              fontWeightDelta: 3,
            ),
          ),
          TextSpan(
            text: 'keuanganmu\n',
            style: textTheme.headline6?.apply(
              color: onBackgroundColor,
            ),
          ),
          TextSpan(
            text: 'Catat dan analisa',
            style: textTheme.headline6?.apply(
              backgroundColor: primaryVariantColor,
              color: onPrimaryVariantColor,
            ),
          ),
          TextSpan(
            text: ' keuanganmu\n',
            style: textTheme.headline6?.apply(
              color: onBackgroundColor,
            ),
          ),
          TextSpan(
            text: 'bersama ',
            style: textTheme.headline6?.apply(
              color: onBackgroundColor,
            ),
          ),
          TextSpan(
            text: 'cashflow journal. ',
            style: textTheme.headline6?.apply(
              color: primaryColor,
              fontWeightDelta: 3,
            ),
          ),
        ],
      ),
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
        style: textTheme.headline5
            ?.apply(color: onBackgroundColor, fontWeightDelta: 3),
        children: <TextSpan>[
          TextSpan(
            text: '\ndi ',
            style: textTheme.headline5?.apply(
              color: onBackgroundColor,
            ),
          ),
          TextSpan(
            text: 'Cash Flow Journal',
            style: textTheme.headline5?.apply(
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
