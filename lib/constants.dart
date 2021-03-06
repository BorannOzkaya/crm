import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFf27405);
const kPrimaryLightColor = Color(0xFFffead8);

//errors
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

String tokencomponent = "";
String dateStatus = "2021-09-03";

int useridcomponent = 1;
int gendercomponent = 1;

bool admincontroller = false;
