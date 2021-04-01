import 'dart:convert';

GetPaymentInfo welcomeFromJson(String str) => GetPaymentInfo.fromJson(json.decode(str));

String welcomeToJson(GetPaymentInfo data) => json.encode(data.toJson());

class GetPaymentInfo {
  GetPaymentInfo({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<GetInfoPaymentResult> data;

  factory GetPaymentInfo.fromJson(Map<String, dynamic> json) => GetPaymentInfo(
    status: json["status"],
    message: json["message"],
    data: List<GetInfoPaymentResult>.from(json["data"].map((x) => GetInfoPaymentResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetInfoPaymentResult {
  GetInfoPaymentResult({
    this.id,
    this.jobId,
    this.technicianId,
    this.appPrice,
    this.paymentStructure,
    this.totalAmountPaid,
    this.paymentPercent,
    this.pendingAmount,
    this.lastPaymentDate,
    this.nextPaymentDate,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int jobId;
  int technicianId;
  String appPrice;
  String paymentStructure;
  String totalAmountPaid;
  String paymentPercent;
  int pendingAmount;
  DateTime lastPaymentDate;
  int nextPaymentDate;
  DateTime createdAt;
  DateTime updatedAt;

  factory GetInfoPaymentResult.fromJson(Map<String, dynamic> json) => GetInfoPaymentResult(
    id: json["id"],
    jobId: json["job_id"],
    technicianId: json["technician_id"],
    appPrice: json["app_price"],
    paymentStructure: json["payment_structure"],
    totalAmountPaid: json["total_amount_paid"],
    paymentPercent: json["payment_percent"],
    pendingAmount: json["pending_amount"],
    lastPaymentDate: DateTime.parse(json["last_payment_date"]),
    nextPaymentDate: json["next_payment_date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "technician_id": technicianId,
    "app_price": appPrice,
    "payment_structure": paymentStructure,
    "total_amount_paid": totalAmountPaid,
    "payment_percent": paymentPercent,
    "pending_amount": pendingAmount,
    "last_payment_date": "${lastPaymentDate.year.toString().padLeft(4, '0')}-${lastPaymentDate.month.toString().padLeft(2, '0')}-${lastPaymentDate.day.toString().padLeft(2, '0')}",
    "next_payment_date": nextPaymentDate,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
