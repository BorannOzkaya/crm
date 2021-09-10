// To parse this JSON data, do
//
//     final statusCount = statusCountFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

StatusCount statusCountFromJson(String str) =>
    StatusCount.fromJson(json.decode(str));

List<StatusDatum> statusDatumApiDatasFromJson(String str) =>
    List<StatusDatum>.from(
        json.decode(str).map((x) => StatusDatum.fromJson(x)));

String statusCountToJson(StatusCount data) => json.encode(data.toJson());

class StatusCount {
  StatusCount({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<StatusDatum> data;

  factory StatusCount.fromJson(Map<String, dynamic> json) => StatusCount(
        status: json["status"],
        message: json["message"],
        data: List<StatusDatum>.from(
            json["data"].map((x) => StatusDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StatusDatum {
  StatusDatum({
    required this.statusId,
    required this.count,
  });

  final int? statusId;
  final int? count;

  factory StatusDatum.fromJson(Map<String, dynamic> json) => StatusDatum(
        statusId: json["status_id"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "status_id": statusId,
        "count": count,
      };
}
