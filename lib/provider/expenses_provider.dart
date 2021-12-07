import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/model/list_cash_flow.dart';
import 'package:flutter/material.dart';

class ExpensesProvider extends ChangeNotifier {
  final ApiService apiService;

  ExpensesProvider({required this.apiService}) {
    _fetchAllExpenseData();
  }

  late ResultState _state;
  late CashFlowList _listExpenseData;

  CashFlowList get expenses => _listExpenseData;
  ResultState get state => _state;

  Future _fetchAllExpenseData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final dataCashFlow = await apiService.getExpenseData();
    if (dataCashFlow.status == "success") {
      _listExpenseData = dataCashFlow;
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.isError;
      notifyListeners();
    }
  }
}
