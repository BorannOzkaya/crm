import 'dart:convert';

import 'package:crm/constants.dart';
import 'package:crm/screens/Home_Page/home.dart';
import 'package:crm/screens/Users_screen/users_api.dart';
import 'package:crm/screens/Users_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

  addUser(String? gender, String? name, String? surname, String? username,
      String? password, String? gsm, String? email) async {
    var headers = {'token': tokencomponent, 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://crmsr.pen.com.tr/api/person/add'));
    request.body = json.encode({
      "gender_id": gender,
      "name": name,
      "surname": surname,
      "username": username,
      "password": password,
      "gsm": gsm,
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  deleteUser(String? userId) async {
    var headers = {'token': tokencomponent, 'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://crmsr.pen.com.tr/api/person/delete'));
    request.body = json.encode({"id": userId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  editUser(String? userName, String? name, String? surname, String? gsm,
      String? email, int userId, int genderId) async {
    var headers = {
      'token': '5F58BAB4112A661340E0408C9DF51F3C',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://crmsr.pen.com.tr/api/person/update'));
    request.body = json.encode({
      "id": userId,
      "gender_id": genderId,
      "name": name,
      "surname": surname,
      "username": userName,
      "gsm": gsm,
      "email": email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getList().whenComplete(() {
      setState(() {
        isLoading = true;
      });
    });
  }

  String? name;
  String? surName;
  String? userName;
  String? password;
  String? gsm;
  String? email;
  String? gender;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kullanıcılar",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Container(
                  width: size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {
                          _showMyDialog();
                        },
                        padding: EdgeInsets.only(left: 20, right: 20),
                        color: Color(0xFF69d8b5),
                        child: Text(
                          "Yeni Kullanıcı Ekle",
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  height: size.height * 0.63,
                  color: Colors.white,
                  child: FutureBuilder(
                    future: Future.delayed(Duration(seconds: 1)),
                    builder: (c, s) => s.connectionState == ConnectionState.done
                        ? ListView.builder(
                            itemCount: videos.length,
                            itemBuilder: (BuildContext context, index) {
                              return isLoading == false
                                  ? CircularProgressIndicator()
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: [
                                          DataColumn(
                                              label: Text('Ad Soyad',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ))),
                                          DataColumn(
                                              label: Text('Kullanıcı Adı',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          DataColumn(
                                              label: Text('Cinsiyet',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          DataColumn(
                                              label: Text('Gsm',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          DataColumn(
                                              label: Text('E-Posta',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(Text(videos[index].name)),
                                            DataCell(
                                                Text(videos[index].username)),
                                            DataCell(
                                                Text(videos[index].genderName)),
                                            DataCell(Text(videos[index].gsm)),
                                            DataCell(Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(videos[index].email),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          _showMyDialog2();
                                                        },
                                                        icon: Icon(Icons.edit)),
                                                    IconButton(
                                                        onPressed: () {
                                                          // deleteUser(
                                                          //     videos[index]
                                                          //         .id
                                                          //         .toString());
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (BuildContext
                                                          //                 context) =>
                                                          //             HomePage(
                                                          //               token:
                                                          //                   tokencomponent,
                                                          //             )));
                                                          // Scaffold.of(context)
                                                          //     // ignore: deprecated_member_use
                                                          //     .showSnackBar(SnackBar(
                                                          //         content: Text(
                                                          //             "Kullanıcı Başarıyla Silindi")));
                                                        },
                                                        icon:
                                                            Icon(Icons.delete)),
                                                  ],
                                                )
                                              ],
                                            )),
                                          ]),
                                        ],
                                      ),
                                    );
                            })
                        : Center(child: CircularProgressIndicator()),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  var _nameController = TextEditingController();
  var _surNameController = TextEditingController();
  var _userNameController = TextEditingController();
  var _passwordCodeController = TextEditingController();
  var _gsmController = TextEditingController();
  var _emailController = TextEditingController();

  String dropdownValue = 'Erkek';

  _showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            scrollable: true,
            title: const Text('Kullanıcı Ekle'),
            actions: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Ad",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _surNameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Soy Ad",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _userNameController,
                onSaved: (newValue) => surName = newValue,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _passwordCodeController,
                onSaved: (newValue) => userName = newValue,
                decoration: InputDecoration(
                  hintText: "Şifre",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Cinsiyet:"),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 2,
                      color: Colors.black45,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Erkek', 'Bayan', 'Tercihsiz']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _gsmController,
                onSaved: (newValue) => password = newValue,
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
                onSaved: (newValue) => gsm = newValue,
                decoration: InputDecoration(
                  hintText: "E-Posta",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: () {
                  // addUser(
                  //     "1",
                  //     _nameController.text,
                  //     _surNameController.text,
                  //     _userNameController.text,
                  //     _passwordCodeController.text,
                  //     _gsmController.text,
                  //     _emailController.text);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => HomePage(
                  //               token: tokencomponent,
                  //             )));
                  // Scaffold.of(context)
                  //     // ignore: deprecated_member_use
                  //     .showSnackBar(SnackBar(
                  //         content: Text("Kullanıcı Başarıyla Eklendi")));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? editIndex;
  String? editIndexgender;

  _showMyDialog2() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            scrollable: true,
            title: const Text('Kullanıcı Düzenle'),
            actions: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Ad",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _surNameController,
                onSaved: (newValue) => name = newValue,
                decoration: InputDecoration(
                  hintText: "Soy Ad",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _userNameController,
                onSaved: (newValue) => surName = newValue,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Cinsiyet:"),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    underline: Container(
                      height: 2,
                      color: Colors.black45,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Erkek', 'Bayan', 'Tercihsiz']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                autofocus: true,
                controller: _gsmController,
                onSaved: (newValue) => password = newValue,
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
                onSaved: (newValue) => gsm = newValue,
                decoration: InputDecoration(
                  hintText: "E-Posta",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: () {
                  editUser(_userNameController.text, _nameController.text,
                      _surNameController.text, gsm, email, 1, 1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(
                                token: tokencomponent,
                              )));
                  Scaffold.of(context)
                      // ignore: deprecated_member_use
                      .showSnackBar(SnackBar(
                          content: Text("Kullanıcı Başarıyla Düzenlendi")));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
