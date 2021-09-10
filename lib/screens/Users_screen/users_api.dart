// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

List<Datum> datumApiDatasFromJson(String str) =>
    List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.genderId,
    required this.genderName,
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
    required this.gsm,
    required this.email,
  });

  int id;
  int genderId;
  String genderName;
  String name;
  String surname;
  String username;
  String password;
  String gsm;
  String email;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        genderId: json["gender_id"],
        genderName: json["gender_name"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        password: json["password"],
        gsm: json["gsm"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender_id": genderId,
        "gender_name": genderName,
        "name": name,
        "surname": surname,
        "username": username,
        "password": password,
        "gsm": gsm,
        "email": email,
      };
}









// import 'dart:convert';

// List<UsersApiDatas> usersApiDatasFromJson(String str) =>
//     List<UsersApiDatas>.from(
//         json.decode(str).map((x) => UsersApiDatas.fromJson(x)));

// String usersApiDatasToJson(List<UsersApiDatas> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class UsersApiDatas {
//   UsersApiDatas({
//     required this.id,
//     required this.genderId,
//     required this.name,
//     required this.surname,
//     required this.username,
//     required this.password,
//     required this.token,
//     required this.gsm,
//     required this.email,
//     required this.createdId,
//     required this.createdDate,
//     required this.isActive,
//     required this.deletedId,
//     required this.deletedDate,
//   });

//   int? id;
//   int? genderId;
//   String? name;
//   String? surname;
//   String? username;
//   String? password;
//   String? token;
//   String? gsm;
//   String? email;
//   int? createdId;
//   DateTime? createdDate;
//   bool? isActive;
//   dynamic deletedId;
//   dynamic deletedDate;

//   factory UsersApiDatas.fromJson(Map<String, dynamic> json) => UsersApiDatas(
//         id: json["id"],
//         genderId: json["genderId"],
//         name: json["name"],
//         surname: json["surname"],
//         username: json["username"],
//         password: json["password"],
//         token: json["token"],
//         gsm: json["gsm"],
//         email: json["email"],
//         createdId: json["createdId"],
//         createdDate: json["createdDate"],
//         isActive: json["isActive"],
//         deletedId: json["deletedId"],
//         deletedDate: json["deletedDate"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "genderId": genderId,
//         "name": name,
//         "surname": surname,
//         "username": username,
//         "password": password,
//         "token": token,
//         "gsm": gsm,
//         "email": email,
//         "createdId": createdId,
//         "createdDate": createdDate,
//         "isActive": isActive,
//         "deletedId": deletedId,
//         "videletedDatedeo": deletedDate,
//       };
// }
