import 'package:flutter/material.dart';

class BayiScreen extends StatefulWidget {
  BayiScreen({Key? key}) : super(key: key);

  @override
  _BayiScreenState createState() => _BayiScreenState();
}

class _BayiScreenState extends State<BayiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Text("Bayi"),
    );
  }
}