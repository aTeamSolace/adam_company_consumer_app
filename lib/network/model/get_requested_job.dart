import 'dart:convert';

GetRequestedModel welcomeFromJson(String str) => GetRequestedModel.fromJson(json.decode(str));

String welcomeToJson(GetRequestedModel data) => json.encode(data.toJson());

class GetRequestedModel {
  GetRequestedModel({
    this.status,
    this.message,
    this.data,
  });

  final int status;
  final String message;
  final List<GetRequestedModelResult> data;

  factory GetRequestedModel.fromJson(Map<String, dynamic> json)  {
    return GetRequestedModel(
      status: json["status"],
      message: json["message"],
      data: List<GetRequestedModelResult>.from(json["data"].map((x) => GetRequestedModelResult.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetRequestedModelResult {
  GetRequestedModelResult({
    this.id,
    this.serviceId,
    this.consumerId,
    this.jobTitle,
    this.jobDescription,
    this.jobAddress,
    this.jobCity,
    this.jobState,
    this.jobCountry,
    this.jobZipcode,
    this.jobLocationLatitude,
    this.jobLocationLongitude,
    this.documents,
    this.jobDoneByDate,
    this.jobAddressDetails,
    this.jobStatus,
    this.technicianStatus,
    this.technicianId,
    this.paymentType,
    this.paymentPercentageDetails,
    this.overallPaymentStatus,
    this.jobCostCurrency,
    this.jobCost,
    this.totalAmountPaid,
    this.lastPaymentDate,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.paymentstructure
  });

  final int id;
  final int serviceId;
  final int consumerId;
  final String jobTitle;
  final String jobDescription;
  final String jobAddress;
  final String jobCity;
  final String jobState;
  final String jobCountry;
  final String jobZipcode;
  final String jobLocationLatitude;
  final String jobLocationLongitude;
  final String documents;
    var jobDoneByDate;
  final String jobAddressDetails;
    var jobStatus;
    var technicianStatus;
    var technicianId;
  final String paymentType;
  final String paymentPercentageDetails;
  final String overallPaymentStatus;
  final String jobCostCurrency;
  final String jobCost;
  final String totalAmountPaid;
  final DateTime lastPaymentDate;
  final dynamic otp;
  final DateTime createdAt;
  final DateTime updatedAt;
  var paymentstructure;

  factory GetRequestedModelResult.fromJson(Map<String, dynamic> json)  {
   return GetRequestedModelResult(
     id: json["id"],
     serviceId: json["service_id"],
     consumerId: json["consumer_id"],
     jobTitle: json["job_title"],
     jobDescription: json["job_description"],
     jobAddress: json["job_address"],
     jobCity: json["job_city"],
     jobState: json["job_state"],
     jobCountry: json["job_country"],
     jobZipcode: json["job_zipcode"],
     jobLocationLatitude: json["job_location_latitude"],
     jobLocationLongitude: json["job_location_longitude"],
     documents: json['documents'],
     jobDoneByDate: DateTime.parse(json["job_done_by_date"]),
     jobAddressDetails: json["job_address_details"],
     jobStatus: json["job_status"],
     technicianStatus: json["technician_status"],
     technicianId: json["technician_id"],
     paymentType: json["payment_type"],
     paymentPercentageDetails: json["payment_percentage_details"],
     overallPaymentStatus: json["overall_payment_status"],
     jobCostCurrency: json["job_cost_currency"],
     jobCost: json["job_cost"],
     totalAmountPaid: json["total_amount_paid"],
     lastPaymentDate: DateTime.parse(json["last_payment_date"]),
     otp: json["otp"],
     createdAt: DateTime.parse(json["created_at"]),
     updatedAt: DateTime.parse(json["updated_at"]),
     paymentstructure: json["paymentstructure"]
   );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_id": serviceId,
    "consumer_id": consumerId,
    "job_title": jobTitle,
    "job_description": jobDescription,
    "job_address": jobAddress,
    "job_city": jobCity,
    "job_state": jobState,
    "job_country": jobCountry,
    "job_zipcode": jobZipcode,
    "job_location_latitude": jobLocationLatitude,
    "job_location_longitude": jobLocationLongitude,
    "documents": documents,
    "job_done_by_date": jobDoneByDate.toIso8601String(),
    "job_address_details": jobAddressDetails,
    "job_status": jobStatus,
    "technician_status": technicianStatus,
    "technician_id": technicianId,
    "payment_type": paymentType,
    "payment_percentage_details": paymentPercentageDetails,
    "overall_payment_status": overallPaymentStatus,
    "job_cost_currency": jobCostCurrency,
    "job_cost": jobCost,
    "total_amount_paid": totalAmountPaid,
    "last_payment_date": lastPaymentDate.toIso8601String(),
    "otp": otp,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "paymentstructure": paymentstructure
  };
}
