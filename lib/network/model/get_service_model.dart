import 'dart:convert';



class ResultData {
  ResultData({
    this.serviceId,
    this.serviceTitle,
    this.serviceCategoriy,
    this.paymentPercent,
    this.serviceStatus,
    this.image,
    this.description,
  });

  final int serviceId;
  final String serviceTitle;
  final String serviceCategoriy;
  final String paymentPercent;
  final int serviceStatus;
  final String image;
  final String description;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        serviceId: json["service_id"],
        serviceTitle: json["service_title"],
        serviceCategoriy: json["service_categoriy"],
        paymentPercent: json["payment_percent"],
        serviceStatus: json["service_status"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_title": serviceTitle,
        "service_categoriy": serviceCategoriy,
        "payment_percent": paymentPercent,
        "service_status": serviceStatus,
        "image": image,
        "description": description,
      };
}







SubCategoryModel welcomeFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String welcomeToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<SubCategoryResult> data;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    status: json["status"],
    message: json["message"],
    data: List<SubCategoryResult>.from(json["data"].map((x) => SubCategoryResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubCategoryResult {
  SubCategoryResult({
    this.serviceId,
    this.serviceTitle,
    this.serviceCategoriy,
    this.categoriyId,
    this.image,
    this.description,
    this.paymentPercent,
    this.serviceStatus,
  });

  int serviceId;
  String serviceTitle;
  String serviceCategoriy;
  int categoriyId;
  String image;
  String description;
  String paymentPercent;
  int serviceStatus;

  factory SubCategoryResult.fromJson(Map<String, dynamic> json) => SubCategoryResult(
    serviceId: json["service_id"],
    serviceTitle: json["service_title"],
    serviceCategoriy: json["service_categoriy"],
    categoriyId: json["categoriy_id"],
    image: json["image"],
    description: json["description"],
    paymentPercent: json["payment_percent"],
    serviceStatus: json["service_status"]
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_title": serviceTitle,
    "service_categoriy": serviceCategoriy,
    "categoriy_id": categoriyId,
    "image": image,
    "description": description,
    "payment_percent": paymentPercent,
    "service_status": serviceStatus
  };
}