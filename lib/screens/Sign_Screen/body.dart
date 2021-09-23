import 'dart:convert';

import 'package:crm/screens/Home_Page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../constants.dart';
import '../../wave_widget.dart';
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
  bool admincontrol = false;

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
      admincontrol = decode["data"]["is_admin"];
      // user = decode["data"]["username"]!;
      // password = decode["data"]["password"]!;
      tokencomponent = token.toString();
      gendercomponent = genderid!;
      useridcomponent = userid!;
      admincontroller = admincontrol;
      // status = loginApiDatasFromJson(jsonEncode(decode["data"]));
      print(token);
      print(message);
      print(userid);
      print(admincontrol);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Stack(
      children: <Widget>[
        Container(height: size.height - 200, color: Color(0xFF284269)),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
          top: keyboardOpen ? -size.height / 3.7 : 0.0,
          child: WaveWidget(
            size: size,
            yOffset: size.height / 3.0,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'PEN',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('CRM-SR',
                      style: TextStyle(color: Colors.white, fontSize: 45))
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            UserNameTextFormField(
                size: size, usernameController: _usernameController),
            PasswordTextFormField(
                size: size, passwordController: _passwordController),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(height: 20.0),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () async {
                      getLogin(_usernameController.text,
                              _passwordController.text)
                          .whenComplete(() {
                        if (status == true) {
                          AwesomeDialog(
                              context: context,
                              animType: AnimType.LEFTSLIDE,
                              headerAnimationLoop: false,
                              dialogType: DialogType.SUCCES,
                              showCloseIcon: true,
                              btnOkText: 'Tamam',
                              title: 'Giriş Başarılı',
                              btnOkOnPress: () {
                                debugPrint('OnClcik');
                              },
                              btnOkIcon: Icons.check_circle,
                              onDissmissCallback: (type) {
                                debugPrint(
                                    'Dialog Dissmiss from callback $type');
                              })
                            ..show().whenComplete(() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return HomePage(
                                  token: tokencomponent,
                                );
                              }));
                            });
                        } else {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              headerAnimationLoop: true,
                              animType: AnimType.TOPSLIDE,
                              showCloseIcon: false,
                              btnOkColor: Colors.red,
                              btnOkText: 'Tamam',
                              title: 'Hata',
                              desc: 'Kullanıcı Adı veya Şifre Hatalı',
                              onDissmissCallback: (type) {
                                debugPrint(
                                    'Dialog Dissmiss from callback $type');
                              },
                              btnOkOnPress: () {})
                            ..show();
                        }
                      });
                    },
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Color(0xFF284269),
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ],
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
