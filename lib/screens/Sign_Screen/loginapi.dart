// To parse this JSON data, do
//
//     final companyInfoApi = companyInfoApiFromJson(jsonString);

import 'dart:convert';

LoginInfoApi loginInfoApiFromJson(String str) =>
    LoginInfoApi.fromJson(json.decode(str));

List<LoginData> loginApiDatasFromJson(String str) =>
    List<LoginData>.from(json.decode(str).map((x) => LoginData.fromJson(x)));

String loginInfoApiToJson(LoginInfoApi data) => json.encode(data.toJson());

class LoginInfoApi {
  LoginInfoApi({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  LoginData data;

  factory LoginInfoApi.fromJson(Map<String, dynamic> json) => LoginInfoApi(
        status: json["status"],
        message: json["message"],
        data: LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class LoginData {
  LoginData({
    required this.id,
    required this.genderId,
    required this.name,
    required this.surname,
    required this.username,
    required this.password,
    required this.token,
    required this.gsm,
    required this.email,
    required this.createdId,
    required this.createdDate,
    required this.isActive,
    required this.deletedId,
    required this.deletedDate,
  });

  int id;
  int genderId;
  String name;
  String surname;
  String username;
  String password;
  String token;
  String gsm;
  String email;
  int createdId;
  String createdDate;
  bool isActive;
  int deletedId;
  String deletedDate;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
        genderId: json["gender_id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        password: json["password"],
        token: json["token"],
        gsm: json["gsm"],
        email: json["email"],
        createdId: json["created_id"],
        createdDate: json["created_date"],
        isActive: json["is_active"],
        deletedId: json["deleted_id"],
        deletedDate: json["deleted_date"],
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
        "created_id": createdId,
        "created_date": createdDate,
        "is_active": isActive,
        "deleted_id": deletedId,
        "deleted_date": deletedDate
      };
}
