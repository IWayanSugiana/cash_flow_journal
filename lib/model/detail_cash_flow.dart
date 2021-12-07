import 'dart:convert';

CashFlowDetail cashFlowDetailFromJson(String str) =>
    CashFlowDetail.fromJson(json.decode(str));

String cashFlowDetailToJson(CashFlowDetail data) => json.encode(data.toJson());

class CashFlowDetail {
  CashFlowDetail({
    required this.status,
    required this.id,
    required this.detail,
  });

  final String status;
  final String id;
  final Detail detail;

  factory CashFlowDetail.fromJson(Map<String, dynamic> json) => CashFlowDetail(
        status: json["status"],
        id: json["id"],
        detail: Detail.fromJson(json["detail"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "detail": detail.toJson(),
      };
}

class Detail {
  Detail({
    required this.categoryType,
    required this.amount,
    required this.createdAt,
    required this.description,
  });

  final String categoryType;
  final int amount;
  final CreatedAt createdAt;
  final String description;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        categoryType: json["categoryType"],
        amount: json["amount"],
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "categoryType": categoryType,
        "amount": amount,
        "createdAt": createdAt.toJson(),
        "description": description,
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
