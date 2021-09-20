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
                    "Bayiler",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 30, right: 30),
                      color: kPrimaryColor,
                      child: Text(
                        "Yeni Bayi Ekle",
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
                child: Row(
                  children: [
                    Flexible(
                        child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Firma Seçiniz",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "%",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    )),
                  ],
                ),
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
