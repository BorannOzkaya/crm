// To parse this JSON data, do
//
//     final profileUpdate = profileUpdateFromJson(jsonString);

import 'dart:convert';

ProfileUpdate profileUpdateFromJson(String str) =>
    ProfileUpdate.fromJson(json.decode(str));

List<ProfileUpdate> profileDatumApiDatasFromJson(String str) =>
    List<ProfileUpdate>.from(
        json.decode(str).map((x) => ProfileUpdate.fromJson(x)));

String profileUpdateToJson(ProfileUpdate data) => json.encode(data.toJson());

class ProfileUpdate {
  ProfileUpdate({
    required this.id,
    required this.genderId,
    required this.name,
    required this.surname,
    required this.username,
    required this.gsm,
    required this.email,
  });

  int id;
  int genderId;
  String name;
  String surname;
  String username;
  String gsm;
  String email;

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
        id: json["id"],
        genderId: json["gender_id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        gsm: json["gsm"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender_id": genderId,
        "name": name,
        "surname": surname,
        "username": username,
        "gsm": gsm,
        "email": email,
      };
}

ProfilePerson profilePersonFromJson(String str) =>
    ProfilePerson.fromJson(json.decode(str));

List<ProfilePerson> profilePersonDatumApiDatasFromJson(String str) =>
    List<ProfilePerson>.from(
        json.decode(str).map((x) => ProfilePerson.fromJson(x)));

String profilePersonToJson(ProfilePerson data) => json.encode(data.toJson());

class ProfilePerson {
  ProfilePerson({
    required this.id,
  });

  int id;

  factory ProfilePerson.fromJson(Map<String, dynamic> json) => ProfilePerson(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
