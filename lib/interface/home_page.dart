import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/interface/list_page.dart';
import 'package:cash_flow_journal/interface/login_page.dart';
import 'package:cash_flow_journal/interface/widget/home_app_bar.dart';
import 'package:cash_flow_journal/interface/widget/line_chart.dart';
import 'package:cash_flow_journal/interface/widget/pie_chart.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:cash_flow_journal/provider/home_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(apiService: ApiService()),
      child: Scaffold(
        body: Consumer<HomeProvider>(
          builder: (context, snapshot, child) {
            if (snapshot.state == ResultState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.state == ResultState.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      HomeAppBar(),
                      PieChartWidget(),
                      LineChartWidget(),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Terjadi Kesalahan Silahkan Login Ulang'),
                    ElevatedButton(
                      onPressed: () async {
                        final authProvider =
                            Provider.of<AuthenticationProvider>(context,
                                listen: false);
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
          },
        ),
      ),
    );
  }
}
