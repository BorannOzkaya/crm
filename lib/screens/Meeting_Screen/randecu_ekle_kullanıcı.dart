import 'dart:convert';

import 'package:crm/screens/Companies_Screen/company_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class RandevuEkleKullanici extends StatefulWidget {
  const RandevuEkleKullanici({Key? key}) : super(key: key);

  @override
  _RandevuEkleKullaniciState createState() => _RandevuEkleKullaniciState();
}

class _RandevuEkleKullaniciState extends State<RandevuEkleKullanici> {
  List<Firmalar> firmalar = <Firmalar>[];
  List<Firmalar> firmalarDisplay = <Firmalar>[];
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

  @override
  void initState() {
    super.initState();
    getFirmalarList().then((value) {
      setState(() {
        firmalar.addAll(value);
        firmalarDisplay = firmalar;
      });
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
                Text("Firma İsmi Arayın ve Seçmek için basılı tutun"),
                SizedBox(height: 20),
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        height: size.height * 0.55,
                        //color: Colors.blue,
                        child: ListView.builder(
                            itemCount: firmalarDisplay.length + 1,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? _searchBar()
                                  : _listItem(index - 1);
                            })),
                    // Container(
                    //     height: size.height * 0.55,
                    //     //color: Colors.blue,
                    //     child: ListView.builder(
                    //         itemCount: firmalarDisplay.length + 1,
                    //         itemBuilder: (context, index) {
                    //           return _searchBar2();
                    //         })),
                  ],
                )),

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

  _searchBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 150),
      child: TextField(
        decoration: InputDecoration(hintText: 'Ara...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            firmalarDisplay = firmalar.where((note) {
              var noteTitle = note.companyName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _searchBar2() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 150),
      child: TextField(
        decoration: InputDecoration(hintText: 'Ara...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            // companyCallDisplay = companyCall.where((note) {
            //   var noteTitle = note.username.toLowerCase();
            //   return noteTitle.contains(text);
            // }).toList();
          });
        },
      ),
    );
  }

  GestureDetector _listItem(index) {
    return GestureDetector(
        onLongPress: () {
          setState(() {
            selectedIndex = firmalarDisplay[index].id;
            selected = true;
            print(selectedIndex);
            FocusScope.of(context).unfocus();
          });
          // ignore: deprecated_member_use
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "${firmalarDisplay[index].companyName} firması seçildi",
                    textAlign: TextAlign.center,
                  ),
                  content: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK")),
                );
              });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: Card(
            //         shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.only(
            //   bottomRight: Radius.circular(10),
            //   topRight: Radius.circular(10)),
            // side: BorderSide(width: 5, color: Colors.blue)),
            color: kPrimaryLightColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firmalarDisplay[index].companyName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(firmalarDisplay[index].email),
                  Text(firmalarDisplay[index].gsm)
                ],
              ),
            ),
          ),
        ));
  }
}
