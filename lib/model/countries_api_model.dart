// To parse this JSON data, do
//
//     final companyInfoApi = companyInfoApiFromJson(jsonString);

import 'dart:convert';

CountryInfoApi companyInfoApiFromJson(String str) =>
    CountryInfoApi.fromJson(json.decode(str));

List<CountriesDatum> ulkelerFromJson(String str) => List<CountriesDatum>.from(
    json.decode(str).map((x) => CountriesDatum.fromJson(x)));

String companyInfoApiToJson(CountryInfoApi data) => json.encode(data.toJson());

class CountryInfoApi {
  CountryInfoApi({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<CountriesDatum> data;

  factory CountryInfoApi.fromJson(Map<String, dynamic> json) => CountryInfoApi(
        status: json["status"],
        message: json["message"],
        data: List<CountriesDatum>.from(
            json["data"].map((x) => CountriesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CountriesDatum {
  CountriesDatum({
    required this.id,
    required this.countryName,
    required this.createdId,
    required this.createdDate,
    required this.isActive,
    this.deletedId,
    this.deletedDate,
  });

  int id;
  String countryName;
  int createdId;
  DateTime createdDate;
  bool isActive;
  dynamic deletedId;
  dynamic deletedDate;

  factory CountriesDatum.fromJson(Map<String, dynamic> json) => CountriesDatum(
        id: json["id"],
        countryName: json["country_name"],
        createdId: json["created_id"],
        createdDate: DateTime.parse(json["created_date"]),
        isActive: json["is_active"],
        deletedId: json["deleted_id"],
        deletedDate: json["deleted_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_name": countryName,
        "created_id": createdId,
        "created_date": createdDate.toIso8601String(),
        "is_active": isActive,
        "deleted_id": deletedId,
        "deleted_date": deletedDate,
      };
}
