import 'dart:convert';
import 'package:crm/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'profile_update.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProfileUpdate>? companyCall;
  profileUpdate(int userId, int genderId, String name, String surname,
      String userName, String gsm, String email) async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/person/update');
    final msg = jsonEncode({
      "id": userId,
      "gender_id": genderId,
      "name": name,
      "surname": surname,
      "username": userName,
      "gsm": gsm,
      "email": email
    });
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.body);
      var decode = jsonDecode(response.body);
      // companyCall = profileDatumApiDatasFromJson(jsonEncode(decode["data"]!));
    } else {
      print(response.reasonPhrase);
    }
  }

  String? name;
  String? surname;
  String? username;
  String? gsm;
  String? email;

  List<ProfilePerson>? profilePerson;
  getPerson(int userid) async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/person/getlistbyid');
    final msg = jsonEncode({"id": useridcomponent.toString()});
    var response = await http.post(url,
        body: msg,
        headers: {'token': tokencomponent, 'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = json.decode(response.body);
      name = decode["data"][0]["name"].toString();
      surname = decode["data"][0]["surname"].toString();
      username = decode["data"][0]["username"].toString();
      gsm = decode["data"][0]["gsm"].toString();
      email = decode["data"][0]["email"].toString();
      _nameController.text = name!;
      _surnameController.text = surname!;
      _usernameController.text = username!;
      _gsmController.text = gsm!;
      _emailController.text = email!;
      // profilePerson =
      //     profilePersonDatumApiDatasFromJson(jsonEncode(decode["data"]!));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getPerson(useridcomponent);
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _gsmController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String dropdownValue = 'Erkek';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Profili Düzenle",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Text(
                "Ad",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ad',
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Soyad",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _surnameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Soyad',
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Kullanıcı Adı",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kullanıcı Adı',
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Cinsiyet",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 20),
              Text(
                "GSM",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _gsmController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'GSM',
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: size.width * 0.6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: () {
                          profileUpdate(
                              useridcomponent,
                              gendercomponent,
                              _nameController.text,
                              _surnameController.text,
                              _usernameController.text,
                              _gsmController.text,
                              _emailController.text);
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                        color: kPrimaryColor,
                        child: Text(
                          "Güncelle",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
