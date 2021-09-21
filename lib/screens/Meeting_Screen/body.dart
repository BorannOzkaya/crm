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
  List<CaompanyCallDatum>? companyCall;

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
        'https://crmsr.pen.com.tr/api/company_interview/getallbydate');
    final msg = jsonEncode({"interview_date": dateToday.toIso8601String()});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // print(response.body);
      var decode = jsonDecode(response.body);
      companyCall =
          statusCompanyCallApiDatasFromJson(jsonEncode(decode["data"]!));
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
                if (s.hasData) {
                  return s.connectionState == ConnectionState.done
                      ? ListView.builder(
                          itemCount: companyCall!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: size.height * 0.15,
                                  color: kPrimaryLightColor,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        top: 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: size.height * 0.17,
                                            width: size.width * 0.51,
                                            color: kPrimaryLightColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    companyCall![index]
                                                        .companyName,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Text(
                                                    companyCall![index].email,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Text(companyCall![index]
                                                      .formattedDatetime)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                } else {
                  return Center(
                    child: Text("Veri Bulunmamaktadır."),
                  );
                }
              }),
        ),
      ],
    );
  }
}
