import 'dart:convert';

GetContactTechnicianModel welcomeFromJson(String str) => GetContactTechnicianModel.fromJson(json.decode(str));

String welcomeToJson(GetContactTechnicianModel data) => json.encode(data.toJson());

class GetContactTechnicianModel {
  GetContactTechnicianModel({
    this.status,
    this.message,
    this.data,
  });

  final int status;
  final String message;
  final List<GetContactTechnicianResult> data;

  factory GetContactTechnicianModel.fromJson(Map<String, dynamic> json) => GetContactTechnicianModel(
    status: json["status"],
    message: json["message"],
    data: List<GetContactTechnicianResult>.from(json["data"].map((x) => GetContactTechnicianResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetContactTechnicianResult {
  GetContactTechnicianResult({
    this.id,
    this.userId,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.addressLatitude,
    this.addressLongitude,
    this.educationalDetails,
    this.educationalDocuments,
    this.profilePic,
    this.profileDescription,
    this.professionalCard,
    this.agreedTermsConditions,
    this.maxRadiusServiceProvide,
    this.status,
    this.isTechAproved,
    this.profileRejectionReason,
    this.profileDeleteReason,
    // this.createdBy,
    // this.bankAccount,
    this.deletedAt,
    // this.countryId,
    // this.technicianRole,
    // this.overallRating,
    // this.createdAt,
    // this.updatedAt,
    this.name,
    this.mobile,
    this.email,
  });

  final int id;
  final int userId;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String addressLatitude;
  final String addressLongitude;
  final String educationalDetails;
  final String educationalDocuments;
  final String profilePic;
  final String profileDescription;
  final String professionalCard;
  final String agreedTermsConditions;
  final String maxRadiusServiceProvide;
  final String status;
  final int isTechAproved;
  final String profileRejectionReason;
  final String profileDeleteReason;
  // final DateTime createdBy;
  // final String bankAccount;
  final dynamic deletedAt;
  // final int countryId;
  // final dynamic technicianRole;
  // final int overallRating;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final String name;
  final int mobile;
  final String email;

  factory GetContactTechnicianResult.fromJson(Map<String, dynamic> json) => GetContactTechnicianResult(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zipcode: json["zipcode"],
    addressLatitude: json["address_latitude"],
    addressLongitude: json["address_longitude"],
    educationalDetails: json["educational_details"],
    educationalDocuments: json["educational_documents"],
    profilePic: json["profile_pic"],
    profileDescription: json["profile_description"],
    professionalCard: json["professional_card"],
    agreedTermsConditions: json["agreed_terms_conditions"],
    maxRadiusServiceProvide: json["max_radius_service_provide"],
    status: json["status"],
    isTechAproved: json["is_tech_aproved"],
    profileRejectionReason: json["profile_rejection_reason"],
    profileDeleteReason: json["profile_delete_reason"],
    // createdBy: DateTime.parse(json["created_by"]),
    // bankAccount: json["bank_account"],
    deletedAt: json["deleted_at"],
    // countryId: json["countryID"],
    // technicianRole: json["technician_role"],
    // overallRating: json["overall_rating"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "city": city,
    "state": state,
    "zipcode": zipcode,
    "address_latitude": addressLatitude,
    "address_longitude": addressLongitude,
    "educational_details": educationalDetails,
    "educational_documents": educationalDocuments,
    "profile_pic": profilePic,
    "profile_description": profileDescription,
    "professional_card": professionalCard,
    "agreed_terms_conditions": agreedTermsConditions,
    "max_radius_service_provide": maxRadiusServiceProvide,
    "status": status,
    "is_tech_aproved": isTechAproved,
    "profile_rejection_reason": profileRejectionReason,
    "profile_delete_reason": profileDeleteReason,
    // "created_by": "${createdBy.year.toString().padLeft(4, '0')}-${createdBy.month.toString().padLeft(2, '0')}-${createdBy.day.toString().padLeft(2, '0')}",
    // "bank_account": bankAccount,
    "deleted_at": deletedAt,
    // "countryID": countryId,
    // "technician_role": technicianRole,
    // "overall_rating": overallRating,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "mobile": mobile,
    "email": email,
  };
}