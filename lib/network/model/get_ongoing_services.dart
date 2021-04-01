import 'dart:convert';

OngoingServiceModel welcomeFromJson(String str) =>
    OngoingServiceModel.fromJson(json.decode(str));

String welcomeToJson(OngoingServiceModel data) => json.encode(data.toJson());

class OngoingServiceModel {
  OngoingServiceModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<OngoingServiceResult> data;

  OngoingServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<OngoingServiceResult>();
      json['data'].forEach((v) {
        data.add(OngoingServiceResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => jsonEncode(v)).toList();
    }
    return data;
  }
}

class OngoingServiceResult {
  OngoingServiceResult(
      {this.id,
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
      this.jobId,
      this.paymentstructure});

  int id;
  int serviceId;
  int consumerId;
  String jobTitle;
  String jobDescription;
  String jobAddress;
  String jobCity;
  String jobState;
  String jobCountry;
  String jobZipcode;
  String jobLocationLatitude;
  String jobLocationLongitude;
  String documents;
  DateTime jobDoneByDate;
  String jobAddressDetails;
  var jobStatus;
  var technicianStatus;
  var technicianId;
  String paymentType;
  String paymentPercentageDetails;
  String overallPaymentStatus;
  String jobCostCurrency;
  String jobCost;
  String totalAmountPaid;
  DateTime lastPaymentDate;
  dynamic otp;
  DateTime createdAt;
  DateTime updatedAt;
  var jobId;
  var paymentstructure;

  factory OngoingServiceResult.fromJson(Map<String, dynamic> json) =>
      OngoingServiceResult(
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
          documents: json["documents"],
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
          jobId: json["jobId"],
          paymentstructure: json["paymentstructure"]);

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
        "jobId": jobId,
        "paymentstructure": paymentstructure
      };
}
