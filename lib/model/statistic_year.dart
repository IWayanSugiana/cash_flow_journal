import 'dart:convert';

StatisticYear statisticYearFromJson(String str) =>
    StatisticYear.fromJson(json.decode(str));

String statisticYearToJson(StatisticYear data) => json.encode(data.toJson());

class StatisticYear {
  StatisticYear({
    required this.status,
    required this.userId,
    required this.year,
    required this.dataExpanse,
    required this.dataIncome,
  });

  final String status;
  final String userId;
  final int year;
  final List<Data> dataExpanse;
  final List<Data> dataIncome;

  factory StatisticYear.fromJson(Map<String, dynamic> json) => StatisticYear(
        status: json["status"],
        userId: json["userId"],
        year: json["year"],
        dataExpanse:
            List<Data>.from(json["dataExpanse"].map((x) => Data.fromJson(x))),
        dataIncome:
            List<Data>.from(json["dataIncome"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "year": year,
        "dataExpanse": List<dynamic>.from(dataExpanse.map((x) => x.toJson())),
        "dataIncome": List<dynamic>.from(dataIncome.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.month,
    required this.amount,
  });

  final String month;
  final double amount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        month: json["month"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "amount": amount,
      };
}
