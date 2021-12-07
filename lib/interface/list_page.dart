import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/provider/expenses_provider.dart';
import 'package:cash_flow_journal/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpensesProvider>(
          create: (_) => ExpensesProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<IncomesProvider>(
          create: (_) => IncomesProvider(apiService: ApiService()),
        )
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Column(
              children: [
                const TabBar(
                  tabs: [Tab(text: 'Expenses'), Tab(text: 'Incomes')],
                  labelColor: Colors.black,
                ),
                Expanded(
                  child: TabBarView(children: [
                    Consumer<ExpensesProvider>(
                      builder: (context, snapshot, _) {
                        if (snapshot.state == ResultState.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.state == ResultState.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.expenses.count,
                            itemBuilder: (context, index) {
                              return Text(snapshot.expenses.data[index].id);
                            },
                          );
                        } else {
                          return Center(child: Text('Error'));
                        }
                      },
                    ),
                    Consumer<IncomesProvider>(
                      builder: (context, snapshot, _) {
                        if (snapshot.state == ResultState.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.state == ResultState.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.incomes.count,
                            itemBuilder: (context, index) {
                              return Text(snapshot.incomes.data[index].id);
                            },
                          );
                        } else {
                          return Center(child: Text('Error'));
                        }
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
