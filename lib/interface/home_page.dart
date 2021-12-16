import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/currency_helper.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/interface/login_page.dart';
import 'package:cash_flow_journal/interface/widget/home_app_bar.dart';
import 'package:cash_flow_journal/interface/widget/line_chart.dart';
import 'package:cash_flow_journal/interface/widget/pie_chart.dart';
import 'package:cash_flow_journal/provider/authentication_provider.dart';
import 'package:cash_flow_journal/provider/home_provider.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HomeAppBar(),
                const TabBar(
                  tabs: [
                    Tab(text: 'Monthly Statistic'),
                    Tab(text: 'Yearly Statistic')
                  ],
                  labelColor: Colors.black,
                ),
                Expanded(
                  child: TabBarView(children: [
                    monthlyStatisticChart(),
                    yearlyStatisticChart(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget monthlyStatisticChart() {
    return Consumer<HomeProvider>(
      builder: (context, snapshot, child) {
        if (snapshot.state == ResultState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.state == ResultState.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                PieChartWidget(
                  expensesTotal: snapshot.expenseTotalMonth,
                  incomesTotal: snapshot.incomesTotalMonth,
                  title: 'Monthly Statistic',
                  subTitle: snapshot.resultMonth.month,
                ),
                statisticOverall(
                  snapshot.expenseTotalMonth,
                  snapshot.incomesTotalMonth,
                  snapshot.expensesAvgMonth,
                  snapshot.incomesAvgMonth,
                  snapshot.mostExpenseTypeMonth,
                )
              ],
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
                    final authProvider = Provider.of<AuthenticationProvider>(
                        context,
                        listen: false);
                    await authProvider.userLogOut();
                    if (authProvider.status != true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false);
                    }
                  },
                  child: const Text('Log Out'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

Widget yearlyStatisticChart() {
  return Consumer<HomeProvider>(
    builder: (context, snapshot, child) {
      if (snapshot.state == ResultState.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.state == ResultState.hasData) {
        return SingleChildScrollView(
          child: Column(
            children: [
              PieChartWidget(
                expensesTotal: snapshot.expensesTotal,
                incomesTotal: snapshot.incomesTotal,
                title: 'Yearly Statistic,',
                subTitle: snapshot.resultYear.year.toString(),
              ),
              LineChartWidget(
                statisticData: snapshot.resultYear,
                incomesTotal: snapshot.incomesTotal,
                expensesTotal: snapshot.expensesTotal,
              ),
              statisticOverall(
                snapshot.expensesTotal,
                snapshot.incomesTotal,
                snapshot.expensesAvg,
                snapshot.incomesAvg,
                snapshot.mostExpenseType,
              )
            ],
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
                  final authProvider = Provider.of<AuthenticationProvider>(
                      context,
                      listen: false);
                  await authProvider.userLogOut();
                  if (authProvider.status != true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.routeName, (route) => false);
                  }
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        );
      }
    },
  );
}

Widget statisticOverall(
  double expensesTotal,
  double incomesTotal,
  double expensesAvg,
  double incomesAvg,
  String mostExpenseType,
) {
  return Column(
    children: [
      ListTile(
        title: const Text('Total expense amount'),
        trailing: Text(CurrencyHelper.format(expensesTotal)),
      ),
      ListTile(
        title: const Text('Total income amount'),
        trailing: Text(CurrencyHelper.format(incomesTotal)),
      ),
      ListTile(
        title: const Text('Avg expense'),
        trailing: Text(CurrencyHelper.format(expensesAvg)),
      ),
      ListTile(
        title: const Text('Avg income'),
        trailing: Text(CurrencyHelper.format(incomesAvg)),
      ),
      ListTile(
        title: const Text('Most types of expenses'),
        trailing: Text(mostExpenseType),
      )
    ],
  );
}
