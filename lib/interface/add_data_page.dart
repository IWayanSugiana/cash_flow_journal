import 'package:cash_flow_journal/interface/widget/custom_app_bar.dart';
import 'package:cash_flow_journal/interface/widget/add_form_tile.dart';
import 'package:cash_flow_journal/provider/expenses_provider.dart';
import 'package:cash_flow_journal/provider/incomes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDataPage extends StatelessWidget {
  AddDataPage({
    Key? key,
  }) : super(key: key);

  final TextEditingController dateController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBar(title: "Add Data"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AddFormTile.date(
                          textController: dateController,
                        ),
                        AddFormTile.type(
                          textController: typeController,
                        ),
                        AddFormTile.category(
                          textController: categoryController,
                        ),
                        AddFormTile.description(
                          textController: descriptController,
                        ),
                        AddFormTile.amount(
                          textController: amountController,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final Map<String, dynamic> data = {
                                "amount": double.parse(amountController.text),
                                "categoryType": categoryController.text,
                                "date": dateController.text,
                                "description": descriptController.text,
                              };

                              if (typeController.text == 'Expense') {
                                final provider = Provider.of<ExpensesProvider>(
                                    context,
                                    listen: false);
                                final result = await provider.addData(data);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result)));
                              } else {
                                final provider = Provider.of<IncomesProvider>(
                                    context,
                                    listen: false);
                                final result = await provider.addData(data);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result)));
                              }
                            }
                          },
                          child: const Text("Submit"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
