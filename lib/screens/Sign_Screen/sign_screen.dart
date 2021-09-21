import 'package:crm/constants.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PEN CRM-SR",
            style: TextStyle(color: kPrimaryColor),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF284269),
        ),
        body: Body(),
      ),
    );
  }
}
