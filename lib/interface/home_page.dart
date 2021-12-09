import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/interface/list_page.dart';
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
        body: Center(
          child: Consumer<HomeProvider>(
            builder: (context, snapshot, child) {
              if (snapshot.state == ResultState.isLoading) {
                // return CircularProgressIndicator();
                return ElevatedButton(
                    onPressed: () {
                      Provider.of<AuthenticationProvider>(context,
                              listen: false)
                          .userLogOut();
                    },
                    child: Text('log Out'));
              } else if (snapshot.state == ResultState.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.result.user),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<AuthenticationProvider>(context,
                                listen: false)
                            .userLogOut();
                      },
                      child: Text('Log Out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListPage()));
                      },
                      child: Text('list cash flow data'),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Text('Ini Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
