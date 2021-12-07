import 'dart:convert';

CashFlowList cashFlowListFromJson(String str) =>
    CashFlowList.fromJson(json.decode(str));

String cashFlowListToJson(CashFlowList data) => json.encode(data.toJson());

class CashFlowList {
  CashFlowList({
    required this.status,
    required this.type,
    required this.count,
    required this.data,
  });

  final String status;
  final String type;
  final int count;
  final List<Datum> data;

  factory CashFlowList.fromJson(Map<String, dynamic> json) => CashFlowList(
        status: json["status"],
        type: json["type"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "type": type,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.detail,
  });

  final String id;
  final Detail detail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        detail: Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "detail": detail.toJson(),
      };
}

class Detail {
  Detail({
    required this.categoryType,
    required this.amount,
    required this.createdAt,
  });

  final String categoryType;
  final int amount;
  final CreatedAt createdAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
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
