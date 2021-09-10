// To parse this JSON data, do
//
//     final callCompanyApi = callCompanyApiFromJson(jsonString);

import 'dart:convert';

CallCompanyApi callCompanyApiFromJson(String str) =>
    CallCompanyApi.fromJson(json.decode(str));

List<CaompanyCallDatum> statusCompanyCallApiDatasFromJson(String str) =>
    List<CaompanyCallDatum>.from(
        json.decode(str).map((x) => CaompanyCallDatum.fromJson(x)));

String callCompanyApiToJson(CallCompanyApi data) => json.encode(data.toJson());

class CallCompanyApi {
  CallCompanyApi({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<CaompanyCallDatum> data;

  factory CallCompanyApi.fromJson(Map<String, dynamic> json) => CallCompanyApi(
        status: json["status"],
        message: json["message"],
        data: List<CaompanyCallDatum>.from(
            json["data"].map((x) => CaompanyCallDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CaompanyCallDatum {
  CaompanyCallDatum({
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
    required this.deletedId,
    required this.deletedDate,
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
  bool isMailSend;
  bool isCallBack;
  String interviewDate;
  int callTime;
  int createdId;
  String createdDate;
  bool isActive;
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

  factory CaompanyCallDatum.fromJson(Map<String, dynamic> json) =>
      CaompanyCallDatum(
        id: json["id"],
        companyId: json["company_id"],
        statusId: json["status_id"],
        isMailSend: json["is_mail_send"],
        isCallBack: json["is_call_back"],
        interviewDate: json["interview_date"],
        callTime: json["call_time"],
        createdId: json["created_id"],
        createdDate: json["created_date"],
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
        "interview_date": interviewDate,
        "call_time": callTime,
        "created_id": createdId,
        "created_date": createdDate,
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
