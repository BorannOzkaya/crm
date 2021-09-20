import 'dart:convert';

import 'package:crm/model/countries_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class UlkeRaporGrafigi extends StatefulWidget {
  const UlkeRaporGrafigi({Key? key}) : super(key: key);

  @override
  _UlkeRaporGrafigiState createState() => _UlkeRaporGrafigiState();
}

class _UlkeRaporGrafigiState extends State<UlkeRaporGrafigi> {
  List<CountriesDatum> statusCount = <CountriesDatum>[];
  List<CountriesDatum> statusCountDisplay = <CountriesDatum>[];
  getCountries() async {
    var url = Uri.parse('https://crmsr.pen.com.tr/api/country/getlist');
    var response = await http.post(url, headers: {'token': tokencomponent});

    if (response.statusCode == 200) {
      //print(response.body);
      var decode = jsonDecode(response.body);
      statusCount = ulkelerFromJson(jsonEncode(decode["data"]));
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getCountries().then((value) {
      setState(() {
        statusCount.addAll(value);
        statusCountDisplay = statusCount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF284269),
          title: RichText(
            text: TextSpan(
                text: 'PEN ',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: 'CRM-SR', style: TextStyle(color: Colors.white))
                ]),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text(
                      "Ülkeye Göre Grafik Raporu",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text("Ülke ismi giriniz \nSeçmek için basılı tutun",
                        textAlign: TextAlign.center)
                  ],
                ),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                  child: Container(
                      height: size.height * 0.55,
                      //color: Colors.blue,
                      child: ListView.builder(
                          itemCount: statusCountDisplay.length + 1,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? _searchBar()
                                : _listItem(index - 1);
                          }))),
            ],
          ),
        ));
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Ara...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            statusCountDisplay = statusCount.where((note) {
              var noteTitle = note.countryName.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  int selectedIndex = 0;
  bool selected = false;
  String? dateValue;

  _listItem(index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Card(
        shape: selected
            ? new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(40.0))
            : new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(40.0)),
        color: kPrimaryLightColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    statusCountDisplay[index].countryName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Checkbox(
                          value: selected,
                          onChanged: (value) {
                            selectedIndex = statusCountDisplay[index].id;
                            print(selectedIndex);
                            setState(() {
                              selected = value!;
                            });
                          })
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData({required this.x, required this.y, required this.color});
  final String x;
  final double y;
  final Color color;
}


// Padding(
              //   padding: const EdgeInsets.only(top: 0),
              //   child: FutureBuilder(
              //     future: Future.delayed(Duration(seconds: 1)),
              //     builder: (c, s) => s.connectionState == ConnectionState.done
              //         ? Column(
              //             children: [
              //               Container(
              //                   child: SfCircularChart(
              //                       legend: Legend(isVisible: true),
              //                       series: <CircularSeries>[
              //                     PieSeries<ChartData, String>(
              //                         enableTooltip: true,
              //                         dataSource: chartData,
              //                         pointColorMapper: (ChartData data, _) =>
              //                             data.color,
              //                         xValueMapper: (ChartData data, _) =>
              //                             data.x,
              //                         yValueMapper: (ChartData data, _) =>
              //                             data.y,
              //                         radius: '100%',
              //                         explode: true,
              //                         explodeIndex: 1,
              //                         dataLabelSettings:
              //                             DataLabelSettings(isVisible: true))
              //                   ])),
              //             ],
              //           )
              //         : Center(child: CircularProgressIndicator()),
              //   ),
              // ),