import 'package:crm/constants.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
