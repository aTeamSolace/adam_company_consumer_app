import 'dart:convert';

ContactTechnicianModel welcomeFromJson(String str) => ContactTechnicianModel.fromJson(json.decode(str));

String welcomeToJson(ContactTechnicianModel data) => json.encode(data.toJson());

class ContactTechnicianModel {
  ContactTechnicianModel({
    this.status,
    this.message,
  });

  final int status;
  final String message;

  factory ContactTechnicianModel.fromJson(Map<String, dynamic> json) => ContactTechnicianModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
