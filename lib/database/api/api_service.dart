import 'dart:convert';

import 'package:cash_flow_journal/database/auth/auth_service.dart';
import 'package:cash_flow_journal/model/cash_flow.dart';
import 'package:cash_flow_journal/model/detail_cash_flow.dart';
import 'package:cash_flow_journal/model/list_cash_flow.dart';
import 'package:cash_flow_journal/model/statistic_month.dart';
import 'package:cash_flow_journal/model/statistic_year.dart';
import 'package:http/http.dart' as http;

class ApiService {
  AuthService authService = AuthService();
  static const String _baseUrl =
      'https://cash-flow-journal-api.herokuapp.com/api/';

  Future<String> getToken() async {
    final token = await authService.getHeaderToken();
    return "Bearer " + token!;
  }

  Future<CashFlow> getCashFlowData() async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "list"),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return CashFlow.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load list cash flow data from url : ' + _baseUrl + "list",
      );
    }
  }

  Future<CashFlowList> getExpenseData() async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "expenses"),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return CashFlowList.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load list cash flow data from url : ' + _baseUrl + "list",
      );
    }
  }

  Future<CashFlowList> getIncomeData() async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "incomes"),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return CashFlowList.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load list cash flow data from url : ' + _baseUrl + "list",
      );
    }
  }

  Future<CashFlowDetail> getExpenseDetail(String id) async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "expenses/" + id),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return CashFlowDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load expense data cash flow from url : ' +
            _baseUrl +
            "expenses/id",
      );
    }
  }

  Future<CashFlowDetail> getIncomeDetail(String id) async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "incomes/" + id),
        headers: {
          "Authorization": headerToken,
          "Content-Type": 'application/json'
        });
    if (response.statusCode == 200) {
      return CashFlowDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load list cash flow data from url : ' + _baseUrl + "list",
      );
    }
  }

  Future<String> postExpenseData(Map<String, dynamic> data) async {
    final headerToken = await getToken();

    final response = await http.post(
      Uri.parse(_baseUrl + "expenses"),
      headers: {"Authorization": headerToken},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return 'Post Success';
    } else {
      throw Exception(
        'Failed to post cash flow data from url : ' + _baseUrl + "expenses",
      );
    }
  }

  Future<String> postIncomeData(Map<String, dynamic> data) async {
    final headerToken = await getToken();
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + "incomes"),
        headers: {
          "Authorization": headerToken,
          "Content-Type": 'application/json'
        },
        body: json.encode(data),
      );
      if (response.statusCode == 201) {
        return 'Post Success';
      } else {
        throw Exception(
          'Failed to post cash flow data from url : ' + _baseUrl + "incomes",
        );
      }
    } catch (e) {
      throw Exception(
        'Failed to post cash flow data from url ini exceptin: ' +
            _baseUrl +
            "incomes",
      );
    }
  }

  Future<StatisticMonth> getStatisticMonthData() async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "statistic/month"),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return StatisticMonth.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load statistic mont data from url : ' +
            _baseUrl +
            "statistic/month",
      );
    }
  }

  Future<StatisticYear> getStatisticYearData() async {
    final headerToken = await getToken();

    final response = await http.get(Uri.parse(_baseUrl + "statistic/year"),
        headers: {"Authorization": headerToken});
    if (response.statusCode == 200) {
      return StatisticYear.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to load statistic mont data from url : ' +
            _baseUrl +
            "statistic/month",
      );
    }
  }
}
