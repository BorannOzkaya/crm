import 'dart:convert';

import 'package:crm/constants.dart';
import 'package:crm/screens/Call_Screens/toplam_arama.dart';
import 'package:crm/screens/Home_Page/home.dart';
import 'package:crm/screens/Home_Page/totalcall_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'Company_call_api.dart';
import 'status_count_api.dart';

class DashBoardScreen extends StatefulWidget {
  String? token;

  DashBoardScreen({Key? key, required this.token}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<StatusDatum> statusCount = [];
  List<CaompanyCallDatum> companyCall = [];
  String toplamDeger = "0";
  getStatusCountList() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/interview-status/getallstatuscounts');
    final msg = jsonEncode({"id": 0});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      decode['data'].forEach((element) => statusCount.add(StatusDatum(
            statusId: element['status_id'],
            count: element['count'],
          )));
      int birinciveri = decode["data"][0]["count"];
      int ikinviveri = decode["data"][1]["count"];
      int ucuncuveri = decode["data"][2]["count"];
      int dorduncuveri = decode["data"][4]["count"];
      int toplam = birinciveri + ikinviveri + ucuncuveri + dorduncuveri;
      toplamDeger = toplam.toString();
      // statusCount = statusDatumApiDatasFromJson(jsonEncode(decode["data"]!));
    } else {
      //print(response.reasonPhrase);
    }
  }

  List<TotalCallDatum> totalCall = [];
  getTotalCall() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/company-interview/gettotalcalltime');
    final msg = json.encode({"status_id": 1, "is_admin": true});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = json.decode(response.body);
      // totalCall = decode["data"][0]["total_call_time"];
      decode['data'].forEach((element) => totalCall
          .add(TotalCallDatum(totalCallTime: element['total_call_time'])));
      print(totalCall);
    } else {
      print(response.reasonPhrase);
    }
  }

  getCompanyCallList() async {
    var url = Uri.parse(
        'https://crmsr.pen.com.tr/api/company_interview/getallbydate');
    final msg = jsonEncode({
      "interview_date": dateToday.toIso8601String(),
      "is_Admin": true,
      "owner_id": 1
    });
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      companyCall =
          statusCompanyCallApiDatasFromJson(jsonEncode(decode["data"]!));
    } else {
      //print(response.reasonPhrase);
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
    getTotalCall().whenComplete(() {
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

// 	background: linear-gradient(to right, 0xFF493240, 0xFFf09)

// 	background: linear-gradient(to right, 0xFF373b44, 0xFF4286f4)

// 	background: linear-gradient(to right, 0xFF0a504a, 0xFF38ef7d)

// 	background: linear-gradient(to right, 0xFFa86008, 0xFFffba56)

// 	background: linear-gradient(135deg, 0xFF289cf5, 0xFF84c0ec)

// 	background: linear-gradient(135deg, 0xFF23bdb8 0%, 0xFF43e794 100%)

// 	background: linear-gradient(to right, 0xFFf9900e, 0xFFffba56)

// 	background: linear-gradient(135deg, 0xFF289cf5, 0xFF84c0ec)

  List data = [
    {
      "text": "Olumlu Sonuçlanan Aramalar",
      "text2": "0",
      "color": Colors.green,
      "backgroundcolor1": Color(0xFF373b44).withOpacity(0.9),
      "backgroundcolor2": Color(0xFF4286f4).withOpacity(0.9),
      "icon": FontAwesomeIcons.phone
    },
    {
      "text": "Nötr Aramalar",
      "text2": "0",
      "color": Colors.yellow,
      "backgroundcolor1": Color(0xFFa86008).withOpacity(0.9),
      "backgroundcolor2": Color(0xFFffba56).withOpacity(0.9),
      "icon": FontAwesomeIcons.phone
    },
    {
      "text": "Olumsuz Sonuçlanan Aramalar",
      "text2": "0",
      "color": Colors.red,
      "backgroundcolor1": Color(0xFF493240).withOpacity(0.9),
      "backgroundcolor2": Colors.pink[800],
      "icon": FontAwesomeIcons.phoneSlash
    },
    {
      "text": "Dönülmeyen Aramalar",
      "color": Colors.blue,
      "text2": "0",
      "backgroundcolor1": Color(0xFF289cf5).withOpacity(0.9),
      "backgroundcolor2": Color(0xFF84c0ec).withOpacity(0.9),
      "icon": FontAwesomeIcons.phone
    },
    {
      "text": "Açılmayan Aramalar",
      "color": Colors.grey,
      "text2": "0",
      "backgroundcolor1": Color(0xFF0a504a).withOpacity(0.9),
      "backgroundcolor2": Color(0xFF38ef7d).withOpacity(0.9),
      "icon": FontAwesomeIcons.phone
    },
    {
      "text": "Dönülmeyen Aramalar",
      "text2": "0",
      "color": Colors.blue,
      "backgroundcolor1": Color(0xFF493240).withOpacity(0.9),
      "backgroundcolor2": Color(0xFFf09123).withOpacity(0.9),
      "icon": FontAwesomeIcons.phone
    },
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
          Column(
            children: [
              FutureBuilder(
                  future: Future.delayed(Duration(seconds: 1)),
                  builder: (BuildContext context, s) {
                    // if (s.hasData) {
                    return s.connectionState == ConnectionState.done
                        ? Column(
                            children: [
                              ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Hero(
                                          tag: 'hero',
                                          child: Bounce(
                                            duration:
                                                Duration(milliseconds: 110),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ToplamAramalar()));
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                height: size.height * 0.20,
                                                width: size.width * 0.44,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Color(0xFF373b44)
                                                              .withOpacity(0.9),
                                                          Color(0xFF4286f4)
                                                              .withOpacity(0.9)
                                                        ])),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            "Toplam Arama \nSaniyesi: \n",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.025),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .phone,
                                                                color: Colors
                                                                    .grey),
                                                            Text(
                                                              totalCall[index]
                                                                  .totalCallTime
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
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
                                        Bounce(
                                          duration: Duration(milliseconds: 110),
                                          onPressed: () {},
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              height: size.height * 0.20,
                                              width: size.width * 0.44,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xFF289cf5)
                                                            .withOpacity(0.9),
                                                        Color(0xFF84c0ec)
                                                            .withOpacity(0.9)
                                                      ])),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Toplam Aramalar: \n",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.03),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Icon(
                                                              FontAwesomeIcons
                                                                  .phone,
                                                              color:
                                                                  Colors.grey),
                                                          Text(
                                                            (toplamDeger)
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                              SizedBox(height: 15),
                              GridView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: statusCount.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 31),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Bounce(
                                        duration: Duration(milliseconds: 110),
                                        onPressed: () {},
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      data[index]
                                                          ["backgroundcolor1"],
                                                      data[index]
                                                          ["backgroundcolor2"]
                                                    ])),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 50),
                                                  child: Text(
                                                    data[index]["text"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: size.height * 0.03),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                        data[index]["icon"],
                                                        color: data[index]
                                                            ["color"],
                                                      ),
                                                      Text(
                                                        // data[index]["text2"],
                                                        statusCount[index]
                                                            .count
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24),
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
                                  }),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                    // } else {
                    //   return Center(child: Text("Veri Bulunmamaktadır."));
                    // }
                  }),
            ],
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
                    builder: (BuildContext context, AsyncSnapshot s) => s
                                .connectionState ==
                            ConnectionState.done
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: companyCall.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (companyCall.length == 0) {
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              var number =
                                                  companyCall[index].gsm;
                                              phonenumber = number;
                                              _launchUrl();
                                            },
                                            child: Container(
                                              height: size.height * 0.17,
                                              width: size.width * 0.51,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                    kPrimaryLightColor,
                                                    kPrimaryColor
                                                        .withOpacity(0.5)
                                                  ])),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      companyCall[index]
                                                          .companyName,
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(height: 7),
                                                    Text(
                                                      companyCall[index].email,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(height: 7),
                                                    Text(companyCall[index]
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
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
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
