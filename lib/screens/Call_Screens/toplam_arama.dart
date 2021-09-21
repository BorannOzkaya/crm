import 'package:flutter/material.dart';

class ToplamAramalar extends StatefulWidget {
  const ToplamAramalar({Key? key}) : super(key: key);

  @override
  _ToplamAramalarState createState() => _ToplamAramalarState();
}

class _ToplamAramalarState extends State<ToplamAramalar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF373b44).withOpacity(0.9),
                    Color(0xFF4286f4).withOpacity(0.9)
                  ])),
        ),
      ),
    );
  }
}
