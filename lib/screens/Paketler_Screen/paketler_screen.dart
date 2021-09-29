import 'package:flutter/material.dart';

import '../../constants.dart';

class PaketlerScreen extends StatefulWidget {
  const PaketlerScreen({Key? key}) : super(key: key);

  @override
  _PaketlerScreenState createState() => _PaketlerScreenState();
}

class _PaketlerScreenState extends State<PaketlerScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Firma Paketleri",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 30, right: 30),
                      color: kPrimaryColor,
                      child: Text(
                        "Firmaya Paket Ekle",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
                child:
                    Center(child: Text("Herhangi bir veri bulunmamaktadır.")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
