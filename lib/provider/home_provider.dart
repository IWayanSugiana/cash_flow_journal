import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/model/cash_flow.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService}) {
    _fetchAllData();
  }

  late ResultState _state;
  late CashFlow _cashFlowData;

  CashFlow get result => _cashFlowData;
  ResultState get state => _state;

  Future _fetchAllData() async {
    _state = ResultState.isLoading;
    notifyListeners();
    final dataCashFlow = await apiService.getCashFlowData();
    if (dataCashFlow.status == "success") {
      _cashFlowData = dataCashFlow;
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.isError;
      notifyListeners();
    }
  }
}
