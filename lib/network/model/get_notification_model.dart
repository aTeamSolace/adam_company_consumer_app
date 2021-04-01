import 'dart:convert';

GetNotificationModel welcomeFromJson(String str) =>
    GetNotificationModel.fromJson(json.decode(str));

String welcomeToJson(GetNotificationModel data) => json.encode(data.toJson());

// class GetNotificationModel {
//   GetNotificationModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   int status;
//   String message;
//   List<GetNotificationResult> data;
//
//   factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<GetNotificationResult>.from(json["data"].map((x) => GetNotificationResult.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }

class GetNotificationModel {
  GetNotificationModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<GetNotificationResult> data;

  GetNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<GetNotificationResult>();
      json['data'].forEach((v) {
        data.add(GetNotificationResult.fromJson(v));
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

class GetNotificationResult {
  GetNotificationResult(
      {this.id,
      this.from,
      this.to,
      this.notificationType,
      this.notification,
      this.status});

  int id;
  int from;
  int to;
  String notificationType;
  String notification;
  int status;

  factory GetNotificationResult.fromJson(Map<String, dynamic> json) =>
      GetNotificationResult(
          id: json["id"],
          from: json["from"],
          to: json["to"],
          notificationType: json["notification_type"],
          notification: json["notification"],
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "notification_type": notificationType,
        "notification": notification,
        "status": status
      };
}
