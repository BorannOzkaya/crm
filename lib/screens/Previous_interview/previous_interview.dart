import 'package:flutter/material.dart';

import '../../constants.dart';
import 'body.dart';

class GecmisRandevular extends StatefulWidget {
  const GecmisRandevular({Key? key}) : super(key: key);

  @override
  _GecmisRandevularState createState() => _GecmisRandevularState();
}

class _GecmisRandevularState extends State<GecmisRandevular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF284269),
        title: RichText(
          text: TextSpan(
              text: 'PEN ',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: 'CRM', style: TextStyle(color: Colors.white))
              ]),
        ),
      ),
      body: Body(),
    );
  }
}
