import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BayiScreen extends StatefulWidget {
  BayiScreen({Key? key}) : super(key: key);

  @override
  _BayiScreenState createState() => _BayiScreenState();
}

class _BayiScreenState extends State<BayiScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Bayiler",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 400,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(child: TextFormField()),
                    Expanded(child: TextFormField())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
