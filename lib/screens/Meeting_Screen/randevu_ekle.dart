import 'dart:convert';

import 'package:crm/screens/Companies_Screen/company_api.dart';
import 'package:crm/screens/Users_screen/users_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import 'meeting_screen.dart';

class RandevuEkle extends StatefulWidget {
  const RandevuEkle({Key? key}) : super(key: key);

  @override
  _RandevuEkleState createState() => _RandevuEkleState();
}

class _RandevuEkleState extends State<RandevuEkle> {
  List<Firmalar>? firmalar;
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

  addRandevu(int companyId, String date) async {
    var headers = {'token': tokencomponent, 'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://crmsr.pen.com.tr/api/company-interview/add'));
    request.body =
        json.encode({"company_id": companyId, "interview_date": date});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  late List<Datum> videos;
  getList() async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/person/getlist');
    var response = await http
        .post(url, body: {"lang": "de"}, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      // print(response.body);
      var decode = jsonDecode(response.body);
      videos = datumApiDatasFromJson(jsonEncode(decode["data"]));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getFirmalarList().whenComplete(() {
      setState(() {});
    });
    getList().whenComplete(() {
      setState(() {});
    });
  }

  int selectedIndex = 0;
  bool selected = false;
  String? dateValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Randevu Ekle",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true, onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            }, onConfirm: (date) {
                              dateValue = "${date.toIso8601String()}" + "Z";
                              print('confirm $date');
                            }, currentTime: DateTime.now());
                          },
                          icon: Icon(Icons.date_range)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text("Firma Seçmek için basılı tutun"),
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Container(
                      height: size.height * 0.4,
                      //color: Colors.blue,
                      child: FutureBuilder(
                        future: Future.delayed(Duration(seconds: 1)),
                        builder: (c, s) => s.connectionState ==
                                ConnectionState.done
                            ? ListView.builder(
                                itemCount: firmalar!.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        selectedIndex = firmalar![index].id;
                                        selected = true;
                                        print(selectedIndex);
                                      });
                                      // ignore: deprecated_member_use
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(content: Text("Seçildi")));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          color: kPrimaryLightColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  firmalar![index].companyName,
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  firmalar![index].email,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                SizedBox(height: 8),
                                                Text("+0 " +
                                                    firmalar![index].gsm),
                                                SizedBox(height: 8),
                                                Text(firmalar![index]
                                                        .countryName! +
                                                    "-" +
                                                    firmalar![index].cityName!)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Center(child: CircularProgressIndicator()),
                      )),
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Text("Kullanıcı Seçmek için basılı tutun"),
                    SizedBox(height: 50),
                    Container(
                        height: size.height * 0.4,
                        //color: Colors.blue,
                        child: FutureBuilder(
                          future: Future.delayed(Duration(seconds: 1)),
                          builder: (c, s) => s.connectionState ==
                                  ConnectionState.done
                              ? ListView.builder(
                                  itemCount: videos.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          selectedIndex = videos[index].id;
                                          selected = true;
                                          print(selectedIndex);
                                        });
                                        // ignore: deprecated_member_use
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text("Seçildi")));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            color: kPrimaryLightColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    videos[index].name,
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    videos[index].surname,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text("+0 " +
                                                      videos[index].gsm),
                                                  SizedBox(height: 8),
                                                  Text(videos[index].email)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Center(child: CircularProgressIndicator()),
                        )),
                  ],
                ),
                SizedBox(height: 30),
                // ignore: deprecated_member_use
                Container(
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () async {
                          addRandevu(selectedIndex, dateValue!)
                              .whenComplete(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Başarılı"),
                                    content: TextButton(
                                      onPressed: () {
                                        int counter = 0;
                                        Navigator.of(context)
                                            .popUntil((_) => counter++ >= 3);
                                      },
                                      child: Text("OK"),
                                    ),
                                  );
                                });
                          });
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        child: Text(
                          "Ekle",
                          style: TextStyle(color: Colors.white),
                        )),
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
