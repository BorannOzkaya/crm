import 'package:flutter/material.dart';

import '../../constants.dart';
import 'body.dart';

class Companies extends StatefulWidget {
  const Companies({Key? key}) : super(key: key);

  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
