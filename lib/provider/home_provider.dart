import 'package:cash_flow_journal/database/api/api_service.dart';
import 'package:cash_flow_journal/helper/result_satate_helper.dart';
import 'package:cash_flow_journal/model/cash_flow.dart';
import 'package:cash_flow_journal/model/statistic_month.dart';
import 'package:cash_flow_journal/model/statistic_year.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService}) {
    _fetchDataStatistic();
  }

  late ResultState _state;
  late StatisticMonth _statisticMonthData;
  late StatisticYear _statisticYearData;
  late double _expensesTotalMonth;
  late double _incomesTotalMonth;
  late double _expensesAverageMonth;
  late double _incomesAverageMonth;
  late String _mostExpensesTypeMonth;
  late double _expensesTotal;
  late double _incomesTotal;
  late double _expensesAverage;
  late double _incomesAverage;
  late String _mostExpensesType;

  StatisticMonth get resultMonth => _statisticMonthData;
  StatisticYear get resultYear => _statisticYearData;
  ResultState get state => _state;
  double get expenseTotalMonth => _expensesTotalMonth;
  double get incomesTotalMonth => _incomesTotalMonth;
  double get expensesAvgMonth => _expensesAverageMonth;
  double get incomesAvgMonth => _incomesAverageMonth;
  String get mostExpenseTypeMonth => _mostExpensesTypeMonth;
  double get expensesTotal => _expensesTotal;
  double get incomesTotal => _incomesTotal;
  double get expensesAvg => _expensesAverage;
  double get incomesAvg => _incomesAverage;
  String get mostExpenseType => _mostExpensesType;

  Future _fetchDataStatistic() async {
    _state = ResultState.isLoading;
    notifyListeners();
    try {
      final dataListCashFlow = await apiService.getCashFlowData();
      final dataStatisticMonth = await apiService.getStatisticMonthData();
      final dataStatisticYear = await apiService.getStatisticYearData();
      if (dataListCashFlow.status == "success" &&
          dataStatisticMonth.status == "success" &&
          dataStatisticYear.status == "success") {
        _statisticMonthData = dataStatisticMonth;
        calculateAmountEveryTypeMonthly(dataStatisticMonth);
        _statisticYearData = dataStatisticYear;
        calculateAmountEveryTypeYearly(dataStatisticYear, dataListCashFlow);
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _state = ResultState.isError;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.isError;
      notifyListeners();
    }
  }

  calculateAmountEveryTypeMonthly(StatisticMonth dataStatisticMonth) {
    _expensesTotalMonth =
        dataStatisticMonth.dataExpanse.map((e) => e.amount).sum;
    _incomesTotalMonth = dataStatisticMonth.dataIncome.map((e) => e.amount).sum;
    _expensesAverageMonth =
        dataStatisticMonth.dataExpanse.map((e) => e.amount).average;
    _incomesAverageMonth =
        dataStatisticMonth.dataIncome.map((e) => e.amount).average;

    final groupResult = dataStatisticMonth.dataExpanse
        .groupListsBy((element) => element.categoryType);

    _mostExpensesTypeMonth = groupResult.keys.first;
    int mostExpensesAmount = groupResult.values.first.length;

    groupResult.forEach((key, value) {
      if (value.length > mostExpensesAmount && key != '') {
        _mostExpensesTypeMonth = key;
        mostExpensesAmount = value.length;
      }
    });
  }

  calculateAmountEveryTypeYearly(
      StatisticYear dataStatisticYear, CashFlow dataListCashFlow) {
    _expensesTotal = dataStatisticYear.dataExpanse.map((e) => e.amount).sum;
    _incomesTotal = dataStatisticYear.dataIncome.map((e) => e.amount).sum;
    _expensesAverage =
        dataStatisticYear.dataExpanse.map((e) => e.amount).average;
    _incomesAverage = dataStatisticYear.dataIncome.map((e) => e.amount).average;

    final groupResult = dataListCashFlow.cashflow.expenses
        .groupListsBy((element) => element.data.categoryType);

    _mostExpensesType = groupResult.keys.first;
    int mostExpensesAmount = groupResult.values.first.length;

    groupResult.forEach((key, value) {
      if (value.length > mostExpensesAmount) {
        _mostExpensesType = key;
        mostExpensesAmount = value.length;
      }
    });
  }
}
