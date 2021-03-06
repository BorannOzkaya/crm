import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'company_api.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Firmalar> firmalar = [];
  List<Firmalar> firmalarDisplay = [];
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

  //aeawe

  addCompany(String cityId, String companyName, String countrCode, String gsm,
      String email) async {
    var headers = {'token': tokencomponent, 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://crmsr.pen.com.tr/api/company/add'));
    request.body = json.encode({
      "city_id": cityId,
      "company_name": companyName,
      "country_code": countrCode,
      "gsm": gsm,
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  String? name;
  String? country;
  String? city;
  String? countryCode;
  String? gsm;
  String? email;

  @override
  void initState() {
    super.initState();
    // getFirmalarList().whenComplete(() {
    //   setState(() {});
    // });
    addCompany('', '', '', '', '').whenComplete(() {
      setState(() {});
    });
    getFirmalarList().then((value) {
      setState(() {
        firmalar.addAll(value);
        firmalarDisplay = firmalar;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Firmalar",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: size.width * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                          onPressed: () {
                            _showMyDialog();
                          },
                          padding: EdgeInsets.only(left: 30, right: 30),
                          color: kPrimaryColor,
                          child: Text(
                            "Yeni Firma Ekle",
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
            SingleChildScrollView(
              child: Container(
                  height: size.height * 0.68,
                  //color: Colors.blue,
                  child: ListView.builder(
                      itemCount: firmalarDisplay.length + 1,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index == 0
                                ? _searchBar()
                                : _listItem(index - 1));
                      })),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _listItem(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [kPrimaryColor, Color(0xFF284269)])),
        child: Card(
          shape: new RoundedRectangleBorder(
              side: new BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0)),
          color: kPrimaryLightColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.building,
                      color: Color(0xFF284269),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        firmalarDisplay[index].companyName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: Color(0xFF284269),
                    ),
                    SizedBox(width: 7),
                    Text(
                      firmalarDisplay[index].email,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.phoneAlt,
                      color: Color(0xFF284269),
                      size: 18,
                    ),
                    SizedBox(width: 7),
                    Text("+" +
                        firmalarDisplay[index].countryCode +
                        firmalarDisplay[index].gsm),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: Color(0xFF284269),
                    ),
                    SizedBox(width: 7),
                    Text(firmalarDisplay[index].countryName +
                        " - " +
                        firmalarDisplay[index].cityName.toString()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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
            firmalarDisplay = firmalar.where((note) {
              var noteTitle = note.companyName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  var _nameController = TextEditingController();
  var _countryController = TextEditingController();
  var _cityController = TextEditingController();
  var _countryCodeController = TextEditingController();
  var _gsmController = TextEditingController();
  var _emailController = TextEditingController();

  _showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            scrollable: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Firma Ekle'),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            actions: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Firma Ad??",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _countryController,
                onSaved: (newValue) => country = newValue,
                decoration: InputDecoration(
                  hintText: "??lke Se??",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _cityController,
                onSaved: (newValue) => city = newValue,
                decoration: InputDecoration(
                  hintText: "??ehir Se??",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _countryCodeController,
                onSaved: (newValue) => countryCode = newValue,
                decoration: InputDecoration(
                  hintText: " (+) ??lke Kodu",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _gsmController,
                onSaved: (newValue) => countryCode = newValue,
                decoration: InputDecoration(
                  hintText: "GSM",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _emailController,
                onSaved: (newValue) => countryCode = newValue,
                decoration: InputDecoration(
                  hintText: "E-Posta",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                child: const Text(
                  'Approve',
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: () {
                  addCompany(
                      _cityController.text,
                      _nameController.text,
                      _countryCodeController.text,
                      _gsmController.text,
                      _emailController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
