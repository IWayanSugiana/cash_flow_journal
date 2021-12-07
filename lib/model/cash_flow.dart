import 'dart:convert';

CashFlow cashFlowFromJson(String str) => CashFlow.fromJson(json.decode(str));

String cashFlowToJson(CashFlow data) => json.encode(data.toJson());

class CashFlow {
  CashFlow({
    required this.status,
    required this.user,
    required this.cashflow,
  });

  final String status;
  final String user;
  final Cashflow cashflow;

  factory CashFlow.fromJson(Map<String, dynamic> json) => CashFlow(
        status: json["status"],
        user: json["user"],
        cashflow: Cashflow.fromJson(json["cashflow"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user,
        "cashflow": cashflow.toJson(),
      };
}

class Cashflow {
  Cashflow({
    required this.expenses,
    required this.incomes,
  });

  final List<Expense> expenses;
  final List<Expense> incomes;

  factory Cashflow.fromJson(Map<String, dynamic> json) => Cashflow(
        expenses: List<Expense>.from(
            json["expenses"].map((x) => Expense.fromJson(x))),
        incomes:
            List<Expense>.from(json["incomes"].map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
        "incomes": List<dynamic>.from(incomes.map((x) => x.toJson())),
      };
}

class Expense {
  Expense({
    required this.id,
    required this.data,
  });

  final String id;
  final Data data;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["id"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.categoryType,
    required this.amount,
    required this.createdAt,
  });

  final String categoryType;
  final int amount;
  final CreatedAt createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryType: json["categoryType"],
        amount: json["amount"],
        createdAt: CreatedAt.fromJson(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "categoryType": categoryType,
        "amount": amount,
        "createdAt": createdAt.toJson(),
      };
}

class CreatedAt {
  CreatedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  final int seconds;
  final int nanoseconds;

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
