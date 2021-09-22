import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants.dart';
import 'previous_interview_api.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    var url = Uri.parse('https://crmsr.pen.com.tr/api/older-interview/getlist');
    final msg = jsonEncode({});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.body);
      var decode = jsonDecode(response.body);
      decode["data"]
          .forEach((element) => previousinterview.add(PreviousInterviewDatum(
                id: element["id"],
                companyId: element["company_id"],
                statusId: element["status_id"],
                isMailSend: element["is_mail_send"],
                isCallBack: element["is_call_back"],
                interviewDate: DateTime.parse(element["interview_date"]),
                callTime: element["call_time"],
                createdId: element["created_id"],
                createdDate: DateTime.parse(element["created_date"]),
                isActive: element["is_active"],
                deletedId: element["deleted_id"],
                deletedDate: element["deleted_date"],
                formattedDatetime: element["formatted_datetime"],
                username: element["username"],
                companyName: element["company_name"],
                gsm: element["gsm"],
                countryCode: element["country_code"],
                email: element["email"],
                countryName: element["country_name"],
                name: element["name"],
              )));
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
                    height: size.height * 0.75,
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
              var noteTitle = note.username.toLowerCase();
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

  _listItem(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [kPrimaryColor, Color(0xFF284269)])),
          child: Card(
            shape: new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(20.0)),
            color: kPrimaryLightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Color(0xFF284269)),
                      SizedBox(width: 10),
                      Text(
                        previousinterviewDisplay[index].username,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          // color: Color(0xFF284269),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 16, 16),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Color(0xFF284269)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          previousinterviewDisplay[index].companyName +
                              " / " +
                              previousinterviewDisplay[index].countryName,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 16, 16),
                  child: Row(
                    children: [
                      Icon(Icons.timer, color: Color(0xFF284269)),
                      SizedBox(width: 10),
                      Text(
                        previousinterviewDisplay[index]
                            .interviewDate
                            .toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// onLongPress: () {
//         setState(() {
//           selectedIndex = previousinterviewDisplay[index].id;
//           selected = true;
//           print(selectedIndex);
//           FocusScope.of(context).unfocus();
