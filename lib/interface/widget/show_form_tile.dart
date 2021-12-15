import 'package:cash_flow_journal/helper/currency_helper.dart';
import 'package:cash_flow_journal/model/detail_cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowFormTile extends StatelessWidget {
  const ShowFormTile(
      {Key? key,
      required this.type,
      required this.title,
      required this.cashFlowData})
      : super(key: key);
  final String type;
  final String title;
  final CashFlowDetail cashFlowData;

  const ShowFormTile.date({
    Key? key,
    required this.type,
    this.title = "Date",
    required this.cashFlowData,
  }) : super(key: key);

  const ShowFormTile.type({
    Key? key,
    required this.type,
    this.title = "Type",
    required this.cashFlowData,
  }) : super(key: key);

  const ShowFormTile.category({
    Key? key,
    required this.type,
    this.title = "Category",
    required this.cashFlowData,
  }) : super(key: key);

  const ShowFormTile.description({
    Key? key,
    required this.type,
    this.title = "Description",
    required this.cashFlowData,
  }) : super(key: key);

  const ShowFormTile.amount({
    Key? key,
    required this.type,
    this.title = "Amount",
    required this.cashFlowData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), generatedTextField()],
    );
  }

  Widget generatedTextField() {
    switch (title) {
      case "Date":
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: DateFormat('yyyy-MM-dd')
                .format(
                  DateTime.fromMillisecondsSinceEpoch(
                    cashFlowData.detail.createdAt.seconds * 1000,
                  ),
                )
                .toString(),
          ),
        );
      case "Type":
        return TextField(
          readOnly: true,
          decoration: InputDecoration(hintText: type),
        );
      case "Category":
        return TextField(
          readOnly: true,
          decoration:
              InputDecoration(hintText: cashFlowData.detail.categoryType),
        );
      case "Description":
        return TextField(
          readOnly: true,
          maxLines: 3,
          decoration:
              InputDecoration(hintText: cashFlowData.detail.description),
        );
      case "Amount":
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: CurrencyHelper.format(cashFlowData.detail.amount),
          ),
        );
      default:
        return const TextField(
          readOnly: true,
          decoration: InputDecoration(hintText: "No Data"),
        );
    }
  }
}
