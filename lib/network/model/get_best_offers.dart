import 'dart:convert';

GetBestOffersModel welcomeFromJson(String str) => GetBestOffersModel.fromJson(json.decode(str));

String welcomeToJson(GetBestOffersModel data) => json.encode(data.toJson());

class GetBestOffersModel {
  GetBestOffersModel({
    this.status,
    this.message,
    this.data,
  });

  final int status;
  final String message;
  final List<GetBestOffersResult> data;

  factory GetBestOffersModel.fromJson(Map<String, dynamic> json) => GetBestOffersModel(
    status: json["status"],
    message: json["message"],
    data: List<GetBestOffersResult>.from(json["data"].map((x) => GetBestOffersResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetBestOffersResult {
  GetBestOffersResult({
    this.id,
    this.offerName,
    this.description,
    this.imagePath,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String offerName;
  final String description;
  final String imagePath;
  final DateTime startDate;
  final DateTime endDate;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory GetBestOffersResult.fromJson(Map<String, dynamic> json) => GetBestOffersResult(
    id: json["id"],
    offerName: json["offer_name"],
    description: json["description"],
    imagePath: json["image_path"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_name": offerName,
    "description": description,
    "image_path": imagePath,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}