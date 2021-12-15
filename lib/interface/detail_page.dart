import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/interface/widget/show_form_tile.dart';
import 'package:cash_flow_journal/model/detail_cash_flow.dart';
import 'package:cash_flow_journal/provider/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.data, required this.type})
      : super(key: key);

  final Future<CashFlowDetail> data;
  final String type;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CashFlowDetail>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Detail'),
                ShowFormTile.date(type: type, cashFlowData: snapshot.data!),
                ShowFormTile.type(type: type, cashFlowData: snapshot.data!),
                ShowFormTile.category(type: type, cashFlowData: snapshot.data!),
                ShowFormTile.description(
                    type: type, cashFlowData: snapshot.data!),
                ShowFormTile.amount(type: type, cashFlowData: snapshot.data!),
              ],
            ),
          );
        }
      },
    );
  }
}
