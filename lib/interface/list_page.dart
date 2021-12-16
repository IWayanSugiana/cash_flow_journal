import 'package:cash_flow_journal/helper/currency_helper.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/interface/detail_page.dart';
import 'package:cash_flow_journal/interface/widget/custom_app_bar.dart';
import 'package:cash_flow_journal/provider/expenses_provider.dart';
import 'package:cash_flow_journal/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: 'History'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [Tab(text: 'Expenses'), Tab(text: 'Incomes')],
                        labelColor: Colors.black,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          expensesTab(),
                          incomesTab(),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget incomesTab() {
    return Consumer<IncomesProvider>(
      builder: (context, snapshot, _) {
        if (snapshot.state == ResultState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: snapshot.incomes.count,
            itemBuilder: (context, index) {
              final data = snapshot.incomes.data[index].detail;
              return ListTile(
                onTap: () {
                  final data =
                      snapshot.getDetailData(snapshot.incomes.data[index].id);
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    context: context,
                    builder: (context) {
                      return DetailPage(
                        data: data,
                        type: "Income",
                      );
                    },
                  );
                },
                title: const Text("Income"),
                subtitle: Text(data.categoryType),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(
                            DateTime.fromMillisecondsSinceEpoch(
                              data.createdAt.seconds * 1000,
                            ),
                          )
                          .toString(),
                    ),
                    Text(CurrencyHelper.format(data.amount))
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }

  Widget expensesTab() {
    return Consumer<ExpensesProvider>(
      builder: (context, snapshot, _) {
        if (snapshot.state == ResultState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: snapshot.expenses.count,
            itemBuilder: (context, index) {
              final data = snapshot.expenses.data[index].detail;
              return ListTile(
                onTap: () {
                  final data =
                      snapshot.getDetailData(snapshot.expenses.data[index].id);
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    context: context,
                    builder: (context) {
                      return DetailPage(
                        data: data,
                        type: "Expense",
                      );
                    },
                  );
                },
                title: const Text("Expense"),
                subtitle: Text(data.categoryType),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy')
                          .format(
                            DateTime.fromMillisecondsSinceEpoch(
                              data.createdAt.seconds * 1000,
                            ),
                          )
                          .toString(),
                    ),
                    Text(CurrencyHelper.format(data.amount))
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
