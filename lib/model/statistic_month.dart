import 'dart:convert';

StatisticMonth statisticMonthFromJson(String str) =>
    StatisticMonth.fromJson(json.decode(str));

String statisticMonthToJson(StatisticMonth data) => json.encode(data.toJson());

class StatisticMonth {
  StatisticMonth({
    required this.status,
    required this.userId,
    required this.month,
    required this.dataExpanse,
    required this.dataIncome,
  });

  final String status;
  final String userId;
  final String month;
  final List<Data> dataExpanse;
  final List<Data> dataIncome;

  factory StatisticMonth.fromJson(Map<String, dynamic> json) => StatisticMonth(
        status: json["status"],
        userId: json["userId"],
        month: json["month"],
        dataExpanse:
            List<Data>.from(json["dataExpanse"].map((x) => Data.fromJson(x))),
        dataIncome:
            List<Data>.from(json["dataIncome"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "month": month,
        "dataExpanse": List<dynamic>.from(dataExpanse.map((x) => x.toJson())),
        "dataIncome": List<dynamic>.from(dataIncome.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.categoryType,
    required this.amount,
  });

  final String categoryType;
  final double amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryType: json["categoryType"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "categoryType": categoryType,
        "amount": amount,
      };
}
