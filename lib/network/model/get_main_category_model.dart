import 'dart:convert';

GetMainCategryModel welcomeFromJson(String str) =>
    GetMainCategryModel.fromJson(json.decode(str));

String welcomeToJson(GetMainCategryModel data) => json.encode(data.toJson());

class GetMainCategryModel {
  GetMainCategryModel({
    this.status,
    this.message,
    this.data,
  });

  var status;
  String message;
  List<GetMainCategoryResult> data;

  factory GetMainCategryModel.fromJson(Map<String, dynamic> json) =>
      GetMainCategryModel(
        status: json["status"],
        message: json["message"],
        data: List<GetMainCategoryResult>.from(
            json["data"].map((x) => GetMainCategoryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetMainCategoryResult {
  GetMainCategoryResult(
      {this.id, this.category, this.purpose, this.status, this.image_path});

  var id;
  String category;
  String purpose;
  var status;
  var image_path;

  factory GetMainCategoryResult.fromJson(Map<String, dynamic> json) =>
      GetMainCategoryResult(
          id: json["id"],
          category: json["category"],
          purpose: json["purpose"],
          status: json["status"],
          image_path: json["image_path"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "purpose": purpose,
        "status": status,
        "image_path": image_path
      };
}
