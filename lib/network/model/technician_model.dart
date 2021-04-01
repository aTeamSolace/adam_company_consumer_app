import 'dart:convert';

TechnicianModel welcomeFromJson(String str) =>
    TechnicianModel.fromJson(json.decode(str));

String welcomeToJson(TechnicianModel data) => json.encode(data.toJson());

class TechnicianModel {
  TechnicianModel({
    this.status,
    this.message,
    this.data,
  });

  var status;
  final String message;
  final List<TechnicianModelResult> data;

  factory TechnicianModel.fromJson(Map<String, dynamic> json) =>
      TechnicianModel(
        status: json["status"],
        message: json["message"],
        data: List<TechnicianModelResult>.from(
            json["data"].map((x) => TechnicianModelResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TechnicianModelResult {
  TechnicianModelResult({
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
    this.bankAccount,
    this.deletedAt,
    this.overallRating,
    this.createdAt,
    this.updatedAt,
    this.countryId,
    this.technicianRole,
    this.name,
    this.email,
    this.mobile,
    this.empty,
    this.distance,
  });

  var id;
  var userId;
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
  var isTechAproved;
  final String profileRejectionReason;
  final String profileDeleteReason;
  // final DateTime createdBy;
  final String bankAccount;
  final dynamic deletedAt;
  final dynamic overallRating;
  final DateTime createdAt;
  final DateTime updatedAt;
  var countryId;
  final dynamic technicianRole;
  final String name;
  final String email;
  final String mobile;
  final String empty;
  final dynamic distance;

  factory TechnicianModelResult.fromJson(Map<String, dynamic> json) =>
      TechnicianModelResult(
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
        bankAccount: json["bank_account"],
        deletedAt: json["deleted_at"],
        overallRating: json["overall_rating"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        countryId: json["countryID"],
        technicianRole: json["technician_role"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"].toString(),
        empty: json["*"],
        distance: json["distance"],
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
        // "created_by": createdBy.toIso8601String(),
        "bank_account": bankAccount,
        "deleted_at": deletedAt,
        "overall_rating": overallRating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "countryID": countryId,
        "technician_role": technicianRole,
        "name": name,
        "email": email,
        "mobile": mobile,
        "*": empty,
        "distance": distance,
      };
}
