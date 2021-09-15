import 'dart:convert';

import 'package:crm/constants.dart';
import 'package:crm/screens/Home_Page/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'Company_call_api.dart';
import 'status_count_api.dart';

class DashBoardScreen extends StatefulWidget {
  String? token;

  DashBoardScreen({Key? key, required this.token}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<StatusDatum>? statusCount;
  List<CaompanyCallDatum>? companyCall;
  getStatusCountList() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/interview-status/getstatusescounts');
    var response = await http
        .post(url, body: {"id": "0"}, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      // print(response.body);
      var decode = jsonDecode(response.body);
      statusCount = statusDatumApiDatasFromJson(jsonEncode(decode["data"]!));
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

  bool isLoading = false;
  DateTime dateToday =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<Null> refreshPage() async {
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePage(token: tokencomponent)));
  }

  @override
  void initState() {
    super.initState();
    getStatusCountList().whenComplete(() {
      setState(() {
        isLoading = true;
      });
    });
    getCompanyCallList().whenComplete(() {
      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void dispose() {
    assert(() {
      getCompanyCallList();
      return true;
    }());
    super.dispose();
  }

  List data = [
    {"text": "Olumlu Sonuçlanan Aramalar"},
    {"text": "Olumsuz Sonuçlanan Aramalar"},
    {"text": "Nötr Aramalar "},
    {"text": "Aranmayan Aramalar"},
    {"text": "Açılmayan Aramalar"},
    {"text": "Dönülmeyen Aramalar"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: ListView(children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  'Anasayfa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Future.delayed(Duration(seconds: 1)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 31),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                data[index]["text"],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            Text(
                              statusCount![index].count.toString(),
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 24),
                            ),
                          ],
                        ),
                      );
                    })
                : Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bugün Aranacak Firmalar",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      setState(() {
                        dateStatus = "${date.year}" +
                            "-" +
                            "0${date.month}" +
                            "-" +
                            "0${date.day}";
                        getCompanyCallList();
                      });

                      print('confirm $date');
                    }, currentTime: DateTime.now());
                  },
                  icon: Icon(Icons.date_range)),
            ],
          ),
          Column(
            children: [
              Container(
                height: size.height * 0.23,
                // color: Colors.blue,
                child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 1)),
                  builder: (c, s) => s.connectionState == ConnectionState.done
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: companyCall!.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (companyCall!.length == 0) {
                              return Expanded(child: Text("Veri yok"));
                            } else {
                              return Container(
                                margin: EdgeInsets.all(10),
                                width: 210,
                                // color: Colors.red,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Positioned(
                                      top: 5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            var number =
                                                companyCall![index].gsm;
                                            phonenumber = number;
                                            _launchUrl();
                                          },
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
                                    ),
                                  ],
                                ),
                              );
                            }
                          })
                      : Padding(
                          padding: const EdgeInsets.all(70.0),
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ]),
      ),
    );
  }

  var phonenumber;
  void _launchUrl() async => await launch("tel: $phonenumber");
}
