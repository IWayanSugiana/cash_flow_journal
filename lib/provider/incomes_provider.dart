import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/model/detail_cash_flow.dart';
import 'package:cash_flow_journal/model/list_cash_flow.dart';
import 'package:flutter/material.dart';

class IncomesProvider extends ChangeNotifier {
  final ApiService apiService;

  IncomesProvider({required this.apiService}) {
    _fetchAllIncomeData();
  }

  late ResultState _state;
  late CashFlowList _listIncomeData;

  CashFlowList get incomes => _listIncomeData;
  ResultState get state => _state;

  Future _fetchAllIncomeData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final dataCashFlow = await apiService.getIncomeData();
    if (dataCashFlow.status == "success") {
      _listIncomeData = dataCashFlow;
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  Future<CashFlowDetail> getDetailData(String cashId) async {
    final dataCashFlow = await apiService.getIncomeDetail(cashId);
    return dataCashFlow;
  }

  Future<String> addData(Map<String, dynamic> data) async {
    final result = await apiService.postIncomeData(data);
    if (result == "Post Success") {
      return result;
    }
    return "Error";
  }
}
