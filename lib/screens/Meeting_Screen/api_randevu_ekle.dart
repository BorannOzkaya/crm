// To parse this JSON data, do
//
//     final randevuEkle = randevuEkleFromJson(jsonString);

import 'dart:convert';

RandevuEkle randevuEkleFromJson(String str) =>
    RandevuEkle.fromJson(json.decode(str));

String randevuEkleToJson(RandevuEkle data) => json.encode(data.toJson());

class RandevuEkle {
  RandevuEkle({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<RandevuEkleDatum> data;

  factory RandevuEkle.fromJson(Map<String, dynamic> json) => RandevuEkle(
        status: json["status"],
        message: json["message"],
        data: List<RandevuEkleDatum>.from(
            json["data"].map((x) => RandevuEkleDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RandevuEkleDatum {
  RandevuEkleDatum({
    required this.id,
    required this.companyId,
    required this.statusId,
    required this.interviewDate,
    required this.callTime,
    required this.createdId,
    required this.createdDate,
    required this.isActive,
    required this.deletedId,
    required this.deletedDate,
    required this.isArchive,
    required this.ownerId,
    required this.countryId,
    required this.adminGetlist,
  });

  int id;
  int companyId;
  int statusId;
  DateTime interviewDate;
  int callTime;
  int createdId;
  DateTime createdDate;
  bool isActive;
  int deletedId;
  DateTime deletedDate;
  bool isArchive;
  int ownerId;
  int countryId;
  bool adminGetlist;

  factory RandevuEkleDatum.fromJson(Map<String, dynamic> json) =>
      RandevuEkleDatum(
        id: json["id"],
        companyId: json["company_id"],
        statusId: json["status_id"],
        interviewDate: DateTime.parse(json["interview_date"]),
        callTime: json["call_time"],
        createdId: json["created_id"],
        createdDate: DateTime.parse(json["created_date"]),
        isActive: json["is_active"],
        deletedId: json["deleted_id"],
        deletedDate: DateTime.parse(json["deleted_date"]),
        isArchive: json["is_archive"],
        ownerId: json["owner_id"],
        countryId: json["country_id"],
        adminGetlist: json["admin_getlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "status_id": statusId,
        "interview_date": interviewDate.toIso8601String(),
        "call_time": callTime,
        "created_id": createdId,
        "created_date": createdDate.toIso8601String(),
        "is_active": isActive,
        "deleted_id": deletedId,
        "deleted_date": deletedDate.toIso8601String(),
        "is_archive": isArchive,
        "owner_id": ownerId,
        "country_id": countryId,
        "admin_getlist": adminGetlist,
      };
}
