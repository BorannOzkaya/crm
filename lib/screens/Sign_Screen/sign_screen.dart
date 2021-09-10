import 'package:crm/constants.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PEN CRM-SR"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
