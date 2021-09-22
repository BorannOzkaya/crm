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
          title: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'PEN ',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text('CRM-SR  ',
                  style: TextStyle(color: Colors.white, fontSize: 15))
            ],
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
