import 'dart:convert';

import 'package:crm/screens/Home_Page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import '../../constants.dart';
import 'sign_screen.dart';

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _passwordController = TextEditingController();
  var _usernameController = TextEditingController();

  String textToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  bool status = false;
  String? token;
  String? message;
  int? userid;
  int? genderid;

  getLogin(String userName, String password) async {
    var headers = {
      'token': 'F6824456A456CAD624A02233BD7DD5D0',
      'Content-Type': 'application/json'
    };
    final msg = jsonEncode({"username": userName, "password": password});
    var response = await http.post(
        Uri.parse('https://crmsr.pen.com.tr/api/person/login'),
        body: msg,
        headers: headers);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      status = decode["status"];
      token = decode["data"]["token"];
      message = decode["message"];
      userid = decode["data"]["id"];
      genderid = decode["data"]["gender_id"];
      // user = decode["data"]["username"]!;
      // password = decode["data"]["password"]!;
      tokencomponent = token.toString();
      gendercomponent = genderid!;
      useridcomponent = userid!;
      // status = loginApiDatasFromJson(jsonEncode(decode["data"]));
      print(token);
      print(message);
      print(userid);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    // getlogin("", "").whencomplete(() {
    //   setstate(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text(
              "Hesabınıza Giriş Yapınız",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 125),
          UserNameTextFormField(
              size: size, usernameController: _usernameController),
          PasswordTextFormField(
              size: size, passwordController: _passwordController),
          SizedBox(height: 30),
          Container(
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              // ignore: deprecated_member_use
              child: FlatButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Yönlendiriliyor..."),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                              content: Container(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          color: kPrimaryColor))));
                        });
                    getLogin(_usernameController.text, _passwordController.text)
                        .whenComplete(() {
                      if (status == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomePage(
                            token: tokencomponent,
                          );
                        }));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FutureBuilder(
                                future: Future.delayed(Duration(seconds: 1)),
                                builder: (c, s) => s.connectionState ==
                                        ConnectionState.done
                                    ? AlertDialog(
                                        title: Text("Başarısız"),
                                        content: TextButton(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                                return SignInScreen();
                                              }));
                                              //Navigator.pop(context);
                                            },
                                            child: Text("OK")),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
                              );
                            });
                        setState(() {});
                        print("Giriş Başarısız");
                      }
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Color(0xFF284269),
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

bool obscuretext = true;

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    required this.size,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final Size size;
  final TextEditingController _passwordController;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: widget.size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextFormField(
          controller: widget._passwordController,
          onSaved: (value) {
            value = widget._passwordController.text;
          },
          obscureText: obscuretext,
          decoration: InputDecoration(
              hintText: "Şifre",
              icon: Icon(
                Icons.lock,
                color: Color(0xFF284269),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscuretext = !obscuretext;
                  });
                },
                icon: Icon(
                  Icons.visibility,
                  color: Color(0xFF284269),
                ),
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class UserNameTextFormField extends StatelessWidget {
  const UserNameTextFormField({
    Key? key,
    required this.size,
    required TextEditingController usernameController,
  })  : _usernameController = usernameController,
        super(key: key);

  final Size size;
  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextFormField(
          controller: _usernameController,
          onSaved: (value) {
            _usernameController.text = value!;
          },
          decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Color(0xFF284269),
              ),
              hintText: "Kullanıcı Adı",
              border: InputBorder.none),
        ),
      ),
    );
  }
}
