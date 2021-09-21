// To parse this JSON data, do
//
//     final previousCompanyInterview = previousCompanyInterviewFromJson(jsonString);

import 'dart:convert';

PreviousCompanyInterview previousCompanyInterviewFromJson(String str) =>
    PreviousCompanyInterview.fromJson(json.decode(str));

List<PreviousInterviewDatum> previousInterviewApiDatasFromJson(String str) =>
    List<PreviousInterviewDatum>.from(
        json.decode(str).map((x) => PreviousInterviewDatum.fromJson(x)));

String previousCompanyInterviewToJson(PreviousCompanyInterview data) =>
    json.encode(data.toJson());

class PreviousCompanyInterview {
  PreviousCompanyInterview({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<PreviousInterviewDatum> data;

  factory PreviousCompanyInterview.fromJson(Map<String, dynamic> json) =>
      PreviousCompanyInterview(
        status: json["status"],
        message: json["message"],
        data: List<PreviousInterviewDatum>.from(
            json["data"].map((x) => PreviousInterviewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PreviousInterviewDatum {
  PreviousInterviewDatum({
    required this.id,
    required this.companyId,
    required this.statusId,
    required this.isMailSend,
    required this.isCallBack,
    required this.interviewDate,
    required this.callTime,
    required this.createdId,
    required this.createdDate,
    required this.isActive,
    this.deletedId,
    this.deletedDate,
    required this.formattedDatetime,
    required this.username,
    required this.companyName,
    required this.gsm,
    required this.countryCode,
    required this.email,
    required this.countryName,
    required this.name,
  });

  int id;
  int companyId;
  int statusId;
  bool? isMailSend;
  bool? isCallBack;
  DateTime interviewDate;
  int callTime;
  int createdId;
  DateTime createdDate;
  bool? isActive;
  dynamic deletedId;
  dynamic deletedDate;
  String formattedDatetime;
  String username;
  String companyName;
  String gsm;
  String countryCode;
  String email;
  String countryName;
  String name;

  factory PreviousInterviewDatum.fromJson(Map<String, dynamic> json) =>
      PreviousInterviewDatum(
        id: json["id"],
        companyId: json["company_id"],
        statusId: json["status_id"],
        isMailSend: json["is_mail_send"],
        isCallBack: json["is_call_back"],
        interviewDate: DateTime.parse(json["interview_date"]),
        callTime: json["call_time"],
        createdId: json["created_id"],
        createdDate: DateTime.parse(json["created_date"]),
        isActive: json["is_active"],
        deletedId: json["deleted_id"],
        deletedDate: json["deleted_date"],
        formattedDatetime: json["formatted_datetime"],
        username: json["username"],
        companyName: json["company_name"],
        gsm: json["gsm"],
        countryCode: json["country_code"],
        email: json["email"],
        countryName: json["country_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "status_id": statusId,
        "is_mail_send": isMailSend,
        "is_call_back": isCallBack,
        "interview_date": interviewDate.toIso8601String(),
        "call_time": callTime,
        "created_id": createdId,
        "created_date": createdDate.toIso8601String(),
        "is_active": isActive,
        "deleted_id": deletedId,
        "deleted_date": deletedDate,
        "formatted_datetime": formattedDatetime,
        "username": username,
        "company_name": companyName,
        "gsm": gsm,
        "country_code": countryCode,
        "email": email,
        "country_name": countryName,
        "name": name,
      };
}
