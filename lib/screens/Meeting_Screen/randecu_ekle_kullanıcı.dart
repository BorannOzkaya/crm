import 'dart:convert';

import 'package:crm/screens/Companies_Screen/company_api.dart';
import 'package:crm/screens/Home_Page/home.dart';
import 'package:crm/screens/Meeting_Screen/Users_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

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

  List<UsersDatum> users = <UsersDatum>[];
  List<UsersDatum> usersDisplay = <UsersDatum>[];

  getUsers() async {
    var url =
        Uri.parse('https://crmsr.pen.com.tr/api/person/getlistwithoutadmins');
    var response = await http.post(url, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      print(response.body);
      var decode = jsonDecode(response.body);
      decode["data"].forEach((element) => users.add(UsersDatum(
          id: element['id'],
          // createdDate: element['created_date'],
          // createdId: element['created_id'],
          // deletedDate: element['deleted_date'],
          email: element['email'],
          // deletedId: element['deleted_is'],
          password: element['password'],
          isActive: element['is_active'],
          surname: element['surname'],
          gsm: element['gsm'],
          isAdmin: element['is_admin'],
          genderId: element['gender_id'],
          name: element['name'],
          // token: element['token'],
          username: element['username'])));
    } else {
      print(response.reasonPhrase);
    }
  }

  addRandevu(int companyId, String date, int ownerId) async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/company-interview/add');
    final msg = jsonEncode([
      {
        "company_id": companyId,
        "interview_date": date,
        "is_admin": admincontroller,
        "owner_id": ownerId,
        "is_active": true,
        "is_archive": false
      }
    ]);
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.body);
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
    getUsers().then((value) {
      setState(() {
        users.addAll(value);
        usersDisplay = users;
      });
    });
  }

  int selectedIndex = 0;
  int selectedIndex2 = 0;
  bool selected = false;
  bool selected2 = false;
  String dateValue = "2021-09-24T11:06:00.000";

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
                              dateValue = date.toIso8601String();
                              print(dateValue);
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
                    child: Container(
                        height: size.height * 0.30,
                        //color: Colors.blue,
                        child: ListView.builder(
                            itemCount: firmalarDisplay.length + 1,
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? _searchBar()
                                  : _listItem(index - 1);
                            }))),
                SizedBox(height: 30),
                Container(
                    height: size.height * 0.30,
                    //color: Colors.blue,
                    child: ListView.builder(
                        itemCount: usersDisplay.length + 1,
                        itemBuilder: (context, index2) {
                          return index2 == 0
                              ? _searchBar2()
                              : _listItem2(index2 - 1);
                        })),
                // ignore: deprecated_member_use
                Container(
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () async {
                          addRandevu(selectedIndex, dateValue, selectedIndex2)
                              .whenComplete(() {
                            AwesomeDialog(
                                context: context,
                                animType: AnimType.LEFTSLIDE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.SUCCES,
                                showCloseIcon: true,
                                btnOkText: 'Tamam',
                                title: 'Randevu Başarı ile Eklendi',
                                btnOkOnPress: () {
                                  int count = 0;
                                  Navigator.of(context)
                                      .popUntil((_) => count++ >= 2);
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                })
                              ..show();
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
            usersDisplay = users.where((note) {
              var noteTitle = note.username.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
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

  GestureDetector _listItem2(index) {
    return GestureDetector(
        onLongPress: () {
          setState(() {
            selectedIndex2 = usersDisplay[index].id;
            selected2 = true;
            print(selectedIndex2);
            FocusScope.of(context).unfocus();
          });
          // ignore: deprecated_member_use
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "${usersDisplay[index].username} kullanıcısı seçildi",
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
              child: Text(
                usersDisplay[index].username,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}
