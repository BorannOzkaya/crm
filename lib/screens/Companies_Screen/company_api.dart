// To parse this JSON data, do
//
//     final companyInfoApi = companyInfoApiFromJson(jsonString);

import 'dart:convert';

CompanyInfoApi companyInfoApiFromJson(String str) =>
    CompanyInfoApi.fromJson(json.decode(str));

List<Firmalar> firmalarFromJson(String str) =>
    List<Firmalar>.from(json.decode(str).map((x) => Firmalar.fromJson(x)));

String companyInfoApiToJson(CompanyInfoApi data) => json.encode(data.toJson());

class CompanyInfoApi {
  CompanyInfoApi({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Firmalar> data;

  factory CompanyInfoApi.fromJson(Map<String, dynamic> json) => CompanyInfoApi(
        status: json["status"],
        message: json["message"],
        data:
            List<Firmalar>.from(json["data"].map((x) => Firmalar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Firmalar {
  Firmalar({
    required this.id,
    required this.cityId,
    required this.companyName,
    required this.countryCode,
    required this.gsm,
    required this.email,
    required this.createdId,
    required this.createdDate,
    required this.isActive,
    required this.deletedId,
    required this.deletedDate,
    required this.website,
    required this.username,
    required this.cityName,
    required this.countryName,
  });

  int id;
  int cityId;
  String companyName;
  String countryCode;
  String gsm;
  String email;
  int createdId;
  String createdDate;
  bool isActive;
  dynamic deletedId;
  dynamic deletedDate;
  String? website;
  String username;
  String? cityName;
  String? countryName;

  factory Firmalar.fromJson(Map<String, dynamic> json) => Firmalar(
        id: json["id"],
        cityId: json["city_id"],
        companyName: json["company_name"],
        countryCode: json["country_code"],
        gsm: json["gsm"],
        email: json["email"],
        createdId: json["created_id"],
        createdDate: json["created_date"],
        isActive: json["is_active"],
        deletedId: json["deleted_id"],
        deletedDate: json["deleted_date"],
        website: json["website"],
        username: json["username"],
        cityName: json["city_name"] == null ? null : "",
        countryName: json["country_name"] == null ? null : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "company_name": companyName,
        "country_code": countryCode,
        "gsm": gsm,
        "email": email,
        "created_id": createdId,
        "created_date": createdDate,
        "is_active": isActive,
        "deleted_id": deletedId,
        "deleted_date": deletedDate,
        "website": website == null ? null : website,
        "username": username,
        "city_name": cityName,
        "country_name": countryName,
      };
}
