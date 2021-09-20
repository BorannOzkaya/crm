// To parse this JSON data, do
//
//     final previousCompanyInterview = previousCompanyInterviewFromJson(jsonString);

import 'dart:convert';

PreviousCompanyInterview previousCompanyInterviewFromJson(String str) =>
    PreviousCompanyInterview.fromJson(json.decode(str));

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
  List<TotalCallDatum> data;

  factory PreviousCompanyInterview.fromJson(Map<String, dynamic> json) =>
      PreviousCompanyInterview(
        status: json["status"],
        message: json["message"],
        data: List<TotalCallDatum>.from(
            json["data"].map((x) => TotalCallDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TotalCallDatum {
  TotalCallDatum({
    required this.totalCallTime,
  });

  int totalCallTime;

  factory TotalCallDatum.fromJson(Map<String, dynamic> json) => TotalCallDatum(
        totalCallTime: json["total_call_time"],
      );

  Map<String, dynamic> toJson() => {
        "total_call_time": totalCallTime,
      };
}
