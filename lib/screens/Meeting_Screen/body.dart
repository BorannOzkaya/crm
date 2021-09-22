import 'dart:convert';

import 'package:crm/screens/Companies_Screen/company_api.dart';
import 'package:crm/screens/Home_Page/Company_call_api.dart';
import 'package:crm/screens/Meeting_Screen/randecu_ekle_kullan%C4%B1c%C4%B1.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Firmalar>? firmalar;
  List<CaompanyCallDatum> companyCall = [];

  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  getFirmalarList() async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/Company/Getlist');
    var response = await http.post(url, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      firmalar = firmalarFromJson(jsonEncode(decode["data"]));
    } else {
      print(response.reasonPhrase);
    }
  }

  getCompanyCallList() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/company-interview/getlistbydate');
    final msg = jsonEncode({"interview_date": dateToday.toIso8601String()});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      decode["data"].forEach((element) => companyCall.add(CaompanyCallDatum(
            statusId: element['status_id'],
            callTime: element['call_time'],
            companyId: element['company_id'],
            companyName: element['company_name'],
            countryCode: element['country_code'],
            countryName: element['country_name'],
            createdDate: element['created_date'],
            createdId: element['created_id'],
            deletedDate: element['created_date'],
            deletedId: element['deleted_id'],
            formattedDatetime: element['formatted_datetime'],
            gsm: element['gsm'],
            email: element['email'],
            id: element['id'],
            interviewDate: element['interview_date'],
            isActive: element['is_active'],
            isCallBack: element['is_call_back'],
            // isMailSend: element['is_mail_send'],
            username: element['username'],
            name: element['name'],
          )));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getCompanyCallList().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Randevu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                width: size.width * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RandevuEkleKullanici()));
                      },
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: kPrimaryColor,
                      child: Text(
                        "Randevu Ekle",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (BuildContext context, s) {
                return s.connectionState == ConnectionState.done
                    ? ListView.builder(
                        itemCount: companyCall.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: size.height * 0.20,
                                color: kPrimaryLightColor,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                          kPrimaryColor,
                                          Color(0xFF284269)
                                        ])),
                                    child: Card(
                                      shape: new RoundedRectangleBorder(
                                          side: new BorderSide(
                                              color: Colors.white, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      color: kPrimaryLightColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Color(0xFF284269),
                                                ),
                                                SizedBox(width: 7),
                                                Text(
                                                  companyCall[index].username,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.language,
                                                  color: Color(0xFF284269),
                                                ),
                                                SizedBox(width: 7),
                                                Text(
                                                  companyCall[index]
                                                      .companyName,
                                                ),
                                                SizedBox(width: 7),
                                                Icon(
                                                  Icons.phone,
                                                  size: 20,
                                                  color: Color(0xFF284269),
                                                ),
                                                SizedBox(width: 7),
                                                Text(
                                                  "+" +
                                                      companyCall[index]
                                                          .countryCode +
                                                      " " +
                                                      companyCall[index].gsm,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.mail_outline,
                                                  color: Color(0xFF284269),
                                                ),
                                                SizedBox(width: 7),
                                                Text(
                                                  companyCall[index].email,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range_outlined,
                                                  color: Color(0xFF284269),
                                                ),
                                                SizedBox(width: 7),
                                                Text(companyCall[index]
                                                    .formattedDatetime),
                                                SizedBox(height: 7),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(color: kPrimaryColor),
                      );
              }),
        ),
      ],
    );
  }
}
