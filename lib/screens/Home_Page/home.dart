import 'package:crm/constants.dart';
import 'package:crm/screens/Bayi_Screen/bayi.dart';
import 'package:crm/screens/Companies_Screen/companies.dart';
import 'package:crm/screens/Genel_Rapor_Grafi%C4%9Fi/%C3%9Clke_rapor_grafigi.dart';
import 'package:crm/screens/Genel_Rapor_Grafi%C4%9Fi/genel_rapor_grafigi.dart';
import 'package:crm/screens/Meeting_Screen/meeting_screen.dart';
import 'package:crm/screens/Previous_interview/previous_interview.dart';
import 'package:crm/screens/Profile_Screen/profile.dart';
import 'package:crm/screens/Sign_Screen/sign_screen.dart';
import 'package:flutter/material.dart';
import 'body.dart';

class HomePage extends StatefulWidget {
  String? token;

  HomePage({Key? key, required this.token}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashBoardScreen(
    token: tokencomponent,
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: RichText(
          text: TextSpan(
              text: 'PEN ',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: 'CRM-SR', style: TextStyle(color: Colors.white))
              ]),
        ),
      ),
      drawer: Drawer(
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
                        builder: (BuildContext context) =>
                            GenelRaporGrafigi()));
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.date_range),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MeetingScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = DashBoardScreen(
                          token: '',
                        );
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          "Anasayfa",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? kPrimaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Companies();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_city,
                          color: currentTab == 1 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          "Firmalar",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? kPrimaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = BayiScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cases_rounded,
                          color: currentTab == 2 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          "Bayiler",
                          style: TextStyle(
                              color: currentTab == 2
                                  ? kPrimaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? kPrimaryColor : Colors.grey,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: currentTab == 3
                                  ? kPrimaryColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
