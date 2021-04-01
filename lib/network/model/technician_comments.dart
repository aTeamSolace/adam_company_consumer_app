import 'dart:convert';

TechnicianCommentsModel welcomeFromJson(String str) =>
    TechnicianCommentsModel.fromJson(json.decode(str));

String welcomeToJson(TechnicianCommentsModel data) =>
    json.encode(data.toJson());

class TechnicianCommentsModel {
  TechnicianCommentsModel({
    this.status,
    this.message,
    this.data,
  });

  var status;
  var message;
  final List<TechnicianCommentsResult> data;

  factory TechnicianCommentsModel.fromJson(Map<String, dynamic> json) =>
      TechnicianCommentsModel(
        status: json["status"],
        message: json["message"],
        data: List<TechnicianCommentsResult>.from(
            json["data"].map((x) => TechnicianCommentsResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TechnicianCommentsResult {
  TechnicianCommentsResult({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.mobile,
    this.status,
    this.password,
    this.rememberToken,
    this.mobileToken,
    this.loginMethod,
    this.profilePic,
    this.createdAt,
    this.updatedAt,
    this.consumerId,
    this.technicianId,
    this.jobId,
    this.reviewComments,
    this.rating,
  });

  var id;
  var userId;
  var name;
  var email;
  var mobile;
  var status;
  var password;
  var rememberToken;
  var mobileToken;
  var loginMethod;
  var profilePic;
  final DateTime createdAt;
  final DateTime updatedAt;
  var consumerId;
  var technicianId;
  var jobId;
  var reviewComments;
  var rating;

  factory TechnicianCommentsResult.fromJson(Map<String, dynamic> json) =>
      TechnicianCommentsResult(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        status: json["status"],
        password: json["password"],
        rememberToken: json["remember_token"],
        mobileToken: json["mobile_token"],
        loginMethod: json["login_method"],
        profilePic: json["customer_profile_pic"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        consumerId: json["consumer_id"],
        technicianId: json["technician_id"],
        jobId: json["job_id"],
        reviewComments: json["review_comments"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "mobile": mobile,
        "status": status,
        "password": password,
        "remember_token": rememberToken,
        "mobile_token": mobileToken,
        "login_method": loginMethod,
        "customer_profile_pic": profilePic,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "consumer_id": consumerId,
        "technician_id": technicianId,
        "job_id": jobId,
        "review_comments": reviewComments,
        "rating": rating,
      };
}
