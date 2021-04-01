import 'dart:convert';

GetQuotationModel welcomeFromJson(String str) => GetQuotationModel.fromJson(json.decode(str));

String welcomeToJson(GetQuotationModel data) => json.encode(data.toJson());

class GetQuotationModel {
  GetQuotationModel({
    this.status,
    this.message,
    this.data,
  });

  var status;
  var message;
  List<GetQuotationResult> data;

  factory GetQuotationModel.fromJson(Map<String, dynamic> json) => GetQuotationModel(
    status: json["status"],
    message: json["message"],
    data: List<GetQuotationResult>.from(json["data"].map((x) => GetQuotationResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetQuotationResult {
  GetQuotationResult({
    this.id,
    this.jobId,
    this.serviceId,
    this.technicianId,
    this.serviceRequestId,
    this.commentbyAdmin,
    this.appCost,
    this.dueDate,
    this.quotationStatus,
    this.quotationDocument,
    this.technicianCost,
    this.tentativieDate,
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
    this.jobDocuments,
    this.jobDoneByDate,
    this.jobAddressDetails,
    this.jobStatus,
    this.technicianStatus,
    this.paymentType,
    this.paymentPercentageDetails,
    this.overallPaymentStatus,
    this.jobCostCurrency,
    this.jobCost,
    this.totalAmountPaid,
    this.lastPaymentDate,
    this.technicinaAddress,
    this.technicinaProfilePic,
    this.technicinaName,
    this.technicinaEmail,
    this.technicinaCity,
    this.technicianState,
    this.addressLatitude,
    this.addressLongitude,
    this.technicinaMobile,
  });

  var id;
  var jobId;
  var serviceId;
  var technicianId;
  var serviceRequestId;
  var commentbyAdmin;
  var appCost;
  DateTime dueDate;
  var quotationStatus;
  var quotationDocument;
  var technicianCost;
  DateTime tentativieDate;
  var consumerId;
  var jobTitle;
  var jobDescription;
  var jobAddress;
  var jobCity;
  var jobState;
  var jobCountry;
  var jobZipcode;
  var jobLocationLatitude;
  var jobLocationLongitude;
  var jobDocuments;
  DateTime jobDoneByDate;
  var jobAddressDetails;
  var jobStatus;
  var technicianStatus;
  var paymentType;
  var paymentPercentageDetails;
  var overallPaymentStatus;
  var jobCostCurrency;
  var jobCost;
  var totalAmountPaid;
  DateTime lastPaymentDate;
  var technicinaAddress;
  var technicinaProfilePic;
  var technicinaName;
  var technicinaEmail;
  var technicinaCity;
  var technicianState;
  var addressLatitude;
  var addressLongitude;
  var technicinaMobile;

  factory GetQuotationResult.fromJson(Map<String, dynamic> json) => GetQuotationResult(
    id: json["id"],
    jobId: json["jobId"],
    serviceId: json["service_id"],
    technicianId: json["technician_id"],
    serviceRequestId: json["service_request_id"],
    commentbyAdmin: json["commentby_admin"],
    appCost: json["app_cost"],
    dueDate: DateTime.parse(json["due_date"]),
    quotationStatus: json["quotation_status"],
    quotationDocument: json["quotation_document"],
    technicianCost: json["technician_cost"],
    tentativieDate: DateTime.parse(json["tentativie_date"]),
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
    jobDocuments: json["job_documents"],
    jobDoneByDate: DateTime.parse(json["job_done_by_date"]),
    jobAddressDetails: json["job_address_details"],
    jobStatus: json["job_status"],
    technicianStatus: json["technician_status"],
    paymentType: json["payment_type"],
    paymentPercentageDetails: json["payment_percentage_details"],
    overallPaymentStatus: json["overall_payment_status"],
    jobCostCurrency: json["job_cost_currency"],
    jobCost: json["job_cost"],
    totalAmountPaid: json["total_amount_paid"],
    lastPaymentDate: DateTime.parse(json["last_payment_date"]),
    technicinaAddress: json["technicina_address"],
    technicinaProfilePic: json["technicina_profile_pic"],
    technicinaName: json["technicina_name"],
    technicinaEmail: json["technicina_email"],
    technicinaCity: json["technicina_city"],
    technicianState: json["technician_state"],
    addressLatitude: json["address_latitude"],
    addressLongitude: json["address_longitude"],
    technicinaMobile: json["technicina_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jobId": jobId,
    "service_id": serviceId,
    "technician_id": technicianId,
    "service_request_id": serviceRequestId,
    "commentby_admin": commentbyAdmin,
    "app_cost": appCost,
    "due_date": dueDate.toIso8601String(),
    "quotation_status": quotationStatus,
    "quotation_document": quotationDocument,
    "technician_cost": technicianCost,
    "tentativie_date": "${tentativieDate.year.toString().padLeft(4, '0')}-${tentativieDate.month.toString().padLeft(2, '0')}-${tentativieDate.day.toString().padLeft(2, '0')}",
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
    "job_documents": jobDocuments,
    "job_done_by_date": jobDoneByDate.toIso8601String(),
    "job_address_details": jobAddressDetails,
    "job_status": jobStatus,
    "technician_status": technicianStatus,
    "payment_type": paymentType,
    "payment_percentage_details": paymentPercentageDetails,
    "overall_payment_status": overallPaymentStatus,
    "job_cost_currency": jobCostCurrency,
    "job_cost": jobCost,
    "total_amount_paid": totalAmountPaid,
    "last_payment_date": lastPaymentDate.toIso8601String(),
    "technicina_address": technicinaAddress,
    "technicina_profile_pic": technicinaProfilePic,
    "technicina_name": technicinaName,
    "technicina_email": technicinaEmail,
    "technicina_city": technicinaCity,
    "technician_state": technicianState,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "technicina_mobile": technicinaMobile,
  };
}