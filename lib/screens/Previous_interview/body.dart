import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants.dart';
import 'previous_interview_api.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

String? companyName;

class _BodyState extends State<Body> {
  List<PreviousInterviewDatum> previousinterview = <PreviousInterviewDatum>[];
  List<PreviousInterviewDatum> previousinterviewDisplay =
      <PreviousInterviewDatum>[];
  getPreviousInterview() async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/country/getlist');
    final msg = jsonEncode({});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      // var previousinterview = decode["data"][0];
      // print(previousinterview);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getPreviousInterview().then((value) {
      setState(() {
        previousinterview.addAll(value);
        previousinterviewDisplay = previousinterview;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              "Geçmiş Randevular",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
                child: Container(
                    height: size.height * 0.55,
                    //color: Colors.blue,
                    child: ListView.builder(
                        itemCount: previousinterviewDisplay.length + 1,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? _searchBar()
                              : _listItem(index - 1);
                        }))),
          ],
        ),
      )),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Ara...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            previousinterviewDisplay = previousinterview.where((note) {
              var noteTitle = note.countryName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  int selectedIndex = 0;
  bool selected = false;
  String? dateValue;

  GestureDetector _listItem(index) {
    return GestureDetector(
        onLongPress: () {
          setState(() {
            selectedIndex = previousinterviewDisplay[index].id;
            selected = true;
            print(selectedIndex);
            FocusScope.of(context).unfocus();
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "${previousinterviewDisplay[index].countryName} ülkesi seçildi",
                    textAlign: TextAlign.center,
                  ),
                  content: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                );
              });
          // ignore: deprecated_member_use
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Card(
            color: kPrimaryLightColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    previousinterviewDisplay[index].countryName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
