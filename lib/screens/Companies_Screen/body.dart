import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'company_api.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Firmalar>? firmalar;
  getFirmalarList() async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/Company/Getlist');
    var response = await http.post(url, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      firmalar = firmalarFromJson(jsonEncode(decode["data"]));
      print("sd");
    } else {
      print(response.reasonPhrase);
    }
  }

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
    getFirmalarList().whenComplete(() {
      setState(() {});
    });
    addCompany('', '', '', '', '').whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
                height: size.height * 0.60,
                //color: Colors.blue,
                child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 1)),
                  builder: (c, s) => s.connectionState == ConnectionState.done
                      ? ListView.builder(
                          itemCount: firmalar!.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
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
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          firmalar![index].email,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(height: 8),
                                        Text("+0 " + firmalar![index].gsm),
                                        SizedBox(height: 8),
                                        Text(firmalar![index].countryName +
                                            " - " +
                                            firmalar![index].cityName.toString())
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : Center(child: CircularProgressIndicator()),
                )),
          ),
        ],
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
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: Icon(Icons.close))
              ],
            ),
            actions: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Firma Adı",
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
                  hintText: "Ülke Seç",
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
                  hintText: "Şehir Seç",
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
                  hintText: " (+) Ülke Kodu",
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
