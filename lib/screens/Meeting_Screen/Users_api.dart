// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

List<UsersDatum> userslistFromJson(String str) =>
    List<UsersDatum>.from(json.decode(str).map((x) => UsersDatum.fromJson(x)));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<UsersDatum> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        status: json["status"],
        message: json["message"],
        data: List<UsersDatum>.from(
            json["data"].map((x) => UsersDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UsersDatum {
  UsersDatum({
    required this.id,
    required this.genderId,
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
    // required this.token,
    required this.gsm,
    required this.email,
    // required this.createdId,
    // required this.createdDate,
    required this.isActive,
    // required this.deletedId,
    // required this.deletedDate,
    required this.isAdmin,
  });

  int id;
  int genderId;
  String name;
  String surname;
  String username;
  String password;
  dynamic token;
  String gsm;
  String email;
  // int createdId;
  // DateTime createdDate;
  bool isActive;
  // dynamic deletedId;
  // dynamic deletedDate;
  bool isAdmin;

  factory UsersDatum.fromJson(Map<String, dynamic> json) => UsersDatum(
        id: json["id"],
        genderId: json["gender_id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        password: json["password"],
        // token: json["token"],
        gsm: json["gsm"],
        email: json["email"],
        // createdId: json["created_id"],
        // createdDate: DateTime.parse(json["created_date"]),
        isActive: json["is_active"],
        // deletedId: json["deleted_id"],
        // deletedDate: json["deleted_date"],
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender_id": genderId,
        "name": name,
        "surname": surname,
        "username": username,
        "password": password,
        "token": token,
        "gsm": gsm,
        "email": email,
        // "created_id": createdId,
        // "created_date": createdDate.toIso8601String(),
        "is_active": isActive,
        // "deleted_id": deletedId,
        // "deleted_date": deletedDate,
        "is_admin": isAdmin,
      };
}
