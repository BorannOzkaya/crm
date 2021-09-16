import 'package:crm/screens/Genel_Rapor_Grafi%C4%9Fi/%C3%9Clke_rapor_grafigi.dart';
import 'package:crm/screens/Genel_Rapor_Grafi%C4%9Fi/genel_rapor_grafigi.dart';
import 'package:crm/screens/Previous_interview/previous_interview.dart';
import 'package:crm/screens/Sign_Screen/sign_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'home.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: Text(
              'CRM-SR',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home_outlined),
                SizedBox(width: 10),
                const Text('Anasayfa'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(
                            token: tokencomponent,
                          )));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.replay_outlined),
                SizedBox(width: 10),
                const Text('Geçmiş Randevular'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => GecmisRandevular()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.analytics_outlined),
                SizedBox(width: 10),
                const Text('Genel Rapor Grafiği'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => GenelRaporGrafigi()));
            },
          ),
          // if(admin == true) {}else{},
          ListTile(
            title: Row(
              children: [
                Icon(Icons.analytics_outlined),
                SizedBox(width: 10),
                const Text('Ülke Rapor Grafiği'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          // UlkeRaporGrafigi()
                          UlkeRaporGrafigi()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.account_tree_outlined),
                SizedBox(width: 10),
                const Text('Paketler'),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                const Text('Çıkış Yap'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignInScreen()));
            },
          ),
          SizedBox(height: size.height * 0.22),
          ListTile(
            title: Row(
              children: [
                const Text('Version 1.0'),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
