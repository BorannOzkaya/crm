import 'package:flutter/material.dart';

import '../../constants.dart';

class UlkeRaporlari extends StatefulWidget {
  const UlkeRaporlari({Key? key}) : super(key: key);

  @override
  _UlkeRaporlariState createState() => _UlkeRaporlariState();
}

class _UlkeRaporlariState extends State<UlkeRaporlari> {
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
                TextSpan(text: 'CRM-SR', style: TextStyle(color: Colors.white))
              ]),
        ),
      ),
      body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1)),
          builder: (c, s) => s.connectionState == ConnectionState.done
              ? Container(
                  child: Center(
                    child: Text("Herhangi bir veri bulunmamaktadır."),
                  ),
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
